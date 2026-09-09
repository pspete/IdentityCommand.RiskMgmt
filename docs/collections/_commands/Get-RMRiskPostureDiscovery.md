---
external help file: IdentityCommand.RiskMgmt-help.xml
Module Name: IdentityCommand.RiskMgmt
online version:
schema: 2.0.0
---

# Get-RMRiskPostureDiscovery

## SYNOPSIS
Gets the discovered accounts summary

## SYNTAX

```
Get-RMRiskPostureDiscovery [<CommonParameters>]
```

## DESCRIPTION
Gets the risk posture for securing standing privileges - the accounts found by discovery, broken down by account type and classified as privileged, non-privileged or unknown.

## EXAMPLES

### Example 1
```
Get-RMRiskPostureDiscovery
```

Gets the discovered accounts summary

### Example 2
```
(Get-RMRiskPostureDiscovery).accounts.total
```

Gets the total discovered account counts by classification

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
