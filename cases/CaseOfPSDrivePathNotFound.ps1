# Case of the PSDrive Path Not Found

New-PSDrive -Name PSConf -PSProvider FileSystem -Root c:\temp

Push-Location -Path PSConf:

# Works fine within PowerShell:
Get-ChildItem PSConf:*.log
Get-Content 'PSConf:\log.log'

# But what about this?
[System.IO.File]::ReadAllLines('PSConf:\log.log')

# Or:
[System.IO.File]::ReadAllBytes('.\log.log')

# PowerShell Drives only work within PowerShell. As soon as you call a .NET method it will require the full path. 
[System.IO.File]::ReadAllLines((Convert-Path 'PSConf:\log.log'))

# This also works:
$logfile = Get-ChildItem PSConf:*.log
[System.IO.File]::ReadAllLines($logfile)


# There is a bit more to the PSDrive magic though
Get-ChildItem -Exclude *.log

# Wait what?
Get-ChildItem -Path c:\temp -Exclude *.log

# So what's different?
Get-ChildItem -Path PSConf:\ -Exclude *.log

# We are not the only onces having issues getting it right:
& "$ENV:CaseOfTheUnexplainedPath\video\datastoreitem-psdrive.wmv"


# And remember, PSDrives are scoped too!
Function New-CustomDrive {
    New-PSDrive -Name TestDrive -PSProvider FileSystem -Root C:\temp
}

New-CustomDrive
Test-Path TestDrive:\

# That is easy fixed though
Function New-CustomDrive {
    New-PSDrive -Name TestDrive -PSProvider FileSystem -Root C:\temp -Scope 1
}

New-CustomDrive
Test-Path TestDrive:\

