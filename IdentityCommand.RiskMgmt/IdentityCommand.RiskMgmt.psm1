#region Loader
<#
.SYNOPSIS

.DESCRIPTION

.EXAMPLE

.INPUTS

.OUTPUTS
#>
[CmdletBinding()]
param(

    [bool]$DotSourceModule = $false

)

#Get function files
Get-ChildItem $PSScriptRoot\ -Recurse -Include '*.ps1' -Exclude '*.ps1xml' |

    ForEach-Object {

        if ($DotSourceModule) {
            . $_.FullName
        } else {
            $ExecutionContext.InvokeCommand.InvokeScript(
                $false,
                (
                    [scriptblock]::Create(
                        [io.file]::ReadAllText(
                            $_.FullName,
                            [Text.Encoding]::UTF8
                        )
                    )
                ),
                $null,
                $null
            )

        }

    }

#endregion Loader

#Copy IdentityCommand's private helpers into this module: this module's functions call them, and
#the argument completer registrations below do so at import time.
#Each copy is created from the function definition, so it runs in this module's scope and uses this
#module's $ISPSSSession, whether IdentityCommand loaded from source or from its combined psm1.
#Resolve a single IdentityCommand module: with more than one version loaded, Get-Module returns
#an array.
$Module = Get-Module -Name IdentityCommand | Sort-Object Version -Descending | Select-Object -First 1

if ($null -eq $Module) {
    throw 'The IdentityCommand module is not loaded. Import IdentityCommand and try again.'
}

& $Module { Get-ChildItem -Path Function: } |

    Where-Object { $_.ModuleName -eq $Module.Name -and -not $Module.ExportedFunctions.ContainsKey($_.Name) } |

    ForEach-Object {

        . ([scriptblock]::Create("function $($_.Name) {$($_.Definition)}"))

    }

#region Registration

#entityTypes is documented with four allowed values but typed as a free string in the spec, so it
#is offered as a completion rather than enforced with a ValidateSet.
$EntityTypeCompleter = {
    $wordToComplete = $args[2]
    @('USER', 'FEDERATED_USER', 'FEDERATED_GROUP', 'WEBAPP') |
        ForEach-Object { [pscustomobject]@{ entityType = $_ } } |
        Get-CompletionResult -WordToComplete $wordToComplete -ValueProperty entityType
}

Register-ArgumentCompleter -ParameterName 'entityTypes' -ScriptBlock $EntityTypeCompleter -CommandName @(
    'Get-RMFinding'
    'Get-RMRemediation'
    'Get-RMRiskProgress'
    'Get-RMRiskType'
)

Register-ArgumentCompleter -ParameterName 'entityType' -ScriptBlock $EntityTypeCompleter -CommandName 'New-RMRemediation'

Register-ArgumentCompleter -ParameterName 'recommendationType' -ScriptBlock (
    Get-ArgumentCompleter -RetrievalCommand 'Get-RMRecommendation' -ValueProperty 'recommendationType'
) -CommandName 'Get-RMRecommendationTagCount'

Register-ArgumentCompleter -ParameterName 'ids' -ScriptBlock (
    Get-ArgumentCompleter -RetrievalCommand 'Get-RMRemediation' -ValueProperty 'id' -LabelProperty 'name'
) -CommandName 'Get-RMRemediation'

#endregion Registration

# Script scope session object for session data
$ISPSSSession = [ordered]@{
    tenant_url         = $null
    User               = $null
    TenantId           = $null
    SessionId          = $null
    WebSession         = $null
    StartTime          = $null
    ElapsedTime        = $null
    LastCommand        = $null
    LastCommandTime    = $null
    LastCommandResults = $null
    LastError          = $null
    LastErrorTime      = $null
} | Add-CustomType -Type IdCmd.Session

New-Variable -Name ISPSSSession -Value $ISPSSSession -Scope Script -Force