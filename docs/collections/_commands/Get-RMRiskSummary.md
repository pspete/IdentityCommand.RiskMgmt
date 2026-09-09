---
external help file: IdentityCommand.RiskMgmt-help.xml
Module Name: IdentityCommand.RiskMgmt
online version:
schema: 2.0.0
---

# Get-RMRiskSummary

## SYNOPSIS
Gets a hierarchical summary of risks

## SYNTAX

```
Get-RMRiskSummary [<CommonParameters>]
```

## DESCRIPTION
Gets a summary of risks organised by entity type and category, with finding counts by severity level at each category, plus a total across all entity types.

## EXAMPLES

### Example 1
```
Get-RMRiskSummary
```

Gets the risk summary for the tenant

### Example 2
```
(Get-RMRiskSummary).totalFindingsBySeverity
```

Gets the total finding counts by severity level

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
