<#
.Synopsis
   Wrapper script to start a script in a new runspace
.DESCRIPTION
   This script starts another PowerShell script in a new runspace so it can be debugged remotely.
.EXAMPLE
   .\Start-PSScheduledScript.ps1 -Path c:\psconf\scheduled.ps1

   Start the script scheduled.ps1 in a new runspace. If any errors are found in the script, the function will wait for a debugger to attach.
   The ErrorActionPrefence used is Stop.
.EXAMPLE
   .\Start-PSScheduledScript.ps1 -Path c:\psconf\scheduled.ps1 -DontInsertDebugCode

   Start the script scheduled.ps1 in a new runspace without implementing any extra error handling. The script is called as is.
#>

Param (
    # The path to the script to execute
    [Parameter(Mandatory)]
    [string]$Path,

    # Switch to specify if you have your own way of debugging implemented in your code. For example, you are calling Wait-Debugger in your own scripts.
    [switch]$DontInsertDebugCode
)

$newRunspace = [powershell]::Create([System.Management.Automation.RunspaceMode]::NewRunspace)

if(-not($DontInsertDebugCode)) {
    $script = [scriptblock]::Create(@"
        try {
            `$ErrorActionPreference = 'Stop'
            . $Path
        }
        catch {
            Wait-Debugger
            Write-Verbose "Error: `$_ - Wait for debugger"
        }
"@
    )

    $newRunspace.AddScript($script).Invoke()
}
else {
    $newRunspace.AddScript($Path).Invoke()
}