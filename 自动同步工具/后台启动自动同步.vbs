Set shell = CreateObject("WScript.Shell")
shell.CurrentDirectory = "D:\Code\05_git"
shell.Run "powershell.exe -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File ""D:\Code\05_git\自动同步工具\auto-sync.ps1""", 0, False
