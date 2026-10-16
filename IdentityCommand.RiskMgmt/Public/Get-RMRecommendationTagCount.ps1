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

        $URI = "$(Resolve-RequestUrl)/api/recommendations/$recommendationType/by-tags"

        $URI = Add-QueryString -URI $URI -Parameter ($PSBoundParameters | Get-Parameter -ParametersToRemove recommendationType)

        #Send Request
        Invoke-IDRestMethod -Uri $URI -Method GET

    }#process

    end { }#end

}
