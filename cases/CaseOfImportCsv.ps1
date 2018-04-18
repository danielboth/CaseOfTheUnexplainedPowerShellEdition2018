# Item queried:
$patchStatus = Get-CimInstance -ClassName Win32_TerminalService

# We got an exit code:
$patchStatus.ExitCode

# So that means we can write:
If($patchStatus.ExitCode -eq 0) {
    "Patch status exit code is $($patchStatus.ExitCode)"
}

# We only want to reboot if the exit code is something else than 0, so we can write:
If($patchStatus.ExitCode){
    "Will skip over this: Patch status exit code is $($patchStatus.ExitCode)"
}

# That works because:
[int]0 -eq $false

# So to reboot the servers:
If($patchStatus.ExitCode){
    Restart-Computer -WhatIf
}

# Ok all set for the evening, saving the results for later use:
$patchStatus | Export-Csv -Path c:\temp\caseofimportcsv.csv -Force -NoTypeInformation
$patchStatus = $null


# Loading the data we previously exported:
$patchStatus = Import-Csv -Path c:\temp\caseofimportcsv.csv

# Let's have a look at our data:
$patchStatus.ExitCode

# Smart to double check right?
$patchStatus.ExitCode -eq [int]0

# So let's reboot the servers that need a reboot:
If($patchStatus.ExitCode){
    Restart-Computer -WhatIf
}

# OOPS! What happened?
$patchStatusCim = Get-CimInstance -ClassName Win32_TerminalService
$patchStatusCim.ExitCode 
$patchStatus.ExitCode

# Are they the same?
$patchStatusCim.ExitCode -eq $patchStatus.ExitCode

# Really?
$patchStatus.ExitCode -eq $patchStatusCim.ExitCode

# Or?
$patchStatus.ExitCode.GetType()
$patchStatusCim.ExitCode.GetType()

# So that means that:
[string]0 -eq [int]0

# But behaving differently:
[bool]$patchStatus.ExitCode
[bool]$patchStatusCim.ExitCode

# So what's going on here?
$testScript = {Trace-Command -Name TypeConversion -Expression { [string]0 -eq [int]0 | Out-Null } -PSHost}
PowerShell.exe -Command "& $testScript"

# Does it always work?
$testScript = {Trace-Command -Name TypeConversion -Expression { [int]0 -eq [timespan]0 | Out-Null } -PSHost}
PowerShell.exe -Command "& $testScript"

# Here we can also see that the conversion is right to left:
$testScript = {Trace-Command -Name TypeConversion -Expression { [timespan]0 -eq [int]0 | Out-Null } -PSHost}
PowerShell.exe -Command "& $testScript"

# How to prevent?
$patchStatusCim | ConvertTo-Json -Depth 2

$patchStatusCim | Export-Clixml -Path c:\temp\caseofimportcsv.xml 
Import-Clixml -Path c:\temp\caseofimportcsv.xml 


# If we still want to use CSV anyway
([int]$patchStatus.ExitCode).GetType()
[bool][int]$patchStatus.ExitCode

# That also triggers the TypeConversion
$testScript = {Trace-Command -Name TypeConversion -Expression { [int]'0' } -PSHost}
PowerShell.exe -Command "& $testScript"

# Sometimes, all these conversions lead to even funnier situations, what about:
@{} -match 'Hash'
@{ 1 = 'One';2 = 'Two' } -like '*Hash*'


@{}.ToString()

'System.Collections.Hashtable' -like '*Hash*'

# What about this?
@() -like '*Object*'

