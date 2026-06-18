$ErrorActionPreference = "Stop"

$syncMutex = New-Object System.Threading.Mutex($false, "Global\05_git_auto_sync")
if (-not $syncMutex.WaitOne(0, $false)) {
    exit 0
}

Register-EngineEvent PowerShell.Exiting -Action {
    if ($script:syncMutex) {
        $script:syncMutex.ReleaseMutex()
        $script:syncMutex.Dispose()
    }
} | Out-Null

$repo = Split-Path -Parent $MyInvocation.MyCommand.Path
$git = "D:\App\APP_code\Git\cmd\git.exe"
$debounceSeconds = 8
$lastRun = Get-Date "2000-01-01"

function Invoke-GitSync {
    $now = Get-Date
    if (($now - $script:lastRun).TotalSeconds -lt $debounceSeconds) {
        return
    }

    $script:lastRun = $now

    Push-Location $repo
    try {
        $status = & $git status --porcelain
        if (-not $status) {
            return
        }

        & $git add .

        $statusAfterAdd = & $git status --porcelain
        if (-not $statusAfterAdd) {
            return
        }

        $message = "Auto sync $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
        & $git commit -m $message
        & $git -c http.proxy= -c https.proxy= push
    }
    finally {
        Pop-Location
    }
}

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $repo
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $true

$action = {
    $path = $Event.SourceEventArgs.FullPath
    if ($path -match "\\\.git\\") {
        return
    }
    Invoke-GitSync
}

Register-ObjectEvent $watcher Created -Action $action | Out-Null
Register-ObjectEvent $watcher Changed -Action $action | Out-Null
Register-ObjectEvent $watcher Deleted -Action $action | Out-Null
Register-ObjectEvent $watcher Renamed -Action $action | Out-Null

Write-Host "Auto sync is watching: $repo"
Write-Host "Keep this PowerShell window open. Press Ctrl+C to stop."

Invoke-GitSync

while ($true) {
    Start-Sleep -Seconds 1
}
