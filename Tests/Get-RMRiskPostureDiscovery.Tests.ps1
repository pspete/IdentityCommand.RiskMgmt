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

Describe 'Get-RMRiskPostureDiscovery' {

    BeforeEach {

        Mock -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -MockWith {
            [pscustomobject]@{ 'accounts' = [pscustomobject]@{ total = [pscustomobject]@{ privileged = 5; unknown = 1; nonPrivileged = 2 } } }
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

        $Script:response = Get-RMRiskPostureDiscovery
    }

    Context 'Request' {

        It 'sends request' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -Times 1 -Exactly -Scope It
        }

        It 'sends request to expected endpoint' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -ParameterFilter {
                $URI -eq 'https://somedomain.compass.cyberark.cloud/api/risk-posture/secure-standing-privilege/discovery'
            } -Times 1 -Exactly -Scope It
        }

        It 'uses expected method' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -ParameterFilter {
                $Method -eq 'GET'
            } -Times 1 -Exactly -Scope It
        }
    }

    Context 'Response' {

        It 'provides output' {
            $Script:response | Should -Not -BeNullOrEmpty
        }

        It 'outputs the service response' {
            $Script:response.accounts.total.privileged | Should -Be 5
        }
    }

}
