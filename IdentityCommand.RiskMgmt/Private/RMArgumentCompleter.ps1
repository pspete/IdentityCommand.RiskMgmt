#The completer helper functions live in IdentityCommand's Private folder, which the psm1 loads
#into this module's scope.

#region Registration

#entityTypes is documented with four allowed values but typed as a free string in the spec, so it
#is offered as a completion rather than enforced with a ValidateSet.
$EntityTypeCompleter = {
    $wordToComplete = $args[2]
    @('USER', 'FEDERATED_USER', 'FEDERATED_GROUP', 'WEBAPP') |
        ForEach-Object { [pscustomobject]@{ entityType = $_ } } |
        Get-CompletionResult -WordToComplete $wordToComplete -ValueProperty entityType
}

Register-ArgumentCompleter -ParameterName 'entityTypes' -ScriptBlock $EntityTypeCompleter -CommandName @(
    'Get-RMFinding'
    'Get-RMRemediation'
    'Get-RMRiskProgress'
    'Get-RMRiskType'
)

Register-ArgumentCompleter -ParameterName 'entityType' -ScriptBlock $EntityTypeCompleter -CommandName 'New-RMRemediation'

Register-ArgumentCompleter -ParameterName 'recommendationType' -ScriptBlock (
    Get-ArgumentCompleter -RetrievalCommand 'Get-RMRecommendation' -ValueProperty 'recommendationType'
) -CommandName 'Get-RMRecommendationTagCount'

Register-ArgumentCompleter -ParameterName 'ids' -ScriptBlock (
    Get-ArgumentCompleter -RetrievalCommand 'Get-RMRemediation' -ValueProperty 'id' -LabelProperty 'name'
) -CommandName 'Get-RMRemediation'

#endregion Registration
