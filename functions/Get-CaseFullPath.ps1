Function Get-CaseFullPath {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory)]
        [string]$Name
    )

    switch ($Name) {
        'ImportCsv' { "$caseFolder\CaseOfImportCsv.ps1" } 
        'SlowProgress' {"$caseFolder\CaseOfSlowProgress.ps1"} 
        'SlowArray' { "$caseFolder\CaseOfSlowArray.ps1" } 
        'FailingScheduledTask' { "$caseFolder\CaseOfFailingScheduledTask.ps1" } 
        'AutoGeneratingCode' { "$caseFolder\CaseOfAutoGeneratingCode.ps1" } 
        'ConfiguringSwitch' { "$caseFolder\CaseOfConfiguringSwitches.ps1" } 
        'ErrorActionSilentlyContinueIgnored' { "$caseFolder\CaseOfErrorActionSilentlyContinueIgnored.ps1" } 
        'OutOfScope' { "$caseFolder\CaseOfOutOfScope.ps1 " } 
        'VariableScope' { "$caseFolder\CaseOfVariableScope.ps1" } 
        'PSDrivePathNotFound' { "$caseFolder\CaseOfPSDrivePathNotFound.ps1" } 
        'WireShark' { "$caseFolder\CaseOfWireShark.ps1" }
        'IgnoredBreakpoint' { "$caseFolder\CaseOfIgnoredBreakpoint.ps1" }
    }
}