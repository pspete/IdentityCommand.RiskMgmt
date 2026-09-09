# .ExternalHelp IdentityCommand.RiskMgmt-help.xml
function Get-RMRiskPostureDiscovery {
    [CmdletBinding()]
    param()

    begin { }#begin

    process {

        $URI = "$($ISPSSSession.tenant_url)/api/risk-posture/secure-standing-privilege/discovery"

        #Send Request
        Invoke-IDRestMethod -Uri $URI -Method GET

    }#process

    end { }#end

}
