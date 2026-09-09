---
external help file: IdentityCommand.RiskMgmt-help.xml
Module Name: IdentityCommand.RiskMgmt
online version:
schema: 2.0.0
---

# New-RMRemediation

## SYNOPSIS
Creates a custom remediation

## SYNTAX

```
New-RMRemediation [-entityType] <String> [-name] <String> [-remediationText] <String> [[-link] <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a custom-defined (`CUSTOM`) remediation, returning the full remediation including its system-generated identifier.

The name must be unique on the tenant; a duplicate is rejected by the service. Neither the name nor the identifier can be changed after creation.

## EXAMPLES

### Example 1
```
New-RMRemediation -entityType USER -name 'Rotate Privileged Account Password' -remediationText 'Rotate the password using CyberArk Password Manager.'
```

Creates a remediation for user entities

### Example 2
```
New-RMRemediation -entityType WEBAPP -name 'Shorten Token Lifetime' -remediationText 'Reduce the configured token lifetime to the recommended value.' -link 'https://docs.example.com/token-lifetime'
```

Creates a remediation which links to further documentation

## PARAMETERS

### -entityType
The type of entity the remediation applies to. The documented values are `USER`, `FEDERATED_USER`, `FEDERATED_GROUP` and `WEBAPP`, offered as tab completions.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -name
A name for the remediation, unique on the tenant. Cannot be changed after creation.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -remediationText
The remediation instructions.

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

### -link
A URL linking to a starting point for the remediation - documentation, an external reference, or a screen in the tenant.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 3
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
