# ErrorAction: SilentlyContinue | Ignore | Continue | Stop | Inquire | Suspend

# Default ErrorAction
$ErrorActionPreference
Get-CimInstance -ClassName Win32_DoesNotExist

# SilentlyContinue
Get-CimInstance -ClassName Win32_DoesNotExist -ErrorAction SilentlyContinue

# Does it always work that way?
Get-ItemPropertyValue -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup -Name BootDir

Get-ItemPropertyValue -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup -Name BootDir2

Get-ItemPropertyValue -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup -Name BootDir2 -ErrorAction SilentlyContinue

# What's going on here?
Get-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup -Name BootDir2 -ErrorAction SilentlyContinue

# It's not that easy:
start iexplore https://github.com/PowerShell/PowerShell-Docs/issues/1583

# Default behaviour for these is also different
try {
    Get-CimInstance -ClassName Win32_DoesNotExist
}
catch {
    'Caught!'
}

try {
    Get-ItemPropertyValue -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup -Name BootDir2
}
catch {
    'Caught!'
}

# How to get a more consistent behavior?
try {
    Get-CimInstance -ClassName Win32_DoesNotExist -ErrorAction Stop
}
catch {
    'Caught!'
}

try {
    Get-ItemPropertyValue -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup -Name BootDir2 -ErrorAction Stop
}
catch {
    'Caught!'
}

# Now you can throw the error yourself if you want
try {
    Get-CimInstance -ClassName Win32_DoesNotExist -ErrorAction Stop
}
catch {
    Throw $_
}

# In advanced functions, you might want to use ThrowTerminatingError instead:
function Test-Throw {
    [CmdletBinding()]
    param (
    
    )

    try {
        Get-CimInstance -ClassName Win32_DoesNotExist -ErrorAction Stop
    }
    catch {
        Throw $_
    }
}

function Test-ThrowTerminatingError {
    [CmdletBinding()]
    param (

    )

    try {
        Get-CimInstance -ClassName Win32_DoesNotExist -ErrorAction Stop
    }
    catch {
        $PSCmdlet.ThrowTerminatingError($_)
    }
}

# Behavior Throw:
Test-Throw

# Behavior ThrowTerminatingError
Test-ThrowTerminatingError
