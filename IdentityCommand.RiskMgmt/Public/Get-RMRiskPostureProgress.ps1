# .ExternalHelp IdentityCommand.RiskMgmt-help.xml
function Get-RMRiskPostureProgress {
    [CmdletBinding()]
    param()

    begin { }#begin

    process {

        $URI = "$($ISPSSSession.tenant_url)/api/risk-posture/secure-standing-privilege/progress"

        #Send Request
        Invoke-IDRestMethod -Uri $URI -Method GET

    }#process

    end { }#end

}
