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

Describe 'Get-RMRemediation' {

    BeforeEach {

        Mock -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -MockWith {
            [pscustomobject]@{
                'remediations' = @([pscustomobject]@{ id = 'R1'; name = 'Enable MFA'; remediationType = 'SYSTEM' })
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

        $Script:response = Get-RMRemediation
    }

    Context 'Request' {

        It 'sends request' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -Times 1 -Exactly -Scope It
        }

        It 'sends request to expected endpoint' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -ParameterFilter {
                $URI -eq 'https://somedomain.compass.cyberark.cloud/api/remediations'
            } -Times 1 -Exactly -Scope It
        }

        It 'uses expected method' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -ParameterFilter {
                $Method -eq 'GET'
            } -Times 1 -Exactly -Scope It
        }

        It 'sends request with expected query string' {
            $null = Get-RMRemediation -entityTypes USER -limit 50
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -ParameterFilter {
                ($URI -match 'entityTypes=USER') -and ($URI -match 'limit=50')
            } -Times 1 -Exactly -Scope It
        }
    }

    Context 'Response' {

        It 'provides output' {
            $Script:response | Should -Not -BeNullOrEmpty
        }

        It 'outputs the remediations of the response' {
            $Script:response.id | Should -Be 'R1'
        }

        It 'does not request a further page when isLastPage is true' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -Times 1 -Exactly -Scope It
        }

        It 'follows pagination until isLastPage is true' {
            Mock -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -MockWith {
                [pscustomobject]@{ 'remediations' = @([pscustomobject]@{ id = 'R2'; name = 'Enable MFA'; remediationType = 'SYSTEM' }); 'limit' = 1; 'offset' = 1; 'isLastPage' = $true }
            } -ParameterFilter { $URI -match 'offset=' }

            Mock -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -MockWith {
                [pscustomobject]@{ 'remediations' = @([pscustomobject]@{ id = 'R1'; name = 'Enable MFA'; remediationType = 'SYSTEM' }); 'limit' = 1; 'offset' = 0; 'isLastPage' = $false }
            } -ParameterFilter { $URI -notmatch 'offset=' }

            (Get-RMRemediation | Measure-Object).Count | Should -Be 2
        }
    }

}
