---
title: IdentityCommand.RiskMgmt
subtitle: PowerShell for Idira Risk Management
hide_hero: true
---

<div class="has-text-centered mb-6">
  <img src="{{ '/RiskMgmt/media/images/IdentityCommand.RiskMgmt.png' | relative_url }}" alt="IdentityCommand.RiskMgmt" width="471">
</div>

**IdentityCommand.RiskMgmt** is a PowerShell module that provides a set of easy-to-use commands, allowing you to interact with the **Idira Risk Management API** from within the PowerShell environment.

It builds on [IdentityCommand]({{ '/' | relative_url }}) for authentication - see [Getting Started]({{ '/RiskMgmt/getting-started/' | relative_url }}) to install and connect, and the [command reference]({{ '/RiskMgmt/commands/' | relative_url }}) for every command.

## Risks and Findings

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

## Recommendations and Remediations

```powershell
# Blueprint recommendations, and the tagged account counts under one of them
Get-RMRecommendation
Get-RMRecommendationTagCount -recommendationType SECURE_STANDING_ACCESS_UNIX_602 -entityTags production

# System and custom remediations
Get-RMRemediation -entityTypes USER

New-RMRemediation -entityType USER -name 'Rotate Privileged Account Password' -remediationText 'Rotate the password using Idira Password Manager.'
```

## Risk Posture

```powershell
Get-RMRiskPostureDiscovery
Get-RMRiskPostureProgress
```
