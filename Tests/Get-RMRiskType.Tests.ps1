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

Describe 'Get-RMRiskType' {

    BeforeEach {

        Mock -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -MockWith {
            [pscustomobject]@{
                'riskTypes' = @([pscustomobject]@{ riskTypeId = 'RT1'; severity = 'CRITICAL' })
                'limit'      = 100
                'offset'     = 0
                'isLastPage' = $true
            }
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

        $Script:response = Get-RMRiskType
    }

    Context 'Request' {

        It 'sends request' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -Times 1 -Exactly -Scope It
        }

        It 'sends request to expected endpoint' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -ParameterFilter {
                $URI -eq 'https://somedomain.compass.cyberark.cloud/api/risks/risk-types'
            } -Times 1 -Exactly -Scope It
        }

        It 'uses expected method' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -ParameterFilter {
                $Method -eq 'GET'
            } -Times 1 -Exactly -Scope It
        }

        It 'sends request with expected query string' {
            $null = Get-RMRiskType -severity CRITICAL -limit 50
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -ParameterFilter {
                ($URI -match 'severity=CRITICAL') -and ($URI -match 'limit=50')
            } -Times 1 -Exactly -Scope It
        }
    }

    Context 'Response' {

        It 'provides output' {
            $Script:response | Should -Not -BeNullOrEmpty
        }

        It 'outputs the riskTypes of the response' {
            $Script:response.riskTypeId | Should -Be 'RT1'
        }

        It 'does not request a further page when isLastPage is true' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -Times 1 -Exactly -Scope It
        }

        It 'follows pagination until isLastPage is true' {
            Mock -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -MockWith {
                [pscustomobject]@{ 'riskTypes' = @([pscustomobject]@{ riskTypeId = 'RT2'; severity = 'CRITICAL' }); 'limit' = 1; 'offset' = 1; 'isLastPage' = $true }
            } -ParameterFilter { $URI -match 'offset=' }

            Mock -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -MockWith {
                [pscustomobject]@{ 'riskTypes' = @([pscustomobject]@{ riskTypeId = 'RT1'; severity = 'CRITICAL' }); 'limit' = 1; 'offset' = 0; 'isLastPage' = $false }
            } -ParameterFilter { $URI -notmatch 'offset=' }

            (Get-RMRiskType | Measure-Object).Count | Should -Be 2
        }
    }

}
