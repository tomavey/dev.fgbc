<cfoutput>
<div ng-app="lodgingRequestsApp">
<div ng-controller="ckeditorController" class="row-fluid well contentStart contentBg">
{{modelName}}
<textarea ckeditor="editorOptions" ng-model="modelName"></textarea>
</div>
</div>

#includePartial("scripts")#

</cfoutput>