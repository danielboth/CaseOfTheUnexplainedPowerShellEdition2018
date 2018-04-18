$caseFolder = "$PSScriptRoot\cases"

Foreach($script in (Get-ChildItem "$PSScriptRoot\functions")) {
    . $script.FullName
}