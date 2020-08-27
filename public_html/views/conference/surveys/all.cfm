<div id="survey">
note: a [0] in the [ratings] means they did not respond. The lowest possible rating for response was a "1".
<cfoutput query="surveys">
<div style="border:1px solid gray;margin:5px;padding:3px">
<ul style="list-style:none;margin-bottom:10px">
<li>#fname# #lname# #mailto(email)#</li>
<li>Ages: 0-9=#age0#; 10-19=#age10#; 20-29=#age20#; 30-39=#age30#; 40-49=#age40#; 50-59=#age50#; 60+=#age60#</li>
<li>I attended: #attend#</li>
<li>Who Paid: #paid#</li>
<li>Total Cost: #cost#</li>
<li>How many celebrations: #celebrations#</li>
<li>How many sponsored meals: #SPONSOREDLUNCHEONS#</li>
<li>Theme: [#theme#] #themecomments#</li>
<li>Location: [#location#] #locationcomments#</li>
<li>Speakers: [#speakers#] #speakerscomments#</li>
<li>Music: [#Music#] #Musiccomments#</li>
<li>Schedule: [#Schedule#] #Schedulecomments#</li>
<li>Sponsored Meals: [#luncheons#] #luncheonscomments#</li>
<li>Childcare (infant - Kindergarten): [#childcare#] #childcarecomments#</li>
<li>Kids Konference (grades 1-8: [#kidskonf#] #kidskonfcomments#</li>
<li>Please describe how you were able to apply FellowShift principles and concepts to your local church? <p>#apply#</p></li>
<li>What will you or your church do about planting new churches in this decade? <p>#churchplanting#</p></li>
<li>What will you or your church do about leadership development in this decade? <p>#leadership#</p></li>
<li>What will you or your church do about integrated ministry (loving people, meeting needs) in this decade? <p>#integrated#</p></li>
<li>General Suggestions: <p>#suggestions#</p></li>
<!---li>#author#</li--->
</ul>
#id#
</div>
</cfoutput>
</div>

