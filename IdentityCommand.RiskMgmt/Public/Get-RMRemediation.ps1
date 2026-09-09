# .ExternalHelp IdentityCommand.RiskMgmt-help.xml
function Get-RMRemediation {
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateRange(1, 1000)]
        [int]$limit,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateRange(0, 2147483647)]
        [int]$offset,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateCount(1, 10)]
        [String[]]$entityTypes,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateCount(1, 100)]
        [String[]]$ids
    )

    begin { }#begin

    process {

        $URI = "$($ISPSSSession.tenant_url)/api/remediations"

        #TODO: array filters travel as a percent encoded, comma joined single value
        #(severity=CRITICAL%2CHIGH). The spec sets no style/explode, whose OpenAPI default is one
        #parameter per value. Verify against a tenant.
        $URI = Add-QueryString -URI $URI -Parameter ($PSBoundParameters | Get-Parameter)

        #Send Request
        $result = Invoke-IDRestMethod -Uri $URI -Method GET

        if ($null -ne $result) {

            Get-PagedResult -InitialResult $result -URI $URI -Style Offset -ResultProperty 'remediations' -LastPageKey 'isLastPage'

        }

    }#process

    end { }#end

}
