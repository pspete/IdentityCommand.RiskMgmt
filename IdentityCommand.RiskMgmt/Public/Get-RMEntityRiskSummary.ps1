# .ExternalHelp IdentityCommand.RiskMgmt-help.xml
function Get-RMEntityRiskSummary {
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [Alias('entity-id', 'id')]
        [String]$entityId
    )

    begin { }#begin

    process {

        $URI = "$(Resolve-RequestUrl)/api/entities/$entityId"

        #Send Request
        Invoke-IDRestMethod -Uri $URI -Method GET

    }#process

    end { }#end

}
