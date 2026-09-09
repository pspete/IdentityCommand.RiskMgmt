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

Describe 'Suspend-RMFinding' {

    BeforeEach {

        Mock -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -MockWith {
            [pscustomobject]@{ 'findingId' = 'F1'; 'status' = 'SNOOZED' }
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

        $Script:response = Suspend-RMFinding -findingId 'F1' -durationDays 7 -reason 'SomeReason'
    }

    Context 'Request' {

        It 'sends request' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -Times 1 -Exactly -Scope It
        }

        It 'sends request to expected endpoint' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -ParameterFilter {
                $URI -eq 'https://somedomain.compass.cyberark.cloud/api/risks/findings/F1/snooze'
            } -Times 1 -Exactly -Scope It
        }

        It 'uses expected method' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -ParameterFilter {
                $Method -eq 'POST'
            } -Times 1 -Exactly -Scope It
        }

        It 'sends expected body' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -ParameterFilter {
                (($Body | ConvertFrom-Json).durationDays -eq 7) -and
                (($Body | ConvertFrom-Json).reason -eq 'SomeReason')
            } -Times 1 -Exactly -Scope It
        }

        It 'does not send the finding id in the body' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -ParameterFilter {
                ($Body | ConvertFrom-Json).PSObject.Properties.Name -notcontains 'findingId'
            } -Times 1 -Exactly -Scope It
        }

        It 'accepts the finding id from the pipeline by property name' {
            [pscustomobject]@{ findingId = 'F2' } | Suspend-RMFinding -durationDays 1 -reason 'SomeReason'
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -ParameterFilter {
                $URI -eq 'https://somedomain.compass.cyberark.cloud/api/risks/findings/F2/snooze'
            } -Times 1 -Exactly -Scope It
        }

        It 'rejects a duration outside the supported range' {
            { Suspend-RMFinding -findingId 'F1' -durationDays 366 -reason 'SomeReason' } | Should -Throw
        }

        It 'does not send a request when WhatIf is specified' {
            $null = Suspend-RMFinding -findingId 'F9' -durationDays 1 -reason 'SomeReason' -WhatIf
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:RMModuleName -ParameterFilter {
                $URI -match 'F9'
            } -Times 0 -Exactly -Scope It
        }
    }

    Context 'Response' {

        It 'provides output' {
            $Script:response | Should -Not -BeNullOrEmpty
        }

        It 'outputs the snoozed finding' {
            $Script:response.status | Should -Be 'SNOOZED'
        }
    }

}
