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

Describe 'Get-RMFinding' {

    BeforeEach {

        Mock -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -MockWith {
            [pscustomobject]@{
                'findings' = @([pscustomobject]@{ findingId = 'F1'; severity = 'CRITICAL'; status = 'OPEN' })
                'limit'      = 100
                'offset'     = 0
                'isLastPage' = $true
            }
        }

        InModuleScope -ModuleName $Script:RMModuleName {
            $ISPSSSession = [ordered]@{
                tenant_url = 'https://somedomain-compass.cyberark.cloud'
                User       = $null
                TenantId   = 'SomeTenant'
                SessionId  = 'SomeSession'
                WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
            }
            New-Variable -Name ISPSSSession -Value $ISPSSSession -Scope Script -Force
        }

        $Script:response = Get-RMFinding
    }

    Context 'Request' {

        It 'sends request' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -Times 1 -Exactly -Scope It
        }

        It 'sends request to expected endpoint' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -ParameterFilter {
                $URI -eq 'https://somedomain-compass.cyberark.cloud/api/risks/findings'
            } -Times 1 -Exactly -Scope It
        }

        It 'uses expected method' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -ParameterFilter {
                $Method -eq 'GET'
            } -Times 1 -Exactly -Scope It
        }

        It 'sends request with expected query string' {
            $null = Get-RMFinding -severity CRITICAL -status OPEN -limit 50 -sort 'severity:desc'
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -ParameterFilter {
                ($URI -match 'severity=CRITICAL') -and
                ($URI -match 'status=OPEN') -and
                ($URI -match 'limit=50')
            } -Times 1 -Exactly -Scope It
        }

        It 'rejects an invalid sort expression' {
            { Get-RMFinding -sort 'severity' } | Should -Throw
        }
    }

    Context 'Response' {

        It 'provides output' {
            $Script:response | Should -Not -BeNullOrEmpty
        }

        It 'outputs the findings of the response' {
            $Script:response.findingId | Should -Be 'F1'
        }

        It 'does not request a further page when isLastPage is true' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -Times 1 -Exactly -Scope It
        }

        It 'follows pagination until isLastPage is true' {
            Mock -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -MockWith {
                [pscustomobject]@{ 'findings' = @([pscustomobject]@{ findingId = 'F2'; severity = 'CRITICAL'; status = 'OPEN' }); 'limit' = 1; 'offset' = 1; 'isLastPage' = $true }
            } -ParameterFilter { $URI -match 'offset=' }

            Mock -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -MockWith {
                [pscustomobject]@{ 'findings' = @([pscustomobject]@{ findingId = 'F1'; severity = 'CRITICAL'; status = 'OPEN' }); 'limit' = 1; 'offset' = 0; 'isLastPage' = $false }
            } -ParameterFilter { $URI -notmatch 'offset=' }

            (Get-RMFinding | Measure-Object).Count | Should -Be 2
        }
    }

    Context 'Without a module session' {

        BeforeEach {

            InModuleScope -ModuleName $Script:RMModuleName {
                $ISPSSSession = [ordered]@{
                    tenant_url = $null
                    Subdomain  = $null
                    StartTime  = $null
                    WebSession = $null
                }
                New-Variable -Name ISPSSSession -Value $ISPSSSession -Scope Script -Force
            }

            Mock -CommandName Get-IDSession -ModuleName $Script:RMModuleName -MockWith {
                [ordered]@{
                    tenant_url = 'https://sometenant.id.cyberark.cloud'
                    Subdomain  = 'sometenant'
                    StartTime  = Get-Date '2026-01-01T09:00:00'
                    WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
                }
            }

            Mock -CommandName Resolve-ServiceUrl -ModuleName $Script:RMModuleName -MockWith {
                [pscustomobject]@{ ServiceUrl = "https://$Subdomain-$Service.cyberark.cloud" }
            }

        }

        It 'resolves the service URL from the IdentityCommand session' {
            $null = Get-RMFinding
            Should -Invoke -CommandName Resolve-ServiceUrl -ModuleName $Script:RMModuleName -ParameterFilter {
                $Service -eq 'compass' -and $Endpoint -eq 'bootstrap' -and $Subdomain -eq 'sometenant'
            } -Times 1 -Exactly -Scope It
        }

        It 'sends request to the resolved service URL' {
            $null = Get-RMFinding
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -ParameterFilter {
                $URI -eq 'https://sometenant-compass.cyberark.cloud/api/risks/findings'
            } -Times 1 -Exactly -Scope It
        }

    }

}
