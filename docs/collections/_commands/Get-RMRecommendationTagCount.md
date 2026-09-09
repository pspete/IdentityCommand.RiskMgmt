---
external help file: IdentityCommand.RiskMgmt-help.xml
Module Name: IdentityCommand.RiskMgmt
online version:
schema: 2.0.0
---

# Get-RMRecommendationTagCount

## SYNOPSIS
Gets the count of tagged entities under a recommendation

## SYNTAX

```
Get-RMRecommendationTagCount [-recommendationType] <String> [-entityTags] <String[]> [<CommonParameters>]
```

## DESCRIPTION
Gets the number of accounts associated with a recommendation which carry any of the tags supplied. Only accounts with one or more of the specified tags are counted.

Recommendation types and the tags available for each come from `Get-RMRecommendation` - see its `recommendationType` and `availableEntityTags`.

Tags are **case-sensitive**.

## EXAMPLES

### Example 1
```
Get-RMRecommendationTagCount -recommendationType SECURE_STANDING_ACCESS_UNIX_602 -entityTags production
```

Gets the number of accounts under the recommendation tagged production

### Example 2
```
Get-RMRecommendationTagCount -recommendationType SECURE_STANDING_ACCESS_UNIX_602 -entityTags environment, production
```

Gets the number of accounts under the recommendation carrying either tag

## PARAMETERS

### -recommendationType
The identifier of the recommendation, from `Get-RMRecommendation`.

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

### -entityTags
Between one and five tags to filter the accounts by. Case-sensitive.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
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
