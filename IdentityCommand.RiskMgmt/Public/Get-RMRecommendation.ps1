# .ExternalHelp IdentityCommand.RiskMgmt-help.xml
function Get-RMRecommendation {
    [CmdletBinding()]
    param()

    begin { }#begin

    process {

        $URI = "$(Resolve-RequestUrl)/api/recommendations"

        #Send Request
        $result = Invoke-IDRestMethod -Uri $URI -Method GET

        if ($null -ne $result) {

            $result.recommendations

        }

    }#process

    end { }#end

}
