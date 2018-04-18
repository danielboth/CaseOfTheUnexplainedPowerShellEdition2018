# So, you got scopes now, so we are prepared for anything?
# Here my hashtable was updated "unexpectedly"

$Name = 'Current'

Function Update-MyString {
    param (
        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter()]
        [switch]$Display
    )

    $Name += '-and-updated'

    If($Display) {
        $Name
    }
}

Update-MyString -Name $Name -Display
$Name

#Behaviour for arrays
Function Update-MyArray {
    Param (
        [Parameter(Mandatory)]
        [array]$Array,

        [Parameter()]
        [switch]$Display
    )

    $Array += 4

    If($Display) {
        $Array
    }
}

$Array = @(1,2,3)
Update-MyArray -Array $Array
$Array -join ','
(Update-MyArray -Array $Array -Display) -join ','


# Same for objects?
Function Update-MyObject {
    param (
        [Parameter(Mandatory)]
        [object]$Object,

        [Parameter()]
        [switch]$Display
    )

    $Object.Name = 'NewName'

    If($Display) {
        $Object
    }
}

$Object = [pscustomobject]@{
    Name = 'CurrentName'
}

$Object
Update-MyObject -Object $Object
$Object

Function Update-MyDictonary {
    param
    (
      [Parameter(Mandatory)]
      [hashtable]$Dictionary
    )

    $Dictionary.Add(
        'Name', 'NewName'
    )
}

$Dictionary = @{}
Update-MyDictonary -Dictionary $Dictionary
$Dictionary

# So even though the variables are updated in the function scope, we see the updates.
# This also means that:

$Duplicate = $Dictionary
$Dictionary.Add('Next', 'NextName')

$Duplicate

# You can prevent this behaviour though:

$Duplicate = $Dictionary.Clone()
$Dictionary.Add('Another', 'One')

$Duplicate
$Dictionary


# What if you want to force the by reference behaviour?

Function Update-String {
    [CmdletBinding()]
    param (
        [ref]$MyString
    )

    $MyString.Value = $MyString.Value + '-added'
    $MyString
}

$value = 'text'
Update-String -MyString ([ref]$value)

$value
