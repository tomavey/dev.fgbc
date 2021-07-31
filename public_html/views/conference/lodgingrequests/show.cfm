<div ng-app="lodgingRequestsApp">
<cfoutput>

<div ng-controller="showController" class="row-fluid well contentStart contentBg newministryshow">
<cfif gotRights("office")>
#linkTo(text="Edit", action="new", params="id=#params.id#", class="btn")#
</cfif>

<div class="contactinfo">
<h2 ng-show='!lodgingRequest.name.length'>Request Info is loading...</h2>
<h3>{{lodgingRequest.name}}</h3>
Email: {{lodgingRequest.email}}<br/>
{{questions.phone}}: {{lodgingRequest.phone}}<br/>
{{questions.age}}: {{lodgingRequest.age}}<br/>
{{questions.church}}: {{lodgingRequest.church}}<br/><br/>
{{questions.churchcitystate}}: {{lodgingRequest.churchcitystate}}<br/><br/>
{{questions.churchpastor}}: {{lodgingRequest.churchpastor}}<br/><br/>
{{questions.pastoremail}}: {{lodgingRequest.pastoremail}}<br/><br/>
</div>

<div class="eachquestion">
<p ng-bind-html="questions.ministry" class="question"></p>
<p ng-bind-html="lodgingRequest.ministry" class="answer"></p>
</div>

<div class="eachquestion">
<p ng-bind-html="questions.why" class="question"></p>
<p ng-bind-html="lodgingRequest.why" class="answer"></p>
</div>

<div class="eachquestion">
<p ng-bind-html="questions.other" class="question"></p>
<p ng-bind-html="lodgingRequest.other" class="answer"></p>
</div>

<div class="eachquestion">
<p ng-bind-html="questions.officecomments" class="question"></p>
<p ng-bind-html="lodgingRequest.officecomments" class="answer"></p>
</div>

<div class="eachquestion">
<p ng-bind-html="questions.officebudget" class="question"></p>
<p ng-bind-html="lodgingRequest.officebudget" class="answer"></p>
</div>

</div>


#includePartial(partial="scripts")#

</cfoutput>
</div>

