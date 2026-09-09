---
external help file: IdentityCommand.RiskMgmt-help.xml
Module Name: IdentityCommand.RiskMgmt
online version:
schema: 2.0.0
---

# Get-RMRecommendation

## SYNOPSIS
Lists recommendations to reduce risk

## SYNTAX

```
Get-RMRecommendation [<CommonParameters>]
```

## DESCRIPTION
Lists recommendations for reducing the organisation's security risks, based on the Idira Identity Security Blueprint. Each recommendation carries the number of accounts it applies to, its severity, its control family, and the entity tags available for it.

## EXAMPLES

### Example 1
```
Get-RMRecommendation
```

Lists all recommendations

### Example 2
```
Get-RMRecommendation | Where-Object severity -in 'HIGH', 'CRITICAL'
```

Lists the recommendations of high or critical severity

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
