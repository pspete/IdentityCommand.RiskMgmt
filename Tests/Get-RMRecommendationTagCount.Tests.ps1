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

Describe 'Get-RMRecommendationTagCount' {

    BeforeEach {

        Mock -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -MockWith {
            [pscustomobject]@{ 'recommendationType' = 'SECURE_STANDING_ACCESS_UNIX_602'; 'appliedEntityTagValue' = 15 }
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

        $Script:response = Get-RMRecommendationTagCount -recommendationType 'SECURE_STANDING_ACCESS_UNIX_602' -entityTags 'production'
    }

    Context 'Request' {

        It 'sends request' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -Times 1 -Exactly -Scope It
        }

        It 'sends request to expected endpoint' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -ParameterFilter {
                $URI -like 'https://somedomain.compass.cyberark.cloud/api/recommendations/SECURE_STANDING_ACCESS_UNIX_602/by-tags`?*'
            } -Times 1 -Exactly -Scope It
        }

        It 'uses expected method' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -ParameterFilter {
                $Method -eq 'GET'
            } -Times 1 -Exactly -Scope It
        }

        It 'sends the tags in the query string' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -ParameterFilter {
                $URI -match 'entityTags=production'
            } -Times 1 -Exactly -Scope It
        }

        It 'does not send the recommendation type in the query string' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -ParameterFilter {
                $URI -notmatch 'recommendationType='
            } -Times 1 -Exactly -Scope It
        }
    }

    Context 'Response' {

        It 'provides output' {
            $Script:response | Should -Not -BeNullOrEmpty
        }

        It 'outputs the tag count' {
            $Script:response.appliedEntityTagValue | Should -Be 15
        }
    }

}
