---
external help file: IdentityCommand.RiskMgmt-help.xml
Module Name: IdentityCommand.RiskMgmt
online version:
schema: 2.0.0
---

# Resume-RMFinding

## SYNOPSIS
Removes the snooze from a finding

## SYNTAX

```
Resume-RMFinding [-findingId] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Reverts a snoozed finding to its pre-snooze status, clearing all snooze fields and snooze history.

A finding which is not snoozed is returned unchanged rather than reported as an error.

Finding identifiers come from `Get-RMFinding`, and pipe into this command.

## EXAMPLES

### Example 1
```
Resume-RMFinding -findingId 6ced3f8b-3e74-4434-b5b6-fa7915c4b049
```

Removes the snooze from the specified finding

### Example 2
```
Get-RMFinding -status SNOOZED | Resume-RMFinding
```

Removes the snooze from every snoozed finding

## PARAMETERS

### -findingId
The identifier of the finding to remove the snooze from.

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
