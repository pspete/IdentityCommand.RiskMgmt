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

        $URI = "$(Resolve-RequestUrl)/api/risks/progress"

        $URI = Add-QueryString -URI $URI -Parameter ($PSBoundParameters | Get-Parameter)

        #Send Request
        Invoke-IDRestMethod -Uri $URI -Method GET

    }#process

    end { }#end

}
