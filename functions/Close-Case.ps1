Function Close-Case {
    [CmdletBinding()]
    Param (
        [Parameter()]
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

    if($Name) {
        $fullPath = Get-CaseFullPath -Name $Name

        If($openFile = $psISE.CurrentPowerShellTab.Files | Where-Object {$_.FullPath -eq $fullPath}) {
            $null = $psISE.CurrentPowerShellTab.Files.Remove($openFile, $true)
        }
    }
    else {
        $null = $psISE.CurrentPowerShellTab.Files.Remove($psISE.CurrentFile)
    }
}