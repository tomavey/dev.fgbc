<div class="row-fluid well contentStart contentBg" ng-controller="newController" >
    <form name="crudForm" ng-submit="addAnswer()">
        <div class="eachQuestion" ng-repeat="question in questions" ng-show="questions.length">
            <div ng-if="question.inputtype === 'text'">
                <input type='text' ng-model='answer[question.key]' name='{{question.key}}' {{validation}} placeholder='{{question.question}}' class="input-xlarge">
            </div>
            <div ng-if="question.inputtype === 'email'">
                <input type='email' ng-model='answer[question.key]' name='{{question.key}}' required placeholder='{{question.question}}'>
            </div>
            <div ng-if="question.inputtype === 'selectYesNo'">
                <select ng-model='answer[question.key' class="input-small">
                  <option value="yes">Yes</option>
                  <option value="no">No</option>
                </select>
            </div>
            <div ng-if="question.inputtype === 'textarea'" class="well">
                <p ng-bind-html="question.question"></p>
                <textarea ckeditor="editorOptions" ng-model='answer[question.key]' name='{{question.key}}' placeholder='{{question.question}}'></textarea>
            </div>
        </div>
        <input type="submit" name="submit" value="Submit" />
    </form>

</div>
