$testScript = [scriptblock]::Create({
    $total = 1000

    1..$total | ForEach-Object{
        Write-Progress -Activity Processing -PercentComplete $(($_/$total)*100) -Status ('Number {0} / {1}' -f $_, $total)
        $null = $_/$total
    }

    Set-Content -Path "$PWD\write-progress-impact.txt" -Value ('Run at {0}' -f (Get-Date))
})

#Invoke from ISE:
& $testScript

$scriptFile = "$env:CaseOfTheUnexplainedPath\progress-test.ps1"
Set-Content $scriptFile  -Value $testScript

# Invoke from PowerShell console
Start-Process powershell -ArgumentList $scriptFile

# Just to be sure:
Measure-Command -Expression {
    PowerShell.exe -File $scriptFile -NonInteractive
}

Start-Process powershell "-Command `$ProgressPreference='SilentlyContinue'; $scriptFile"

Measure-Command -Expression {
    Start-Process powershell "-Command `$ProgressPreference='SilentlyContinue'; $scriptFile" -Wait
}

# Better solutions?
# ProgressPreference in Profile

# We see a lot being fixed in PowerShell Core though:
Start-Process pwsh.exe


# What if you do want to see progress?
$testScript = [scriptblock]::Create({
    $total = 1000

    1..$total | ForEach-Object{
        if(-not($_ % 5)) {
            Write-Progress -Activity Processing -PercentComplete $(($_/$total)*100) -Status ('Number {0} / {1}' -f $_, $total)
        }
        $null = $_/$total
    }

    Set-Content -Path "$PWD\write-progress-impact.txt" -Value ('Run at {0}' -f (Get-Date))
})

$scriptFile = "$env:CaseOfTheUnexplainedPath\progress-test.ps1"
Set-Content $scriptFile  -Value $testScript

Start-Process powershell "-Command $scriptFile"