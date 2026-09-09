---
external help file: IdentityCommand.RiskMgmt-help.xml
Module Name: IdentityCommand.RiskMgmt
online version:
schema: 2.0.0
---

# Get-RMFinding

## SYNOPSIS
Lists risk findings

## SYNTAX

```
Get-RMFinding [[-limit] <Int32>] [[-offset] <Int32>] [[-sort] <String>] [[-search] <String>]
 [[-riskTypeId] <String[]>] [[-status] <String[]>] [[-severity] <String[]>] [[-entityTypes] <String[]>]
 [[-entityId] <String[]>] [[-targetId] <String[]>] [[-daysSinceLastUpdate] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Lists risk findings, with optional filtering and sorting. Findings of every status are returned unless narrowed with `-status`.

Results are paginated automatically; every page is retrieved and the findings of each are returned.

## EXAMPLES

### Example 1
```
Get-RMFinding
```

Lists all risk findings

### Example 2
```
Get-RMFinding -severity CRITICAL, HIGH -status OPEN
```

Lists open findings of critical or high severity

### Example 3
```
Get-RMFinding -entityTypes USER -daysSinceLastUpdate 7 -sort updatedAt:desc
```

Lists findings against users updated in the last 7 days, most recently updated first

### Example 4
```
Get-RMFinding -status OPEN | Suspend-RMFinding -durationDays 30 -reason 'Accepted risk pending Q3 review'
```

Snoozes every open finding for 30 days

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

### -riskTypeId
Filter by one or more risk type identifiers.

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

### -status
Filter by one or more finding statuses. All statuses are returned when not specified.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 
Accepted values: OPEN, CLOSED, SNOOZED

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
