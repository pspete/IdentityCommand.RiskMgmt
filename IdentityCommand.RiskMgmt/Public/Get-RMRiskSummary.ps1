# .ExternalHelp IdentityCommand.RiskMgmt-help.xml
function Get-RMRiskSummary {
    [CmdletBinding()]
    param()

    begin { }#begin

    process {

        $URI = "$($ISPSSSession.tenant_url)/api/risks/summary"

        #Send Request
        Invoke-IDRestMethod -Uri $URI -Method GET

    }#process

    end { }#end

}
