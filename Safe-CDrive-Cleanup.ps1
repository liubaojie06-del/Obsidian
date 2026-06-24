<#
.SYNOPSIS
Safely reports and cleans user-scoped space on C:.

.DESCRIPTION
This script is intentionally conservative. It only scans safe user locations on
C: and only cleans temporary files, browser caches, and the C: recycle bin after
an explicit confirmation prompt. Downloads are reported only and are never
deleted by this script.

It never targets C:\Windows, Program Files, Program Files (x86), ProgramData,
the registry, drivers, or system-wide application folders.

.PARAMETER DryRun
Preview cleanup actions and write them to the log without deleting anything.

.PARAMETER StaleDays
Only temporary/cache files older than this many days are considered for cleanup.
Downloads older than this are listed in the report only.

.PARAMETER Top
Number of largest folders/files to include in the report.

.PARAMETER ReportPath
Where to save the generated space usage report.

.PARAMETER LogPath
Where to save the cleanup log.

.EXAMPLE
.\Safe-CDrive-Cleanup.ps1 -DryRun

.EXAMPLE
.\Safe-CDrive-Cleanup.ps1 -StaleDays 45 -Top 30
#>

[CmdletBinding()]
param(
    [switch]$DryRun,

    [ValidateRange(1, 3650)]
    [int]$StaleDays = 30,

    [ValidateRange(1, 100)]
    [int]$Top = 20,

    [string]$ReportPath = (Join-Path $env:USERPROFILE ("Desktop\SafeCDriveCleanup-Report-{0}.txt" -f (Get-Date -Format "yyyyMMdd-HHmmss"))),

    [string]$LogPath = (Join-Path $env:USERPROFILE ("Desktop\SafeCDriveCleanup-DeleteLog-{0}.log" -f (Get-Date -Format "yyyyMMdd-HHmmss")))
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$Cutoff = (Get-Date).AddDays(-1 * $StaleDays)
$ScriptStart = Get-Date

function Convert-BytesToReadable {
    param([long]$Bytes)

    if ($Bytes -ge 1TB) { return "{0:N2} TB" -f ($Bytes / 1TB) }
    if ($Bytes -ge 1GB) { return "{0:N2} GB" -f ($Bytes / 1GB) }
    if ($Bytes -ge 1MB) { return "{0:N2} MB" -f ($Bytes / 1MB) }
    if ($Bytes -ge 1KB) { return "{0:N2} KB" -f ($Bytes / 1KB) }
    return "$Bytes B"
}

function Normalize-FullPath {
    param([Parameter(Mandatory)][string]$Path)
    return ([System.IO.Path]::GetFullPath($Path)).TrimEnd("\")
}

function Test-IsOnCDrive {
    param([Parameter(Mandatory)][string]$Path)

    try {
        $fullPath = Normalize-FullPath -Path $Path
        return ([System.IO.Path]::GetPathRoot($fullPath) -ieq "C:\")
    }
    catch {
        return $false
    }
}

$BlockedRoots = @(
    "C:\Windows",
    "C:\Program Files",
    "C:\Program Files (x86)",
    "C:\ProgramData",
    $env:SystemRoot,
    $env:ProgramFiles,
    ${env:ProgramFiles(x86)},
    $env:ProgramData
) | Where-Object { -not [string]::IsNullOrWhiteSpace($_) } |
    ForEach-Object {
        try { Normalize-FullPath -Path $_ } catch { $null }
    } |
    Where-Object { $_ } |
    Sort-Object -Unique

function Test-IsBlockedPath {
    param([Parameter(Mandatory)][string]$Path)

    try {
        $fullPath = Normalize-FullPath -Path $Path
        foreach ($blocked in $BlockedRoots) {
            if ($fullPath -ieq $blocked -or $fullPath.StartsWith("$blocked\", [System.StringComparison]::OrdinalIgnoreCase)) {
                return $true
            }
        }
    }
    catch {
        return $true
    }

    return $false
}

function Test-IsUnderAllowedRoot {
    param(
        [Parameter(Mandatory)][string]$Path,
        [Parameter(Mandatory)][string[]]$AllowedRoots
    )

    try {
        $fullPath = Normalize-FullPath -Path $Path
        foreach ($root in $AllowedRoots) {
            $safeRoot = Normalize-FullPath -Path $root
            if ($fullPath -ieq $safeRoot -or $fullPath.StartsWith("$safeRoot\", [System.StringComparison]::OrdinalIgnoreCase)) {
                return $true
            }
        }
    }
    catch {
        return $false
    }

    return $false
}

function Ensure-ParentDirectory {
    param([Parameter(Mandatory)][string]$Path)

    $parent = Split-Path -Parent $Path
    if (-not [string]::IsNullOrWhiteSpace($parent) -and -not (Test-Path -LiteralPath $parent)) {
        New-Item -ItemType Directory -Path $parent -Force | Out-Null
    }
}

function Write-CleanupLog {
    param(
        [Parameter(Mandatory)][string]$Action,
        [Parameter(Mandatory)][string]$Status,
        [string]$Path = "",
        [string]$Message = ""
    )

    try {
        $cleanMessage = ($Message -replace "(`r`n|`n|`r)", " ")
        $line = "{0}`t{1}`t{2}`t{3}`t{4}" -f (Get-Date -Format "o"), $Action, $Status, $Path, $cleanMessage
        Add-Content -LiteralPath $LogPath -Value $line -Encoding UTF8
    }
    catch {
        Write-Warning "Failed to write cleanup log: $($_.Exception.Message)"
    }
}

function Get-ExistingSafeDirectory {
    param(
        [Parameter(Mandatory)][string]$Label,
        [Parameter(Mandatory)][string]$Path
    )

    if ([string]::IsNullOrWhiteSpace($Path)) {
        return $null
    }

    try {
        $item = Get-Item -LiteralPath $Path -Force -ErrorAction Stop
        if (-not $item.PSIsContainer) {
            return $null
        }

        $fullPath = Normalize-FullPath -Path $item.FullName
        if ((Test-IsOnCDrive -Path $fullPath) -and -not (Test-IsBlockedPath -Path $fullPath)) {
            return [pscustomobject]@{
                Label = $Label
                Path  = $fullPath
            }
        }
    }
    catch {
        return $null
    }

    return $null
}

function Get-DirectoryMatches {
    param([Parameter(Mandatory)][string[]]$Patterns)

    foreach ($pattern in $Patterns) {
        if ([string]::IsNullOrWhiteSpace($pattern)) {
            continue
        }

        try {
            if ($pattern.Contains("*") -or $pattern.Contains("?")) {
                Get-ChildItem -Path $pattern -Directory -Force -ErrorAction SilentlyContinue |
                    Where-Object { -not ($_.Attributes -band [System.IO.FileAttributes]::ReparsePoint) } |
                    ForEach-Object { $_.FullName }
            }
            else {
                $item = Get-Item -LiteralPath $pattern -Force -ErrorAction SilentlyContinue
                if ($item -and $item.PSIsContainer) {
                    $item.FullName
                }
            }
        }
        catch {
            Write-Verbose "Skipping pattern '$pattern': $($_.Exception.Message)"
        }
    }
}

function Measure-SafeDirectory {
    param([Parameter(Mandatory)][string]$Path)

    $bytes = 0L
    $fileCount = 0L

    try {
        Get-ChildItem -LiteralPath $Path -Recurse -Force -File -Attributes !ReparsePoint -ErrorAction SilentlyContinue |
            ForEach-Object {
                $bytes += $_.Length
                $fileCount++
            }
    }
    catch {
        Write-Verbose "Could not fully measure '$Path': $($_.Exception.Message)"
    }

    return [pscustomobject]@{
        Path      = $Path
        Bytes     = $bytes
        Size      = Convert-BytesToReadable -Bytes $bytes
        FileCount = $fileCount
    }
}

function Get-LargestSafeFiles {
    param(
        [Parameter(Mandatory)][object[]]$Roots,
        [Parameter(Mandatory)][int]$Limit
    )

    $files = New-Object System.Collections.Generic.List[object]

    foreach ($root in $Roots) {
        try {
            Get-ChildItem -LiteralPath $root.Path -Recurse -Force -File -Attributes !ReparsePoint -ErrorAction SilentlyContinue |
                ForEach-Object {
                    $files.Add([pscustomobject]@{
                        Path          = $_.FullName
                        Bytes         = $_.Length
                        Size          = Convert-BytesToReadable -Bytes $_.Length
                        LastWriteTime = $_.LastWriteTime
                    })
                }
        }
        catch {
            Write-Verbose "Could not fully list files under '$($root.Path)': $($_.Exception.Message)"
        }
    }

    return $files | Sort-Object Bytes -Descending | Select-Object -First $Limit
}

function Get-LargestSafeFolders {
    param(
        [Parameter(Mandatory)][object[]]$Roots,
        [Parameter(Mandatory)][int]$Limit
    )

    $folderCandidates = New-Object System.Collections.Generic.List[object]

    foreach ($root in $Roots) {
        $folderCandidates.Add([pscustomobject]@{
            Label = $root.Label
            Path  = $root.Path
        })

        try {
            Get-ChildItem -LiteralPath $root.Path -Directory -Force -Attributes !ReparsePoint -ErrorAction SilentlyContinue |
                ForEach-Object {
                    $folderCandidates.Add([pscustomobject]@{
                        Label = "$($root.Label) child"
                        Path  = $_.FullName
                    })
                }
        }
        catch {
            Write-Verbose "Could not list child folders under '$($root.Path)': $($_.Exception.Message)"
        }
    }

    $measured = foreach ($folder in ($folderCandidates | Sort-Object Path -Unique)) {
        Measure-SafeDirectory -Path $folder.Path
    }

    return $measured | Sort-Object Bytes -Descending | Select-Object -First $Limit
}

function Get-StaleDownloadFiles {
    param(
        [Parameter(Mandatory)][string]$DownloadsPath,
        [Parameter(Mandatory)][datetime]$OlderThan
    )

    if (-not (Test-Path -LiteralPath $DownloadsPath)) {
        return @()
    }

    try {
        return Get-ChildItem -LiteralPath $DownloadsPath -Recurse -Force -File -Attributes !ReparsePoint -ErrorAction SilentlyContinue |
            Where-Object { $_.LastWriteTime -lt $OlderThan } |
            Sort-Object LastWriteTime |
            Select-Object FullName, LastWriteTime, @{Name = "Size"; Expression = { Convert-BytesToReadable -Bytes $_.Length } }, Length
    }
    catch {
        Write-Warning "Could not list downloads: $($_.Exception.Message)"
        return @()
    }
}

function Test-IsSafeCleanupPath {
    param(
        [Parameter(Mandatory)][string]$Path,
        [Parameter(Mandatory)][string[]]$AllowedRoots
    )

    if (-not (Test-IsOnCDrive -Path $Path)) {
        return $false
    }

    if (Test-IsBlockedPath -Path $Path) {
        return $false
    }

    if (-not (Test-IsUnderAllowedRoot -Path $Path -AllowedRoots $AllowedRoots)) {
        return $false
    }

    return $true
}

function Remove-SafeFile {
    param(
        [Parameter(Mandatory)][System.IO.FileInfo]$File,
        [Parameter(Mandatory)][string[]]$AllowedRoots
    )

    $path = $File.FullName
    $bytes = $File.Length

    if (-not (Test-IsSafeCleanupPath -Path $path -AllowedRoots $AllowedRoots)) {
        Write-CleanupLog -Action "DELETE_FILE" -Status "SKIPPED_UNSAFE_PATH" -Path $path
        return 0L
    }

    if ($File.Attributes -band [System.IO.FileAttributes]::ReparsePoint) {
        Write-CleanupLog -Action "DELETE_FILE" -Status "SKIPPED_REPARSE_POINT" -Path $path
        return 0L
    }

    if ($DryRun) {
        Write-CleanupLog -Action "DELETE_FILE" -Status "DRY_RUN" -Path $path -Message (Convert-BytesToReadable -Bytes $bytes)
        return 0L
    }

    try {
        Remove-Item -LiteralPath $path -Force -ErrorAction Stop
        Write-CleanupLog -Action "DELETE_FILE" -Status "DELETED" -Path $path -Message (Convert-BytesToReadable -Bytes $bytes)
        return $bytes
    }
    catch {
        Write-CleanupLog -Action "DELETE_FILE" -Status "ERROR" -Path $path -Message $_.Exception.Message
        return 0L
    }
}

function Remove-EmptySafeDirectory {
    param(
        [Parameter(Mandatory)][System.IO.DirectoryInfo]$Directory,
        [Parameter(Mandatory)][string[]]$AllowedRoots
    )

    $path = $Directory.FullName

    if (-not (Test-IsSafeCleanupPath -Path $path -AllowedRoots $AllowedRoots)) {
        Write-CleanupLog -Action "DELETE_EMPTY_DIRECTORY" -Status "SKIPPED_UNSAFE_PATH" -Path $path
        return
    }

    if ($Directory.Attributes -band [System.IO.FileAttributes]::ReparsePoint) {
        Write-CleanupLog -Action "DELETE_EMPTY_DIRECTORY" -Status "SKIPPED_REPARSE_POINT" -Path $path
        return
    }

    try {
        $hasChildren = Get-ChildItem -LiteralPath $path -Force -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($hasChildren) {
            return
        }

        if ($DryRun) {
            Write-CleanupLog -Action "DELETE_EMPTY_DIRECTORY" -Status "DRY_RUN" -Path $path
            return
        }

        Remove-Item -LiteralPath $path -Force -ErrorAction Stop
        Write-CleanupLog -Action "DELETE_EMPTY_DIRECTORY" -Status "DELETED" -Path $path
    }
    catch {
        Write-CleanupLog -Action "DELETE_EMPTY_DIRECTORY" -Status "ERROR" -Path $path -Message $_.Exception.Message
    }
}

function Clear-SafeDirectoryContents {
    param(
        [Parameter(Mandatory)][string]$Path,
        [Parameter(Mandatory)][string[]]$AllowedRoots,
        [Parameter(Mandatory)][datetime]$OlderThan
    )

    $freedBytes = 0L

    if (-not (Test-IsSafeCleanupPath -Path $Path -AllowedRoots $AllowedRoots)) {
        Write-CleanupLog -Action "CLEAN_DIRECTORY" -Status "SKIPPED_UNSAFE_ROOT" -Path $Path
        return 0L
    }

    Write-CleanupLog -Action "CLEAN_DIRECTORY" -Status "STARTED" -Path $Path -Message "Deleting files older than $OlderThan"

    try {
        Get-ChildItem -LiteralPath $Path -Recurse -Force -File -Attributes !ReparsePoint -ErrorAction SilentlyContinue |
            Where-Object { $_.LastWriteTime -lt $OlderThan } |
            ForEach-Object {
                $freedBytes += Remove-SafeFile -File $_ -AllowedRoots $AllowedRoots
            }
    }
    catch {
        Write-CleanupLog -Action "CLEAN_DIRECTORY" -Status "ERROR_LISTING_FILES" -Path $Path -Message $_.Exception.Message
    }

    try {
        Get-ChildItem -LiteralPath $Path -Recurse -Force -Directory -Attributes !ReparsePoint -ErrorAction SilentlyContinue |
            Sort-Object { $_.FullName.Length } -Descending |
            ForEach-Object {
                Remove-EmptySafeDirectory -Directory $_ -AllowedRoots $AllowedRoots
            }
    }
    catch {
        Write-CleanupLog -Action "CLEAN_DIRECTORY" -Status "ERROR_LISTING_DIRECTORIES" -Path $Path -Message $_.Exception.Message
    }

    Write-CleanupLog -Action "CLEAN_DIRECTORY" -Status "FINISHED" -Path $Path -Message "Freed $(Convert-BytesToReadable -Bytes $freedBytes)"
    return $freedBytes
}

function Clear-CDriveRecycleBinSafely {
    if ($DryRun) {
        Write-CleanupLog -Action "CLEAR_RECYCLE_BIN" -Status "DRY_RUN" -Path 'C:\$Recycle.Bin'
        return
    }

    try {
        $command = Get-Command Clear-RecycleBin -ErrorAction SilentlyContinue
        if (-not $command) {
            Write-CleanupLog -Action "CLEAR_RECYCLE_BIN" -Status "SKIPPED" -Path 'C:\$Recycle.Bin' -Message "Clear-RecycleBin command is unavailable."
            return
        }

        Clear-RecycleBin -DriveLetter C -Force -ErrorAction Stop
        Write-CleanupLog -Action "CLEAR_RECYCLE_BIN" -Status "CLEARED" -Path 'C:\$Recycle.Bin'
    }
    catch {
        Write-CleanupLog -Action "CLEAR_RECYCLE_BIN" -Status "ERROR" -Path 'C:\$Recycle.Bin' -Message $_.Exception.Message
    }
}

$UserProfile = [Environment]::GetFolderPath("UserProfile")
$LocalAppData = [Environment]::GetFolderPath("LocalApplicationData")
$DownloadsPath = Join-Path $UserProfile "Downloads"

$safeScanCandidates = @(
    @{ Label = "Current user profile"; Path = $UserProfile },
    @{ Label = "Downloads"; Path = $DownloadsPath },
    @{ Label = "User temp"; Path = $env:TEMP },
    @{ Label = "User TMP"; Path = $env:TMP },
    @{ Label = "LocalAppData temp"; Path = (Join-Path $LocalAppData "Temp") }
)

$browserCachePatterns = @(
    (Join-Path $LocalAppData "Google\Chrome\User Data\*\Cache"),
    (Join-Path $LocalAppData "Google\Chrome\User Data\*\Code Cache"),
    (Join-Path $LocalAppData "Google\Chrome\User Data\*\GPUCache"),
    (Join-Path $LocalAppData "Microsoft\Edge\User Data\*\Cache"),
    (Join-Path $LocalAppData "Microsoft\Edge\User Data\*\Code Cache"),
    (Join-Path $LocalAppData "Microsoft\Edge\User Data\*\GPUCache"),
    (Join-Path $LocalAppData "BraveSoftware\Brave-Browser\User Data\*\Cache"),
    (Join-Path $LocalAppData "BraveSoftware\Brave-Browser\User Data\*\Code Cache"),
    (Join-Path $LocalAppData "BraveSoftware\Brave-Browser\User Data\*\GPUCache"),
    (Join-Path $LocalAppData "Mozilla\Firefox\Profiles\*\cache2"),
    (Join-Path $LocalAppData "Microsoft\Windows\INetCache")
)

$browserCachePaths = @(Get-DirectoryMatches -Patterns $browserCachePatterns)

foreach ($browserPath in $browserCachePaths) {
    $safeScanCandidates += @{ Label = "Browser cache"; Path = $browserPath }
}

$SafeScanRoots = @(
    @(
        foreach ($candidate in $safeScanCandidates) {
            Get-ExistingSafeDirectory -Label $candidate.Label -Path $candidate.Path
        }
    ) | Where-Object { $_ } | Sort-Object Path -Unique
)

$TempCleanupRoots = @(
    @(
        foreach ($candidate in @($env:TEMP, $env:TMP, (Join-Path $LocalAppData "Temp"))) {
            $safeDir = Get-ExistingSafeDirectory -Label "Temp cleanup" -Path $candidate
            if ($safeDir) { $safeDir.Path }
        }
    ) | Sort-Object -Unique
)

$BrowserCleanupRoots = @(
    @(
        foreach ($browserPath in $browserCachePaths) {
            $safeDir = Get-ExistingSafeDirectory -Label "Browser cache cleanup" -Path $browserPath
            if ($safeDir) { $safeDir.Path }
        }
    ) | Sort-Object -Unique
)

$CleanupRoots = @(
    @($TempCleanupRoots + $BrowserCleanupRoots) | Sort-Object -Unique
)

if (-not $SafeScanRoots -or $SafeScanRoots.Count -eq 0) {
    throw "No safe C: scan roots were found for the current user."
}

Ensure-ParentDirectory -Path $ReportPath
Ensure-ParentDirectory -Path $LogPath

"Timestamp`tAction`tStatus`tPath`tMessage" | Set-Content -LiteralPath $LogPath -Encoding UTF8
Write-CleanupLog -Action "SCRIPT" -Status "STARTED" -Path $PSCommandPath -Message "DryRun=$DryRun; StaleDays=$StaleDays; Top=$Top"

Write-Host "Generating space usage report. This may take a while for large user profiles..." -ForegroundColor Cyan

$largestFolders = @(Get-LargestSafeFolders -Roots $SafeScanRoots -Limit $Top)
$largestFiles = @(Get-LargestSafeFiles -Roots $SafeScanRoots -Limit $Top)
$staleDownloads = @(Get-StaleDownloadFiles -DownloadsPath $DownloadsPath -OlderThan $Cutoff)

$reportLines = New-Object System.Collections.Generic.List[string]
$reportLines.Add("Safe C: Drive Cleanup Report") | Out-Null
$reportLines.Add(("Generated: {0}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss"))) | Out-Null
$reportLines.Add(("Mode: {0}" -f ($(if ($DryRun) { "DRY-RUN / PREVIEW" } else { "LIVE CLEANUP AFTER CONFIRMATION" })))) | Out-Null
$reportLines.Add(("Stale threshold: files older than {0} days, before {1}" -f $StaleDays, $Cutoff)) | Out-Null
$reportLines.Add("") | Out-Null
$reportLines.Add("Safety boundaries:") | Out-Null
$reportLines.Add("- Scans only safe current-user locations on C:.") | Out-Null
$reportLines.Add("- Deletes only from user temp folders, detected browser cache folders, and C: recycle bin after confirmation.") | Out-Null
$reportLines.Add("- Downloads are listed only; this script never deletes them.") | Out-Null
$reportLines.Add("- Never targets Windows, Program Files, Program Files (x86), ProgramData, registry, drivers, or system-wide app folders.") | Out-Null
$reportLines.Add("") | Out-Null
$reportLines.Add("Safe scan roots:") | Out-Null
foreach ($root in $SafeScanRoots) {
    $reportLines.Add(("- {0}: {1}" -f $root.Label, $root.Path)) | Out-Null
}

$reportLines.Add("") | Out-Null
$reportLines.Add(("Largest folders in safe C: locations, top {0}:" -f $Top)) | Out-Null
foreach ($folder in $largestFolders) {
    $reportLines.Add(("{0,12}  {1,8} files  {2}" -f $folder.Size, $folder.FileCount, $folder.Path)) | Out-Null
}

$reportLines.Add("") | Out-Null
$reportLines.Add(("Largest files in safe C: locations, top {0}:" -f $Top)) | Out-Null
foreach ($file in $largestFiles) {
    $reportLines.Add(("{0,12}  {1:yyyy-MM-dd HH:mm}  {2}" -f $file.Size, $file.LastWriteTime, $file.Path)) | Out-Null
}

$reportLines.Add("") | Out-Null
$reportLines.Add(("Downloads older than {0} days, listed only and not deleted:" -f $StaleDays)) | Out-Null
if ($staleDownloads.Count -eq 0) {
    $reportLines.Add("- None found.") | Out-Null
}
else {
    foreach ($download in $staleDownloads) {
        $reportLines.Add(("{0,12}  {1:yyyy-MM-dd HH:mm}  {2}" -f $download.Size, $download.LastWriteTime, $download.FullName)) | Out-Null
    }
}

$reportLines.Add("") | Out-Null
$reportLines.Add("Cleanup targets after confirmation:") | Out-Null
if ($CleanupRoots.Count -eq 0) {
    $reportLines.Add("- No temp or browser cache cleanup roots found.") | Out-Null
}
else {
    foreach ($cleanupRoot in $CleanupRoots) {
        $reportLines.Add(("- Files older than {0} days under {1}" -f $StaleDays, $cleanupRoot)) | Out-Null
    }
}
$reportLines.Add("- C: recycle bin will be cleared after confirmation.") | Out-Null

$reportLines | Set-Content -LiteralPath $ReportPath -Encoding UTF8

Write-Host ""
Write-Host "Report saved to: $ReportPath" -ForegroundColor Green
Write-Host "Deletion log will be written to: $LogPath" -ForegroundColor Green
Write-Host ""
Write-Host "Planned cleanup:" -ForegroundColor Cyan
Write-Host "- Temp/cache files older than $StaleDays days in safe user locations."
Write-Host "- C: recycle bin."
Write-Host "- Downloads are report-only and will not be deleted."
Write-Host ""

if ($DryRun) {
    Write-Host "Dry-run is enabled. No files will be deleted." -ForegroundColor Yellow
}

$confirmation = Read-Host "Type YES to continue with $(if ($DryRun) { "the dry-run preview" } else { "cleanup" })"
if ($confirmation -cne "YES") {
    Write-CleanupLog -Action "SCRIPT" -Status "CANCELLED" -Path $PSCommandPath -Message "User did not type YES."
    Write-Host "Cancelled. No cleanup was performed." -ForegroundColor Yellow
    exit 0
}

$totalFreed = 0L

foreach ($cleanupRoot in $CleanupRoots) {
    $totalFreed += Clear-SafeDirectoryContents -Path $cleanupRoot -AllowedRoots $CleanupRoots -OlderThan $Cutoff
}

Clear-CDriveRecycleBinSafely

$duration = New-TimeSpan -Start $ScriptStart -End (Get-Date)
Write-CleanupLog -Action "SCRIPT" -Status "FINISHED" -Path $PSCommandPath -Message "File bytes freed: $(Convert-BytesToReadable -Bytes $totalFreed); Duration: $duration"

Write-Host ""
if ($DryRun) {
    Write-Host "Dry-run complete. Review the log for actions that would have been taken:" -ForegroundColor Green
}
else {
    Write-Host "Cleanup complete. Deleted file bytes, excluding recycle bin estimate: $(Convert-BytesToReadable -Bytes $totalFreed)" -ForegroundColor Green
}
Write-Host $LogPath
