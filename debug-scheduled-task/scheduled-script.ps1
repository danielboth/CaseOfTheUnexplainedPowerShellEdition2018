try {
    Throw 'Error'
}
catch {
    Wait-Debugger -Verbose
}


Write-Host 'Test'
