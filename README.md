# IdentityCommand.RiskMgmt

**IdentityCommand.RiskMgmt** is a PowerShell module that provides a set of easy-to-use commands, allowing you to interact with the **CyberArk Risk Management API** from within the PowerShell environment.

| Main Branch              | CodeFactor                 | Coverage                     | PowerShell Gallery        | License                      |
| ------------------------ | -------------------------- | ---------------------------- | ------------------------- | ---------------------------- |
| [![build][]][build-site] | [![codefactor][]][cf-site] | [![codecov][]][codecov-link] | [![psgallery][]][ps-site] | [![license][]][license-link] |

[build]: https://github.com/pspete/IdentityCommand.RiskMgmt/actions/workflows/ci.yml/badge.svg?branch=main&event=push
[build-site]: https://github.com/pspete/IdentityCommand.RiskMgmt/actions/workflows/ci.yml?query=branch%3Amain
[psgallery]: https://img.shields.io/powershellgallery/v/IdentityCommand.RiskMgmt.svg
[ps-site]: https://www.powershellgallery.com/packages/IdentityCommand.RiskMgmt
[downloads]: https://img.shields.io/powershellgallery/dt/IdentityCommand.RiskMgmt.svg?color=blue
[cf-site]: https://www.codefactor.io/repository/github/pspete/IdentityCommand.RiskMgmt
[codefactor]: https://www.codefactor.io/repository/github/pspete/IdentityCommand.RiskMgmt/badge
[codecov]: https://codecov.io/gh/pspete/IdentityCommand.RiskMgmt/branch/main/graph/badge.svg
[codecov-link]: https://codecov.io/gh/pspete/IdentityCommand.RiskMgmt
[license]: https://img.shields.io/github/license/pspete/IdentityCommand.RiskMgmt.svg
[license-link]: https://github.com/pspete/IdentityCommand.RiskMgmt/blob/main/LICENSE

## Using the Module

The module requires authentication to the CyberArk Identity platform using the `IdentityCommand` module.

The `IdentityCommand` module must be installed and available in order to use `IdentityCommand.RiskMgmt`.

### Risk Management Authentication

The `Connect-RMTenant` command initialises the bearer token used for module operations against the Risk Management service.

