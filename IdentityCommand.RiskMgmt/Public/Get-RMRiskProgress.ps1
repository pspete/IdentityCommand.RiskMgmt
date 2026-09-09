# .ExternalHelp IdentityCommand.RiskMgmt-help.xml
function Get-RMRiskProgress {
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateCount(1, 10)]
        [String[]]$entityTypes
    )

    begin { }#begin

    process {

        $URI = "$($ISPSSSession.tenant_url)/api/risks/progress"

        #TODO: array filters travel as a percent encoded, comma joined single value
        #(severity=CRITICAL%2CHIGH). The spec sets no style/explode, whose OpenAPI default is one
        #parameter per value. Verify against a tenant.
        $URI = Add-QueryString -URI $URI -Parameter ($PSBoundParameters | Get-Parameter)

        #Send Request
        Invoke-IDRestMethod -Uri $URI -Method GET

    }#process

    end { }#end

}
