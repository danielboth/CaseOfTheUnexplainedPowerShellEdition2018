Import-Module "$ENV:CaseOfTheUnexplainedPath\MyModule.psd1"
# Scopes in PowerShell

# Let's write a simple test using classes

class VolumeMock {
    [string] $Driveletter
    [int] $Index
}

Function New-VolumeMock {
    $volume = [VolumeMock]::new()
    $volume.Driveletter = 'D'
    $volume.Index = 2
    $volume
}
New-VolumeMock

Describe 'Volume modification tests' {
    Context 'Reorder volumes' {
        It 'Index of the volume is 2 when the mock is initialized' {
            $volume = New-VolumeMock
            $volume.Index | Should Be 2
        }
    }
}

# That still works, what about this?
class VolumeMock2 {
    [string] $Driveletter
    [int] $Index
}

InModuleScope MyModule {
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
}

psedit "$ENV:CaseOfTheUnexplainedPath\cases\CaseOfOutOfScope-Standalone.ps1"

# Ok so we are ready to put it in production, right?
Start-Process PowerShell.exe -ArgumentList '-NoExit',"$ENV:CaseOfTheUnexplainedPath\cases\CaseOfOutOfScope-Standalone.ps1"

# So what's happening here?
PowerShell.exe -File "$ENV:CaseOfTheUnexplainedPath\cases\CaseOfOutOfScope-Standalone.ps1"

# Running InModuleScope:
. (Get-Module MyModule) {$Host.EnterNestedPrompt()}

# Where are we now?
$ExecutionContext.SessionState

# Exit moduleScope, now we are back at where we used to be:
$ExecutionContext.SessionState

# Let's debug:
psedit "$ENV:CaseOfTheUnexplainedPath\cases\CaseOfOutOfScope-Standalone.ps1"

# And run again:
Start-Process PowerShell.exe -ArgumentList '-NoExit',"$ENV:CaseOfTheUnexplainedPath\cases\CaseOfOutOfScope-Standalone.ps1"