If an Identity session already exists (established with the `IdentityCommand` module's `New-IDSession` or `New-IDPlatformToken`), it is used as-is:

```powershell
# Resolve the Risk Management url automatically from the shared services subdomain
Connect-RMTenant -tenant_subdomain sometenant

# Or provide the Risk Management tenant url directly
Connect-RMTenant -tenant_url https://sometenant.compass.cyberark.cloud
```

Otherwise, provide a credential and `Connect-RMTenant` authenticates to CyberArk Identity for you - the Identity tenant url is discovered from the same subdomain / url:

```powershell
# Interactive user authentication (any MFA challenges are handled by IdentityCommand)
Connect-RMTenant -tenant_subdomain sometenant -Credential $Credential

# Non-interactive service user authentication via an OAuth platform token
Connect-RMTenant -tenant_subdomain sometenant -Credential $ServiceUserCredential -PlatformToken
```

### Risks and Findings

`Get-RMRiskSummary` gives the tenant-wide picture; `Get-RMRiskType` aggregates it by risk type, and `Get-RMFinding` lists the individual findings. Both list commands page automatically:

```powershell
# The whole tenant, by entity type and category
Get-RMRiskSummary

# Critical and high risk types, most recently updated first
Get-RMRiskType -severity CRITICAL, HIGH -sort updatedAt:desc

# Open findings against users, updated in the last week
Get-RMFinding -status OPEN -entityTypes USER -daysSinceLastUpdate 7
```

A finding can be snoozed for a period, which excludes it from risk summary counts until the snooze expires:

```powershell
Suspend-RMFinding -findingId $id -durationDays 30 -reason 'Accepted risk pending Q3 review'

# Findings pipe straight in
Get-RMFinding -riskTypeId $riskTypeId | Suspend-RMFinding -durationDays 7 -reason 'Waiting for the vendor patch'

# And back out again
Get-RMFinding -status SNOOZED | Resume-RMFinding
```

### Recommendations and Remediations

```powershell
# Blueprint recommendations, and the tagged account counts under one of them
Get-RMRecommendation
Get-RMRecommendationTagCount -recommendationType SECURE_STANDING_ACCESS_UNIX_602 -entityTags production

# System and custom remediations
Get-RMRemediation -entityTypes USER

New-RMRemediation -entityType USER -name 'Rotate Privileged Account Password' -remediationText 'Rotate the password using CyberArk Password Manager.'
```

### Risk Posture

```powershell
Get-RMRiskPostureDiscovery
Get-RMRiskPostureProgress
```

## Module Commands

| Command                        | Description                                          |
| ------------------------------ | ---------------------------------------------------- |
| `Connect-RMTenant`             | Authenticate to the Risk Management service          |
| `Get-RMRiskSummary`            | Get a hierarchical summary of risks                  |
| `Get-RMRiskProgress`           | Get risk progress over time                          |
| `Get-RMRiskType`               | List risks aggregated by risk type                   |
| `Get-RMFinding`                | List risk findings                                   |
| `Suspend-RMFinding`            | Snooze a finding                                     |
| `Resume-RMFinding`             | Remove the snooze from a finding                     |
| `Get-RMEntityRiskSummary`      | Get the risk summary of an entity                    |
| `Get-RMRecommendation`         | List recommendations to reduce risk                  |
| `Get-RMRecommendationTagCount` | Get the count of tagged entities under a recommendation |
| `Get-RMRemediation`            | List remediations                                    |
| `New-RMRemediation`            | Create a custom remediation                          |
| `Get-RMRiskPostureDiscovery`   | Get the discovered accounts summary                  |
| `Get-RMRiskPostureProgress`    | Get account onboarding progress over time            |
| `Get-RMModuleData`             | Get the module version & session configuration data  |

## Installation

### Prerequisites

- Requires Powershell Core (recommended), or Windows PowerShell (version 5.1)
- A CyberArk Identity tenant with the Risk Management service enabled
- An Account to Access CyberArk Identity

### Install Options

Users can install IdentityCommand.RiskMgmt from GitHub or the PowerShell Gallery.

Choose any of the following ways to download the module and install it:

#### Option 1: Install from PowerShell Gallery

This is the easiest and most popular way to install the module:

1. Open a PowerShell prompt

2. Run the following command:

```powershell
Install-Module -Name IdentityCommand.RiskMgmt -Scope CurrentUser
```

#### Option 2: Manual Install

The module files can be manually copied to one of your PowerShell module directories.

Use the following command to get the paths to your local PowerShell module folders:

```powershell

$env:PSModulePath.split(';')

```

The module files must be placed in one of the listed directories, in a folder called `IdentityCommand.RiskMgmt`.

More: [about_PSModulePath](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_psmodulepath)

The module files are available to download using a variety of methods:

##### PowerShell Gallery

- Download from the module from the [PowerShell Gallery](https://www.powershellgallery.com/packages/IdentityCommand.RiskMgmt/):
  - Run the PowerShell command `Save-Module -Name IdentityCommand.RiskMgmt -Path C:\temp`
  - Copy the `C:\temp\IdentityCommand.RiskMgmt` folder to your "Powershell Modules" directory of choice.

##### IdentityCommand.RiskMgmt Release

- [Download the latest GitHub release](https://github.com/pspete/IdentityCommand.RiskMgmt/releases/latest)
  - Unblock & Extract the archive
  - Rename the extracted `IdentityCommand.RiskMgmt-v#.#.#` folder to `IdentityCommand.RiskMgmt`
  - Copy the `IdentityCommand.RiskMgmt` folder to your "Powershell Modules" directory of choice.

##### IdentityCommand.RiskMgmt Branch

- [Download the `main` branch](https://github.com/pspete/IdentityCommand.RiskMgmt/archive/refs/heads/main.zip)
  - Unblock & Extract the archive
  - Copy the `IdentityCommand.RiskMgmt` (`\<Archive Root>\IdentityCommand.RiskMgmt-main\IdentityCommand.RiskMgmt`) folder to your "Powershell Modules" directory of choice.

#### Verification

Validate Install:

```powershell

Get-Module -ListAvailable IdentityCommand.RiskMgmt

```

Import the module:

```powershell

Import-Module IdentityCommand.RiskMgmt

```

List Module Commands:

```powershell

Get-Command -Module IdentityCommand.RiskMgmt

```

Get detailed information on specific commands:

```powershell

Get-Help Connect-RMTenant -Full

```

## Sponsorship

Please support continued development; consider sponsoring <a href="https://github.com/sponsors/pspete"> @pspete on GitHub Sponsors</a>

## Changelog

All notable changes to this project will be documented in the [Changelog](CHANGELOG.md)

## Author

- **Pete Maan** - [pspete](https://github.com/pspete)

## License

This project is [licensed under the MIT License](LICENSE.md).

## Contributing

Any and all contributions to this project are appreciated.

See the [CONTRIBUTING.md](CONTRIBUTING.md) for a few more details.

## Support

_IdentityCommand.RiskMgmt_ is neither developed nor supported by CyberArk; any official support channels offered by the vendor are not appropriate for seeking help with the _IdentityCommand.RiskMgmt_ module.

Help and support should be sought by [opening an issue][new-issue].

[new-issue]: https://github.com/pspete/IdentityCommand.RiskMgmt/issues/new

Priority support could be considered for <a href="https://github.com/sponsors/pspete">sponsors of @pspete</a>, <a href="mailto:pspete@pspete.dev">contact us</a> to discuss options.
