# Configuring switches

$switchConfig = 0

switch ($switchConfig) {
    0 {
       $switch = 'Switch0'
    }
    1 {
        $switch = 'Switch1'
    }
    2 {
        $switch = 'Switch2'
    }
}

$switch


# So how can we use $switch in the switch statement?

switch (1,2,3) {
    1 {
        $null = $switch.MoveNext()
        $switch.Current
    }
    2 {'We don''t see this'}
    3 {$_}
}

switch (1,2,3) {
    1 {$switch.Current}
}

switch (Get-ChildItem -Path c:\temp) {
    default {$_.Fullname}
}

# What if we want to use this anyway?
$switch = switch ($switchConfig) {
    0 {
        'Switch0'
    }
    1 {
        'Switch1'
    }
    2 {
        'Switch2'
    }
}

$switch
# Are there more of these?

Function Get-PipelineInput {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        $Name 
    )

    $Input = 'MyCustomInput'
    $Input
}

'Test' | Get-PipelineInput

# Also, in the foreach statement there is a similar enumerator variable:

foreach($item in (1..10)) {
    $foreach.Current
}


# A full list:

start iexplore 'https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_automatic_variables'

