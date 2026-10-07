---
title: "IdentityCommand.RiskMgmt Release 0.1"
date: 2026-10-07 00:00:00
version: 0.1.0
tags:
  - Release Notes
  - Connect-RMTenant
  - Get-RMModuleData
  - Get-RMRiskSummary
  - Get-RMRiskProgress
  - Get-RMRiskType
  - Get-RMFinding
  - Suspend-RMFinding
  - Resume-RMFinding
  - Get-RMEntityRiskSummary
  - Get-RMRecommendation
  - Get-RMRecommendationTagCount
  - Get-RMRemediation
  - New-RMRemediation
  - Get-RMRiskPostureDiscovery
  - Get-RMRiskPostureProgress
---

## [0.1.0]

### Added

- Initial scaffold of `IdentityCommand.RiskMgmt`, wrapping the CyberArk Risk Management API.
- `Connect-RMTenant`: authenticate to the Risk Management service, resolving the service url from a
  shared services subdomain via platform discovery, or from a url supplied directly. An existing
  `IdentityCommand` session is used as-is; supplying `-Credential` (optionally with
  `-PlatformToken`) or `-SAMLResponse` authenticates to CyberArk Identity first.
- `Get-RMModuleData`: get the module version and session configuration data.
- `Get-RMRiskSummary`, `Get-RMRiskProgress`: tenant risk summary, and risk progression over time.
- `Get-RMRiskType`, `Get-RMFinding`: risks aggregated by risk type, and the individual findings,
  both with filtering and sorting. Results are paginated automatically.
- `Suspend-RMFinding`, `Resume-RMFinding`: snooze a finding for a period, and clear the snooze.
- `Get-RMEntityRiskSummary`: computed risk level and open finding count for one entity.
- `Get-RMRecommendation`, `Get-RMRecommendationTagCount`: Identity Security Blueprint
  recommendations, and the count of tagged accounts under one of them.
- `Get-RMRemediation`, `New-RMRemediation`: list system and custom remediations, and create a
  custom one. Results are paginated automatically.
- `Get-RMRiskPostureDiscovery`, `Get-RMRiskPostureProgress`: discovered account classification, and
  onboarding progress over time.
