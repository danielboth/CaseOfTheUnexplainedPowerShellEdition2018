# Case of self generating cases :)
$functionTemplate = @'
Function Get-{0}Process {
    [CmdletBinding()]
    Param (
        [Parameter()]
        [string]$ComputerName = '.'
    )

    $processes = Get-Process -Name {0} -ComputerName $ComputerName
    Write-Output $processes
}
'@

$functionTemplate -f 'PowerShell'

# That's a string, right? So what the -f?
$functionTemplate -f ([string]'PowerShell')




# Input string:
[string]::Format('{test}')


# Formatting string:
[string]::Format("This is a {0}", 'test')


# So how do we know we need to escape?
start iexplore 'https://msdn.microsoft.com/en-us/library/system.string.format(v=vs.110).aspx'


# Let's redefine the template:
$functionTemplate = @'
Function Get-{0}Process {{
    [CmdletBinding()]
    Param (
        [Parameter()]
        [string]$ComputerName = '.'
    )

    $processes = Get-Process -Name {0} -ComputerName $ComputerName
    Write-Output $processes
}}
'@

$function = $functionTemplate -f 'PowerShell'
$sb = [scriptblock]::Create($function)
. $sb

Get-PowerShellProcess

# So what if we want to insert code to insert code?
$parameterTemplate = @"
`t`t[Parameter({{0}})
`t`t[{0}]`${1}
"@

$functionTemplate = @'
Function Get-{0}Process {{{{
    [CmdletBinding()]
    Param (
{1}
    )

    $processes = Get-Process -Name {0} -ComputerName $ComputerName
    Write-Output $processes
}}}}
'@

$parameter = $parameterTemplate -f 'string','ComputerName'
$function = $functionTemplate -f 'PowerShell', $parameter

# A look at the function in it's current state:
$function

# Update parameter:
$function -f 'Mandatory'

