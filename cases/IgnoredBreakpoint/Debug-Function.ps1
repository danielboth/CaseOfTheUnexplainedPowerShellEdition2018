function Debug-Function {

    [CmdletBinding()]
    param (
        # Description of param
        [String]$ParamName
    )

    $tasks = Get-ScheduledTask
    $result = $tasks | ForEach-Object {
        Get-ScheduledTaskInfo -TaskName $_.TaskName -TaskPath $_.TaskPath
    }

    <#
    ifdebug {
        $result | Format-Table -AutoSize | Out-String | Write-Debug 
    }

    breakpoint {
        $tasks.count -ge 50
    }
    #>

}
