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

        $URI = "$(Resolve-RequestUrl)/api/remediations"

        $URI = Add-QueryString -URI $URI -Parameter ($PSBoundParameters | Get-Parameter)

        #Send Request
        $result = Invoke-IDRestMethod -Uri $URI -Method GET

        if ($null -ne $result) {

            Get-PagedResult -InitialResult $result -URI $URI -Style Offset -ResultProperty 'remediations' -LastPageKey 'isLastPage'

        }

    }#process

    end { }#end

}
