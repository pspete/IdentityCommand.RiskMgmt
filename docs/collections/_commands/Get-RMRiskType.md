---
external help file: IdentityCommand.RiskMgmt-help.xml
Module Name: IdentityCommand.RiskMgmt
online version:
schema: 2.0.0
---

# Get-RMRiskType

## SYNOPSIS
Lists risks aggregated by risk type

## SYNTAX

```
Get-RMRiskType [[-limit] <Int32>] [[-offset] <Int32>] [[-sort] <String>] [[-search] <String>]
 [[-severity] <String[]>] [[-entityTypes] <String[]>] [[-entityId] <String[]>] [[-targetId] <String[]>]
 [[-daysSinceLastUpdate] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Returns risk posture aggregated by risk type - severity, entity type, and finding counts by status for each risk type, along with the remediation options available for it.

Results are paginated automatically; every page is retrieved and the risk types of each are returned.

Note that `riskTypeId` and `entityType` are not valid sort fields here, as the results are already grouped by risk type.

## EXAMPLES

### Example 1
```
Get-RMRiskType
```

Lists all risk types with their aggregated finding counts

### Example 2
```
Get-RMRiskType -severity CRITICAL -sort updatedAt:desc
```

Lists critical risk types, most recently updated first

### Example 3
```
Get-RMRiskType -entityTypes WEBAPP
```

Lists the risk types which apply to applications

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

### -sort
Sort expression in the form `field:order`, for example `severity:desc` or `updatedAt:asc`.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -search
Search query string used to filter the results.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -severity
Filter by one or more severity levels.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 
Accepted values: LOW, MEDIUM, HIGH, CRITICAL

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

### -entityId
Filter by one or more entity identifiers.

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

### -targetId
Filter by one or more target identifiers.

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

### -daysSinceLastUpdate
Filter to items updated within this number of days, between 1 and 365.

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


### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
