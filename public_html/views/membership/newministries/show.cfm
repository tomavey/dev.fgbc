<div ng-app="newMinistriesApp">
<cfoutput>

<div ng-controller="showController" class="row-fluid well contentStart contentBg newministryshow">

<cfif gotRights("office")>
#linkTo(text="Edit", action="new", params="id=#params.id#", class="btn")#
</cfif>

<div class="contactinfo">
<h2 ng-show='!ministry.name.length'>Ministry info is loading...</h2>
<h3>{{ministry.name}}</h3>
Contact Email: {{ministry.contactemail}}<br/>
{{ministry.address1}}<br/>
<span ng-show="ministry.address.length">{{ministry.address2}}</span><br ng-show="ministry.address.length" />
{{ministry.city}}<span ng-show="ministry.city.length && ministry.state.length"}}>,</span> {{ministry.state}} {{ministry.zip}}<br/>
{{questions.email}}: {{ministry.email}}<br/>
{{questions.phone}}: {{ministry.phone}}<br/>
{{questions.contactemail}}: {{ministry.contactemail}}<br/><br/>
</div>

<div class="eachquestion">
<p ng-bind-html="questions.officers" class="question"></p>
<p ng-bind-html="ministry.officers" class="answer"></p>
</div>

<div class="eachquestion">
<p ng-bind-html="questions.priorities" class="question"></p>
<p ng-bind-html="ministry.priorities" class="answer"></p>
</div>

<div class="eachquestion">
<p ng-bind-html="questions.harmony" class="question"></p>
<p ng-bind-html="ministry.harmony" class="answer"></p>
</div>

<div class="eachquestion">
<p ng-bind-html="questions.sponsored" class="question"></p>
<p ng-bind-html="ministry.sponsored" class="answer"></p>
</div>

<div class="eachquestion">
<p ng-bind-html="questions.association" class="question"></p>
<p ng-bind-html="ministry.association" class="answer"></p>
</div>

<div class="eachquestion">
<p ng-bind-html="questions.scope" class="question"></p>
<p ng-bind-html="ministry.scope" class="answer"></p>
</div>

<div class="eachquestion">
<p ng-bind-html="questions.greatcommission" class="question"></p>
<p ng-bind-html="ministry.greatcommission" class="answer"></p>
</div>

<div class="eachquestion">
<p ng-bind-html="questions.unity" class="question"></p>
<p ng-bind-html="ministry.unity" class="answer"></p>
</div>

<div class="eachquestion">
<p ng-bind-html="questions.obligation" class="question"></p>
<p ng-bind-html="ministry.obligation" class="answer"></p>
</div>

<div class="eachquestion">
<p ng-bind-html="questions.review" class="question"></p>
<p ng-bind-html="questions.MOP" class="question"></p>
<p ng-bind-html="ministry.MOP" class="answer"></p>
</div>

<div class="eachquestion">
<p><span ng-bind-html="questions.creation" class="question"></span><span ng-bind-html="ministry.obligation"></span></p>
<p><span ng-bind-html="questions.integral" class="question"></span><span ng-bind-html="ministry.integral"></span></p>
<p><span ng-bind-html="questions.controlled" class="question"></span><span ng-bind-html="ministry.controlled"></span></p>
<p><span ng-bind-html="questions.report" class="question"></span><span ng-bind-html="ministry.report"></span></p>
</div>

<div class="eachquestion">
<p ng-bind-html="questions.history" class="question"></p>
<p ng-bind-html="ministry.history" class="answer"></p>
</div>

</div>

#includePartial("scripts")#

</cfoutput>
</div>

