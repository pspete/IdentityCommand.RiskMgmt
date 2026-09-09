---
external help file: IdentityCommand.RiskMgmt-help.xml
Module Name: IdentityCommand.RiskMgmt
online version:
schema: 2.0.0
---

# Get-RMRemediation

## SYNOPSIS
Lists remediations

## SYNTAX

```
Get-RMRemediation [[-limit] <Int32>] [[-offset] <Int32>] [[-entityTypes] <String[]>] [[-ids] <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION
Lists remediations, both the system-defined (`SYSTEM`) remediations which ship with the service and any custom-defined (`CUSTOM`) remediations created on the tenant.

Results are paginated automatically; every page is retrieved and the remediations of each are returned.

## EXAMPLES

### Example 1
```
Get-RMRemediation
```

Lists all remediations

### Example 2
```
Get-RMRemediation -entityTypes USER
```

Lists the remediations which apply to users

### Example 3
```
Get-RMRemediation | Where-Object remediationType -eq CUSTOM
```

Lists only the remediations defined on this tenant

## PARAMETERS

### -limit
The maximum number of items to return per request, between 1 and 1000. The service returns 100 when not specified.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -offset
The number of items to skip before returning results.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -entityTypes
Filter by one or more entity types. The documented values are `USER`, `FEDERATED_USER`, `FEDERATED_GROUP` and `WEBAPP`, offered as tab completions.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ids
Return only the remediations with these identifiers.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
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
