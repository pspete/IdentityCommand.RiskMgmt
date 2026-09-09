# .ExternalHelp IdentityCommand.RiskMgmt-help.xml
function Suspend-RMFinding {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [Alias('finding-id', 'id')]
        [String]$findingId,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateRange(1, 365)]
        [int]$durationDays,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateLength(1, 1000)]
        [String]$reason
    )

    begin { }#begin

    process {

        $URI = "$($ISPSSSession.tenant_url)/api/risks/findings/$findingId/snooze"

        $body = $PSBoundParameters | Get-Parameter -ParametersToRemove findingId | ConvertTo-Json -Depth 8

        if ($PSCmdlet.ShouldProcess($findingId, 'Snooze Finding')) {

            #Send Request
            Invoke-IDRestMethod -Uri $URI -Method POST -Body $body

        }

    }#process

    end { }#end

}
