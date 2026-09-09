BeforeAll {
    $Script:RMModuleName = 'IdentityCommand.RiskMgmt'

    #Get Current Directory
    $Here = Split-Path -Parent $PSCommandPath

    #Resolve Path to Module Directory
    $ModulePath = Resolve-Path "$Here\..\$Script:RMModuleName"

    #Define Path to Module Manifest
    $ManifestPath = Join-Path "$ModulePath" "$Script:RMModuleName.psd1"

    if ( -not (Get-Module -Name $Script:RMModuleName -All)) {

        Import-Module -Name "$ManifestPath" -ArgumentList $true -Force -ErrorAction Stop

    }
}

Describe 'Get-RMEntityRiskSummary' {

    BeforeEach {

        Mock -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -MockWith {
            [pscustomobject]@{ 'entityId' = '12345'; 'riskLevel' = 'HIGH'; 'totalOpenFindings' = 12 }
        }

        InModuleScope -ModuleName $Script:RMModuleName {
            $ISPSSSession = [ordered]@{
                tenant_url = 'https://somedomain.compass.cyberark.cloud'
                User       = $null
                TenantId   = 'SomeTenant'
                SessionId  = 'SomeSession'
                WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
            }
            New-Variable -Name ISPSSSession -Value $ISPSSSession -Scope Script -Force
        }

        $Script:response = Get-RMEntityRiskSummary -entityId '12345'
    }

    Context 'Request' {

        It 'sends request' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -Times 1 -Exactly -Scope It
        }

        It 'sends request to expected endpoint' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -ParameterFilter {
                $URI -eq 'https://somedomain.compass.cyberark.cloud/api/entities/12345'
            } -Times 1 -Exactly -Scope It
        }

        It 'uses expected method' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -ParameterFilter {
                $Method -eq 'GET'
            } -Times 1 -Exactly -Scope It
        }

        It 'accepts the entity id from the pipeline by property name' {
            [pscustomobject]@{ entityId = '67890' } | Get-RMEntityRiskSummary
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -ParameterFilter {
                $URI -eq 'https://somedomain.compass.cyberark.cloud/api/entities/67890'
            } -Times 1 -Exactly -Scope It
        }
    }

    Context 'Response' {

        It 'provides output' {
            $Script:response | Should -Not -BeNullOrEmpty
        }

        It 'outputs the risk level' {
            $Script:response.riskLevel | Should -Be 'HIGH'
        }
    }

}
