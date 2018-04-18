
    $total = 1000

    1..$total | ForEach-Object{
        if(-not($_ % 5)) {
            Write-Progress -Activity Processing -PercentComplete $(($_/$total)*100) -Status ('Number {0} / {1}' -f $_, $total)
        }
        $null = $_/$total
    }

    Set-Content -Path "$PWD\write-progress-impact.txt" -Value ('Run at {0}' -f (Get-Date))

