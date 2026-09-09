# .ExternalHelp IdentityCommand.RiskMgmt-help.xml
function Resume-RMFinding {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [Alias('finding-id', 'id')]
        [String]$findingId
    )

    begin { }#begin

    process {

        $URI = "$($ISPSSSession.tenant_url)/api/risks/findings/$findingId/snooze"

        if ($PSCmdlet.ShouldProcess($findingId, 'Remove Snooze From Finding')) {

            #Send Request
            Invoke-IDRestMethod -Uri $URI -Method DELETE

        }

    }#process

    end { }#end

}
