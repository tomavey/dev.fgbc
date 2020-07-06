<div ng-controller="indexController" class="row-fluid well contentStart contentBg">

<div ng-app="crudApp">
    <div ng-controller="questionsController">
        <div ng-repeat="question in questions" class="well">
            <p>Key: <span ng-bind-html="question.key"></span></p>
            <p>Question: <span ng-bind-html="question.question"></span></p>
            <p>Input type: <span ng-bind-html="question.inputtype"></span></p>
            <p>Validation: <span ng-bind-html="question.validation"></span></p>
        </div>

    </div>
</div>

</div>

<cfoutput>
    #includePartial('scripts')#
</cfoutput>
