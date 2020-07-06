<div class="row-fluid well contentStart contentBg" ng-controller="showController" >
<div ng-repeat="question in questions">
    <p>{{question.question}}: <span ng-bind-html="answer[question.key]"></span></p>
</div>

      <a ui-sref="index" class="btn pull-right" ng-show="gotRights('office')">List</a>

</div>
</div>
