---
title: Getting Started
subtitle: Install IdentityCommand.RiskMgmt and connect to Risk Management
---

## Prerequisites

- Requires Powershell Core (recommended), or Windows PowerShell (version 5.1)
- An Idira Identity tenant with the Risk Management service enabled
- An Account to Access Idira Identity
- The `IdentityCommand` module.

## Install Options

Install from the PowerShell Gallery:

```powershell
Install-Module -Name IdentityCommand.RiskMgmt -Scope CurrentUser
```

Or download the [latest release](https://github.com/pspete/IdentityCommand.RiskMgmt/releases), unblock and extract the archive, and copy the `IdentityCommand.RiskMgmt` folder into a path listed in `$env:PSModulePath`.

## Authentication

The module requires authentication to the Idira Identity platform using the `IdentityCommand` module.

The `IdentityCommand` module must be installed and available in order to use `IdentityCommand.RiskMgmt`.

The `Connect-RMTenant` command initialises the bearer token used for module operations against the Risk Management service.

If an Identity session already exists (established with the `IdentityCommand` module's `New-IDSession` or `New-IDPlatformToken`), it is used as-is:

```powershell
# Resolve the Risk Management url automatically from the shared services subdomain
Connect-RMTenant -tenant_subdomain sometenant

# Or provide the Risk Management tenant url directly
Connect-RMTenant -tenant_url https://sometenant.compass.cyberark.cloud
```

Otherwise, provide a credential and `Connect-RMTenant` authenticates to Idira Identity for you - the Identity tenant url is discovered from the same subdomain / url:

```powershell
# Interactive user authentication (any MFA challenges are handled by IdentityCommand)
Connect-RMTenant -tenant_subdomain sometenant -Credential $Credential

# Non-interactive service user authentication via an OAuth platform token
Connect-RMTenant -tenant_subdomain sometenant -Credential $ServiceUserCredential -PlatformToken
```
