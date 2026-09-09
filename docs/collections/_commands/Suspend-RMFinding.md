---
external help file: IdentityCommand.RiskMgmt-help.xml
Module Name: IdentityCommand.RiskMgmt
online version:
schema: 2.0.0
---

# Suspend-RMFinding

## SYNOPSIS
Snoozes a finding

## SYNTAX

```
Suspend-RMFinding [-findingId] <String> [-durationDays] <Int32> [-reason] <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Snoozes a finding for a number of days. The finding's status changes to `SNOOZED` and it is excluded from risk summary counts until the snooze expires, at which point it reverts to its pre-snooze status.

Snoozing a finding which is already snoozed replaces the existing snooze.

Finding identifiers come from `Get-RMFinding`, and pipe into this command.

## EXAMPLES

### Example 1
```
Suspend-RMFinding -findingId 6ced3f8b-3e74-4434-b5b6-fa7915c4b049 -durationDays 7 -reason 'Waiting for the vendor patch'
```

Snoozes the specified finding for 7 days

### Example 2
```
Get-RMFinding -riskTypeId 135f55c4-2078-4da7-884d-41bebc908814 | Suspend-RMFinding -durationDays 30 -reason 'Accepted risk pending Q3 review'
```

Snoozes every finding of the specified risk type for 30 days

## PARAMETERS

### -findingId
The identifier of the finding to snooze.

```yaml
Type: String
Parameter Sets: (All)
Aliases: finding-id, id

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -durationDays
The number of days to snooze the finding for, between 1 and 365.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -reason
The reason for snoozing the finding.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs. The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```


### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
