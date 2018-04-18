Function Open-Case {
    
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory)]
        [ValidateSet(
            'ImportCsv', 
            'SlowProgress', 
            'SlowArray', 
            'FailingScheduledTask', 
            'AutoGeneratingCode', 
            'ConfiguringSwitch', 
            'ErrorActionSilentlyContinueIgnored', 
            'OutOfScope', 
            'VariableScope', 
            'PSDrivePathNotFound', 
            'WireShark',
            'IgnoredBreakpoint'
        )]
        [string]$Name
    )

    $fullPath = Get-CaseFullPath $Name

    if(-not($openFile = $psISE.CurrentPowerShellTab.Files | Where-Object {$_.FullPath -eq $fullPath})) {
        $null = $psISE.CurrentPowerShellTab.Files.Add($fullPath)
    }
    else {
        $null = $psISE.CurrentPowerShellTab.Files.SetSelectedFile($openFile)
    }
}