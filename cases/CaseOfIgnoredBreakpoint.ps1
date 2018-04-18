# What if a breakpoint get's ignored?

Import-Module "$env:CaseOfTheUnexplainedPath\cases\IgnoredBreakpoint\IgnoredBreakpoint.psd1" -Force
psedit "$((Get-Module IgnoredBreakpoint).ModuleBase)\Debug-Function.ps1"

# Now set a breakpoint
Set-PSBreakpoint -Script "$((Get-Module IgnoredBreakpoint).ModuleBase)\Debug-Function.ps1" -Line 10

Debug-Function

# For DebugPx, we also need SnippetPx installed
Import-Module DebugPx

function Debug-FunctionPx {

    [CmdletBinding()]
    param (
        # The number of tasks on which to invoke the debugger
        [int]$TaskDebugCount = 200
    )

    $tasks = Get-ScheduledTask
    $result = $tasks | ForEach-Object {
        Get-ScheduledTaskInfo -TaskName $_.TaskName -TaskPath $_.TaskPath
    }

    ifdebug {
        Write-Debug "Total number of tasks: $($tasks.count)"
        $failedtasks = $result | Where-Object {$_.LastTaskResult -ne 0}
        $failedtasks | Format-Table -AutoSize | Out-String | Write-Debug 
    }

    breakpoint {
        $tasks.count -ge $TaskDebugCount
    }
}

# Support for inline breakpoints (which can also be conditional)
Debug-FunctionPx -TaskDebugCount 50

# DebugPx also helps with -Debug output
Debug-FunctionPx -Debug

# This also supports breakpoints in the pipeline (Shift+F5 to get out of this one)
Get-Process | Where-Object {$_.WorkingSet -ge 50000} | Breakpoint | ForEach-Object{$_.StartTime}

# DebugPx is also able to peek inside the module scope
Debug-Module -Name IgnoredBreakpoint

# Look at variable inside module scope
Get-Variable -Name IgnoredBreakpointVariable

# And lot's more, check out the session Become a PowerShell Debugging Ninja by Kirk Munro!