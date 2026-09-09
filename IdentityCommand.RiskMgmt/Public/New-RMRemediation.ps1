# .ExternalHelp IdentityCommand.RiskMgmt-help.xml
function New-RMRemediation {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [String]$entityType,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateLength(1, 200)]
        [String]$name,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateLength(1, 2000)]
        [String]$remediationText,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateLength(1, 2048)]
        [String]$link
    )

    begin { }#begin

    process {

        $URI = "$($ISPSSSession.tenant_url)/api/remediations"

        $body = $PSBoundParameters | Get-Parameter | ConvertTo-Json -Depth 8

        if ($PSCmdlet.ShouldProcess($name, 'Create Remediation')) {

            #Send Request
            Invoke-IDRestMethod -Uri $URI -Method POST -Body $body

        }

    }#process

    end { }#end

}
