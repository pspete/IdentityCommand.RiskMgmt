---
external help file: IdentityCommand.RiskMgmt-help.xml
Module Name: IdentityCommand.RiskMgmt
online version:
schema: 2.0.0
---

# Get-RMEntityRiskSummary

## SYNOPSIS
Gets the risk summary of an entity

## SYNTAX

```
Get-RMEntityRiskSummary [-entityId] <String> [<CommonParameters>]
```

## DESCRIPTION
Gets the computed risk level and the total number of open findings for a specific entity. The risk level is `NONE` when the entity has no open findings.

Entity identifiers come from `Get-RMFinding`, and pipe into this command.

## EXAMPLES

### Example 1
```
Get-RMEntityRiskSummary -entityId 2258606498184295450
```

Gets the risk summary of the specified entity

### Example 2
```
Get-RMFinding -severity CRITICAL | Select-Object -ExpandProperty entityId -Unique | Get-RMEntityRiskSummary
```

Gets the risk summary of every entity with a critical finding

## PARAMETERS

### -entityId
The identifier of the entity.

```yaml
Type: String
Parameter Sets: (All)
Aliases: entity-id, id

Required: True
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
