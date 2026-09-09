# Change Log

All notable changes to this project will be documented in this file.

## Unreleased

### Added

- Initial scaffold of `IdentityCommand.RiskMgmt`, wrapping the CyberArk Risk Management API.
- `Connect-RMTenant`: authenticate to the Risk Management service, resolving the service url from a
  shared services subdomain via platform discovery, or from a url supplied directly. An existing
  `IdentityCommand` session is used as-is; supplying `-Credential` (optionally with
  `-PlatformToken`) or `-SAMLResponse` authenticates to CyberArk Identity first.
- `Get-RMModuleData`: get the module version and session configuration data.
