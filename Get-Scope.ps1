Function Get-Scope {
    [Cmdletbinding()]
    param (
    
    )
    $i = 0

    do {
        try {
            $scopeId = $null
            $scopeId = Get-Variable -Name Host -Scope $i -ErrorAction Stop
            [pscustomobject]@{
                ScopeId = $i
                Type = $MyInvocation
            }
            $i++
        }
        catch {
            Write-Verbose "ScopeId $i not found"
        }
    }
    Until (-not($scopeId))
}

Function Nested {
    Get-Scope
}

[System.Management.Automation.SessionState]::IsVisible([System.Management.Automation.CommandOrigin]::Runspace, $host)

[System.Management.Automation.SessionState] | Get-Member -Type Method -Static

$type = [PowerShell].Assembly.GetType('System.Management.Automation.Runspaces.LocalPipeline')
    $method = $type.GetMethod(
        'GetExecutionContextFromTLS',
        [System.Reflection.BindingFlags]'Static,NonPublic'
)

$context = $method.Invoke(
        $null,
        [System.Reflection.BindingFlags]'Static,NonPublic',
        $null,
        $null,
        (Get-Culture)
)

$type = [PowerShell].Assembly.GetType('System.Management.Automation.SessionStateInternal')
$constructor = $type.GetConstructor(
        [System.Reflection.BindingFlags]'Instance,NonPublic',
        $null,
        $context.GetType(),
        $null
)

$sessionStateInternal = $constructor.Invoke($context)

$method = $type.GetMethod(
    'GetScopeByID',
    [System.Reflection.BindingFlags]'Instance,NonPublic',
    $null,
    [string],
    $null
)

$method.Invoke($sessionStateInternal,'GLOBAL')

$method = $type.GetMethod(
    'get_ModuleScope',
    [System.Reflection.BindingFlags]'Instance,NonPublic'
)

$method.Invoke()

$scope= $sessionStateInternal.GetType().DeclaredProperties | ?{$_.Name -eq 'ScriptScope'}

$type.GetMethods( [System.Reflection.BindingFlags]::Instance -bor [System.Reflection.BindingFlags]::NonPublic ) | % Name




function Get-ScriptBlockScope
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [scriptblock]
        $ScriptBlock
    )
 
    $flags = [System.Reflection.BindingFlags]'Instance,NonPublic'
 
    [scriptblock].GetProperty('SessionStateInternal', $flags).GetValue($ScriptBlock) | select ScopeName
}