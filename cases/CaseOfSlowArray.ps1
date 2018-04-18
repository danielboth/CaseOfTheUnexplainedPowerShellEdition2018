# Using builtin array
$builtinArray = @()
1..10000 | ForEach-Object {
    $builtinArray += $_
}

$builtinArray | Select-Object -Last 10

Measure-Command -Expression {
    $builtinArray = @()
    1..10000 | ForEach-Object {
        $builtinArray += $_
    }
}


# So, should we use ArrayList?
Measure-Command -Expression {
    $arrayList = [System.Collections.ArrayList]::new()
    $arrayList.AddRange(1..10000000)  
}
$arrayList.Add('Test')


# Or maybe a generic list?
Measure-Command -Expression {
    $arrayGenericList = [System.Collections.Generic.List[int]]::new()
    $arrayGenericList.AddRange((1..10000000 -as [int[]]))
}

# A generic list is strongly typed though:
$arrayGenericList.Add([string]'Test')


# Another way of creating Arrays
Measure-Command -Expression {
    $array = foreach ($i in (1..10000)) {
        $i
    }
}

$array

# Or in case of just numbers
$array = 1..10000

Measure-Command -Expression {
    $array = 1..10000
}

$array = & {
    Get-CimInstance -ClassName win32_bios
    Get-CimInstance -ClassName win32_operatingsystem
    Get-CimInstance -ClassName win32_computersystem
}

$array


# What about array lookup performance?
$randomNumbers = Foreach($i in (1..1000)) {
    Get-Random -Minimum 0 -Maximum 10000
}

Measure-Command -Expression {
    foreach($number in $randomNumbers) {
        $builtinArray.IndexOf($number)
    }
}

Measure-Command -Expression {
    foreach($number in $randomNumbers) {
        $arrayList.IndexOf($number)
    }
}

Measure-Command -Expression {
    foreach($number in $randomNumbers) {
        $arrayGenericList.IndexOf($number)
    }
}


