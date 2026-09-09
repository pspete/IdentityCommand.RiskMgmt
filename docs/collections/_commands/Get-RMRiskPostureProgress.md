---
external help file: IdentityCommand.RiskMgmt-help.xml
Module Name: IdentityCommand.RiskMgmt
online version:
schema: 2.0.0
---

# Get-RMRiskPostureProgress

## SYNOPSIS
Gets account onboarding progress over time

## SYNTAX

```
Get-RMRiskPostureProgress [<CommonParameters>]
```

## DESCRIPTION
Gets the number of onboarded accounts against the number of discovered accounts over time, with up to 365 daily data points, alongside the current onboarded totals.

## EXAMPLES

### Example 1
```
Get-RMRiskPostureProgress
```

Gets onboarding progress over time

### Example 2
```
(Get-RMRiskPostureProgress).progress | Select-Object -Last 30
```

Gets the most recent 30 daily data points

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
