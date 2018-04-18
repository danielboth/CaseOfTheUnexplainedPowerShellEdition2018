# Case of the failing Scheduled Task
Get-ScheduledTask -TaskName PSCONF -ErrorAction SilentlyContinue | Unregister-ScheduledTask -Confirm:$false
$taskAction = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument '-NoExit -File "C:\psconf\scheduled.ps1"'
$taskSettings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
$taskPrincipal = New-ScheduledTaskPrincipal -UserId 'NT AUTHORITY\SYSTEM'
$task = New-ScheduledTask -Action $taskAction -Settings $taskSettings -Principal $taskPrincipal
Register-ScheduledTask -TaskName 'PSCONF' -InputObject $task

# Get info on scheduled task
Get-ScheduledTask -TaskName PSCONF | Get-ScheduledTaskInfo

# Let's run the task
Get-ScheduledTask -TaskName PSCONF | Start-ScheduledTask

# What process did we just start?
Get-Process powershell | Sort-Object StartTime | Select-Object Id,StartTime

# Dive in
Enter-PSHostProcess -Id 3596Get-RunspaceDebug-Runspace -Id 1# Ok, next:psedit c:\psconf\scheduled.ps1Get-ScheduledTask -TaskName PSCONF | Unregister-ScheduledTask -Confirm:$false
$taskAction = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument '-NoExit -File C:\psconf\Start-PSScheduledScript.ps1 "c:\psconf\scheduled.ps1"'
$task = New-ScheduledTask -Action $taskAction -Settings $taskSettings -Principal $taskPrincipal
Register-ScheduledTask -TaskName 'PSCONF' -InputObject $task

# Get info on scheduled task
Get-ScheduledTask -TaskName PSCONF | Get-ScheduledTaskInfo

# Let's run the task
Get-ScheduledTask -TaskName PSCONF | Start-ScheduledTask

# What process did we just start?
Get-Process powershell | Sort-Object StartTime | Select-Object Id,StartTime

# Dive in
Enter-PSHostProcess -Id 18476Get-RunspaceDebug-Runspace -Id 2

# Even better?
psedit c:\psconf\scheduled-debug.ps1
Get-ScheduledTask -TaskName PSCONF | Unregister-ScheduledTask -Confirm:$false
$taskAction = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument '-NoExit -File C:\psconf\Start-PSScheduledScript.ps1 "c:\psconf\scheduled-debug.ps1" -DontInsertDebugCode'
$task = New-ScheduledTask -Action $taskAction -Settings $taskSettings -Principal $taskPrincipal
Register-ScheduledTask -TaskName 'PSCONF' -InputObject $task

# Get info on scheduled task
Get-ScheduledTask -TaskName PSCONF | Get-ScheduledTaskInfo

# Let's run the task
Get-ScheduledTask -TaskName PSCONF | Start-ScheduledTask

# Process just started
Get-Process powershell | Sort-Object StartTime | Select-Object Id,StartTime

# Dive in
Enter-PSHostProcess -Id 11676Get-RunspaceDebug-Runspace -Id 2


# One other gotcha's, single quotes:
Get-ScheduledTask -TaskName PSCONF | Unregister-ScheduledTask -Confirm:$false
$taskAction = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument "-File 'c:\psconf\scheduled-debug.ps1'"
$task = New-ScheduledTask -Action $taskAction -Settings $taskSettings -Principal $taskPrincipal
Register-ScheduledTask -TaskName 'PSCONF' -InputObject $task

Start-ScheduledTask -TaskName PSCONF

Get-ScheduledTaskInfo -TaskName PSCONF