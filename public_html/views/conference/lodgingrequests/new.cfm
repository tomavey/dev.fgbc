<div id="welcome"  class="container lodgingrequest" ng-app="lodgingRequestsApp">

<cfoutput>

<cfif isDefined("params.open") OR gotRights("office")>

<div class="row-fluid well contentStart contentBg" ng-controller="newController">
<h3 ng-bind-html="questions.welcome" style="text-align:center"></h3>
<p ng-bind-html="questions.info1"></p>
<p ng-bind-html="questions.info2"></p>
<p ng-bind-html="questions.info3"></p>
<p><span style="color:red">*</span> = required</p>
  <form name="lodgingRequestForm" ng-submit="addLodgingRequest(lodgingRequestForm.$valid)" novalidate>
    <p>
        <input ng-model="lodgingRequest.email" name="email" type="email" class="form-control" placeholder="{{questions.email}}" required >
        <span ng-show="lodgingRequestForm.email.$invalid" class="help-inline" style="color:red">*</span>
    </p>

    <p>
        <input ng-model="lodgingRequest.name" name="name" type="text" placeholder="{{questions.name}}" required ng-minlength="5" class="input-xxlarge">
        <span ng-show="lodgingRequestForm.name.$invalid" class="help-inline" style="color:red">*</span>
     </p>

     <p>
        <input ng-model="lodgingRequest.phone" name="phone" type="text" placeholder="{{questions.phone}}" required ng-minlength="10">
        <span ng-show="lodgingRequestForm.phone.$invalid" class="help-inline" style="color:red">*</span>
    </p>

     <p>
        {{questions.age}}
        <select name="age" ng-model="lodgingRequest.age" class="input-xlarge">
            <option value="">---Please Select---</option>
            <option value="16-24">16-24</option>
            <option value="25-29">25-29</option>
            <option value="30-39">30's</option>
        </select>
        <span ng-show="lodgingRequestForm.age.$invalid" class="help-inline" style="color:red">*</span>
    </p>

     <p>
        <input ng-model="lodgingRequest.church" name="church" type="text" placeholder="{{questions.church}}" required ng-minlength="5" class="input-xlarge">
        <span ng-show="lodgingRequestForm.church.$invalid" class="help-inline" style="color:red">*</span>
    </p>

    <p>
        <input ng-model="lodgingRequest.churchcitystate" name="churchcitystate" type="text" placeholder="{{questions.churchcitystate}}" required ng-minlength="5" class="input-xlarge">
        <span ng-show="lodgingRequestForm.churchcitystate.$invalid" class="help-inline" style="color:red">*</span>
     </p>

     <p>
        <input ng-model="lodgingRequest.churchpastor" name="churchpastor" type="text" placeholder="{{questions.churchpastor}}"required  ng-minlength="5" class="input-xlarge">
        <span ng-show="lodgingRequestForm.churchpastor.$invalid" class="help-inline" style="color:red">*</span>
    </p>

    <p>
        <input ng-model="lodgingRequest.pastoremail" name="pastoremail" placeholder="{{questions.pastoremail}}" type="email" required ng-minlength="5" class="input-xlarge">
        <span ng-show="lodgingRequestForm.pastoremail.$invalid" class="help-inline" style="color:red">*</span>
    </p>

    <p>
        <input ng-model="lodgingRequest.arrive" name="arrive" type="text" placeholder="{{questions.arrive}}" required ng-minlength="3" class="input-xxlarge">
        <span ng-show="lodgingRequestForm.arrive.$invalid" class="help-inline" style="color:red">*</span>
    </p>

    <p>
        <input ng-model="lodgingRequest.depart" name="depart" type="text" placeholder="{{questions.depart}}" required ng-minlength="3" class="input-xxlarge">
        <span ng-show="lodgingRequestForm.depart.$invalid" class="help-inline" style="color:red">*</span>
    </p>

    <p>
        <input ng-model="lodgingRequest.howmuch" name="howmuch" type="text" placeholder="{{questions.howmuch}}" required ng-minlength="3" class="input-xxlarge">
        <span ng-show="lodgingRequestForm.howmuch.$invalid" class="help-inline" style="color:red">*</span>
    </p>

    <div class="well">
        <p>{{questions.ministry}}</p>
        <textarea ckeditor="editorOptions" name="ministry" ng-model="lodgingRequest.ministry" placeholder="{{questions.ministry}}" required ng-minlength="10"></textarea>
        <span ng-show="lodgingRequestForm.ministry.$invalid" class="help-inline">REQUIRED</span>
    </div>

    <div class="well">
        <p>{{questions.why}}</p>
        <textarea ckeditor="editorOptions" name="why" ng-model="lodgingRequest.why" required ng-minlength="10"></textarea>
        <span ng-show="lodgingRequestForm.why.$invalid" class="help-inline">REQUIRED</span>
       </div>

    <div class="well">
        <p>{{questions.other}}</p>
        <textarea ckeditor="editorOptions" name="other" ng-model="lodgingRequest.other"></textarea>
    </div>

    <div class="well">
        <p>{{questions.officecomments}}</p>
        <textarea ckeditor="editorOptions" name="other" ng-model="lodgingRequest.officecomments"></textarea>
    </div>

    <p>
        <input type="number" ng-model="lodgingRequest.officebudget" name="officebudget" class="form-control" placeholder="{{questions.officebudget}}" >
    </p>

    <input value="{{questions.submit}}" type="submit" ng-disabled="lodgingRequestForm.$invalid" class="btn btn-large btn-block btn-primary">
    <p ng-show="lodgingRequestForm.$invalid" class="help-block">Form not complete yet. Check notations above to see which information is required.</p>
  </form>

</div>

<cfelse>

    <h3 style="text-align:center">Wow, we had lots of requests for lodging assistance.  Unfortunately, our funds for this project are depleted.  We hope to offer lodging assistance again next year</h3>

</cfif>

#includePartial('scripts')#
</cfoutput>

</div>