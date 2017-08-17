<div ng-app="newMinistriesApp">

<cfoutput>

<div class="row-fluid well contentStart contentBg" ng-controller="newController">
  <h3 ng-if="!showForm(ministry)">LOADING...</h3>  
  <form name="ministryForm" ng-submit="addMinistry(ministryForm.$valid)" novalidate ng-if="showForm(ministry)">
    <p>
        The email address of the person filling out this form...<br/>
        <input ng-model="ministry.contactemail" name="contactemail" type="email" class="form-control" placeholder="{{questions.contactemail}}" required >
        <span ng-show="ministryForm.contactemail.$invalid && !ministryForm.contactemail.$pristine" class="help-inline">Enter a valid email.</span>
        <span ng-show="ministryForm.contactemail.$invalid && ministryForm.contactemail.$pristine" class="help-inline" ><sup>required</sup></span>
    </p>

    <input ng-model="ministry.name" name="name" type="text" placeholder="{{questions.name}}" required ng-minlength="5">
        <span ng-show="ministryForm.name.$invalid && !ministryForm.name.$pristine" class="help-inline">Enter the name of your ministry - required</span>
        <span ng-show="ministryForm.name.$invalid && ministryForm.name.$pristine" class="help-inline"><sup>required</sup></span>
        <br/>
    <input ng-model="ministry.address1" type="text" placeholder="{{questions.address1}}">
    <input ng-model="ministry.address2" type="text" placeholder="{{questions.address2}}">
    <input ng-model="ministry.city" type="text" placeholder="{{questions.city}}">
    <input ng-model="ministry.state" type="text" placeholder="{{questions.state}}">
    <input ng-model="ministry.zip" type="text" placeholder="{{questions.zip}}">
    <input ng-model="ministry.phone" type="text" placeholder="{{questions.phone}}">
    <input ng-model="ministry.email" type="text" placeholder="{{questions.email}}">
    <input ng-model="ministry.website" name="website" type="text" placeholder="{{questions.website}}" ng-minlength="3">

    <div class="well">
        <p ng-bind-html="questions.officers"></p>
        <span ng-show="ministryForm.officers.$invalid" class="help-inline"><sup>Required</sup></span>
        <textarea ckeditor="editorOptions" name="officers" ng-model="ministry.officers" required ng-minlength="{{defaultRequiredLength}}"></textarea>
    </div>

    <div class="well">
        <p ng-bind-html="questions.priorities"></p>
        <span ng-show="ministryForm.priorities.$invalid" class="help-inline"><sup>Required</sup></span>
        <textarea ckeditor="editorOptions" name="priorities" ng-model="ministry.priorities" required ng-minlength="{{defaultRequiredLength}}"></textarea>
    </div>

    <div class="well">
        <p ng-bind-html="questions.harmony"></p>
        <span ng-show="ministryForm.harmony.$invalid" class="help-inline"><sup>Required</sup></span>
        <p><input type="radio" name="harmony" ng-model="ministry.harmony" value="Yes"> Yes</p>
        <p><input type="radio" name="harmony" ng-model="ministry.harmony" value="No"> No</p>
        <p><input type="radio" name="harmony" ng-model="ministry.harmony" value="Call me"> Call Me</p>
    </div>

    <div class="well">
        <p ng-bind-html="questions.sponsored"></p>
        <span ng-show="ministryForm.sponsored.$invalid" class="help-inline"><sup>Required</sup></span>
        <textarea ckeditor="editorOptions" name="sponsored" ng-model="ministry.sponsored" required ng-minlength="{{defaultRequiredLength}}"></textarea>
    </div>

    <div class="well">
        <p ng-bind-html="questions.association"></p>
        <span ng-show="ministryForm.association.$invalid" class="help-inline"><sup>Required</sup></span>
        <textarea ckeditor="editorOptions" name="association" ng-model="ministry.association" required ng-minlength="3"></textarea>
    </div>

    <div class="well">
        <p ng-bind-html="questions.scope"></p>
        <span ng-show="ministryForm.scope.$invalid" class="help-inline"><sup>Required</sup></span>
        <textarea ckeditor="editorOptions" name="scope" ng-model="ministry.scope" required ng-minlength="3"></textarea>
    </div>

     <div class="well">
      <p ng-bind-html="questions.greatcommission"></p>
      <span ng-show="ministryForm.greatcommission.$invalid" class="help-inline"><sup>Required</sup></span>
      <textarea ckeditor="editorOptions" name="greatcommission" ng-model="ministry.greatcommission" required ng-minlength="{{defaultRequiredLength}}"></textarea>
    </div>

     <div class="well">
      <p ng-bind-html="questions.unity"></p>
        <span ng-show="ministryForm.unity.$invalid" class="help-inline"><sup>Required</sup></span>
        <textarea ckeditor="editorOptions" name="unity" ng-model="ministry.unity" required ng-minlength="3"></textarea>
    </div>

    <div class="well">
        <p>{{questions.obligation}}</p>
        <input ng-model="ministry.obligation" type="text" >
    </div>

    <div class="well">
      <p ng-bind-html="questions.review"></p>
      <p ng-bind-html="questions.MOP"></p>

        <p><span ng-bind-html="questions.creation"></span>
            <input type="text" name="creation" ng-model="ministry.creation" >
        </p>

        <p><span ng-bind-html="questions.integral"></span>
            <input type="text" name="integral" ng-model="ministry.integral" >
         </p>

        <p><span ng-bind-html="questions.controlled"></span>
            <input type="text" name="controlled" ng-model="ministry.controlled" >
        </p>

        <p><span ng-bind-html="questions.report"></span>
            <input type="text" name="report" ng-model="ministry.report" >
        </p>

    </div>

   <div class="well">
      <p ng-bind-html="questions.history"></p>
      <span ng-show="ministryForm.history.$invalid" class="help-inline"><sup>Required</sup></span>
      <textarea ckeditor="editorOptions" name="history" ng-model="ministry.history" required ng-minlength="{{defaultRequiredLength}}"></textarea>
      {{ministryForm.why}}
    </div>

    <input value="{{questions.submit}}" type="submit">
  </form>

</div>

#includePartial('scripts')#
</cfoutput>

</div>