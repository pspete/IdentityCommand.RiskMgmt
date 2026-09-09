# .ExternalHelp IdentityCommand.RiskMgmt-help.xml
function Get-RMRecommendationTagCount {
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [String]$recommendationType,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateCount(1, 5)]
        [String[]]$entityTags
    )

    begin { }#begin

    process {

        $URI = "$($ISPSSSession.tenant_url)/api/recommendations/$recommendationType/by-tags"

        #TODO: array filters travel as a percent encoded, comma joined single value
        #(severity=CRITICAL%2CHIGH). The spec sets no style/explode, whose OpenAPI default is one
        #parameter per value. Verify against a tenant.
        $URI = Add-QueryString -URI $URI -Parameter ($PSBoundParameters | Get-Parameter -ParametersToRemove recommendationType)

        #Send Request
        Invoke-IDRestMethod -Uri $URI -Method GET

    }#process

    end { }#end

}
