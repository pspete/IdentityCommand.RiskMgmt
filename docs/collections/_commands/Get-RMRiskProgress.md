---
external help file: IdentityCommand.RiskMgmt-help.xml
Module Name: IdentityCommand.RiskMgmt
online version:
schema: 2.0.0
---

# Get-RMRiskProgress

## SYNOPSIS
Gets risk progress over time

## SYNTAX

```
Get-RMRiskProgress [[-entityTypes] <String[]>] [<CommonParameters>]
```

## DESCRIPTION
Gets historical risk data showing the progression of risks by severity level and resolution status over time, with up to 365 daily data points, alongside the current open and resolved totals.

## EXAMPLES

### Example 1
```
Get-RMRiskProgress
```

Gets risk progress across all entity types

### Example 2
```
Get-RMRiskProgress -entityTypes USER, FEDERATED_USER
```

Gets risk progress for user entities only

## PARAMETERS

### -entityTypes
Return progress for one or more entity types only. The documented values are `USER`, `FEDERATED_USER`, `FEDERATED_GROUP` and `WEBAPP`, offered as tab completions.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```


### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
