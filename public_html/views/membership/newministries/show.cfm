<div id="newMinistriesApp" class="container">
<cfoutput>

<div class="row-fluid well contentStart contentBg newministryshow">

<cfif gotRights("office")>
    #linkTo(text="Edit", action="new", params="id=#params.id#", class="btn")#
</cfif>

<div class="contactinfo">

<h3>{{ministry.name}}</h3>
Contact Email: {{ministry.contactemail}}<br/>
{{ministry.address1}}<br/>
<span v-show="ministry.address.length">{{ministry.address2}}</span><br v-show="ministry.address.length" />
{{ministry.city}}<span v-show="ministry.city.length && ministry.state.length"}}>,</span> {{ministry.state}} {{ministry.zip}}<br/>
{{questions.email}}: {{ministry.email}}<br/>
{{questions.phone}}: {{ministry.phone}}<br/>
{{questions.contactemail}}: {{ministry.contactemail}}<br/><br/>
</div>

<div class="eachquestion">
<p v-bind-html="questions.officers" class="question"></p>
<p v-bind-html="ministry.officers" class="answer"></p>
</div>

<div class="eachquestion">
<p v-bind-html="questions.priorities" class="question"></p>
<p v-bind-html="ministry.priorities" class="answer"></p>
</div>

<div class="eachquestion">
<p v-bind-html="questions.harmony" class="question"></p>
<p v-bind-html="ministry.harmony" class="answer"></p>
</div>

<div class="eachquestion">
<p v-bind-html="questions.sponsored" class="question"></p>
<p v-bind-html="ministry.sponsored" class="answer"></p>
</div>

<div class="eachquestion">
<p v-bind-html="questions.association" class="question"></p>
<p v-bind-html="ministry.association" class="answer"></p>
</div>

<div class="eachquestion">
<p v-bind-html="questions.scope" class="question"></p>
<p v-bind-html="ministry.scope" class="answer"></p>
</div>

<div class="eachquestion">
<p v-bind-html="questions.greatcommission" class="question"></p>
<p v-bind-html="ministry.greatcommission" class="answer"></p>
</div>

<div class="eachquestion">
<p v-bind-html="questions.unity" class="question"></p>
<p v-bind-html="ministry.unity" class="answer"></p>
</div>

<div class="eachquestion">
<p v-bind-html="questions.obligation" class="question"></p>
<p v-bind-html="ministry.obligation" class="answer"></p>
</div>

<div class="eachquestion">
<p v-bind-html="questions.review" class="question"></p>
<p v-bind-html="questions.MOP" class="question"></p>
<p v-bind-html="ministry.MOP" class="answer"></p>
</div>

<div class="eachquestion">
<p><span v-bind-html="questions.creation" class="question"></span><span v-bind-html="ministry.obligation"></span></p>
<p><span v-bind-html="questions.integral" class="question"></span><span v-bind-html="ministry.integral"></span></p>
<p><span v-bind-html="questions.controlled" class="question"></span><span v-bind-html="ministry.controlled"></span></p>
<p><span v-bind-html="questions.report" class="question"></span><span v-bind-html="ministry.report"></span></p>
</div>

<div class="eachquestion">
<p v-bind-html="questions.history" class="question"></p>
<p v-bind-html="ministry.history" class="answer"></p>
</div>

</div>

#includePartial("scripts")#

</cfoutput>
</div>

