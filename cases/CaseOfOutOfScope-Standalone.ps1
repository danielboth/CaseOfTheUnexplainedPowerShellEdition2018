Import-Module "$ENV:CaseOfTheUnexplainedPath\MyModule.psd1"

class VolumeMock2 {
    [string] $Driveletter
    [int] $Index
}

InModuleScope MyModule {
    class VolumeMock3 {
        [string] $Driveletter
        [int] $Index
    }
    Describe 'Volume modification tests' {

        Mock Get-Volume -MockWith {
            [VolumeMock2]@{
                Driveletter = 'D'
                Index = 2
            }
        }

        Context 'Reorder volumes' {
            It 'Index of the volume is 2 when the mock is initialized' {
                (Get-Volume).Index | Should Be 2
            }
        }
    }
    #Wait-Debugger
    #Write-Host 'Wait here'
}