<cfoutput>
<div id="survey">
<div style="margin:0 auto;text-align:center">
[<a href="?event=v2015nyc">Flinch</a>]
[<a href="?event=v2014dc">FellowShift</a>]
[<a href="?event=v2020s">Vision2020South</a>]
[<a href="?event=v2020w">Vision2020West</a>]
[<a href="?event=v2020">Vision2020</a>]
[<a href="?event=cel2010">Celebration 2010</a>]
[<a href="?event=cel2008">iGo08</a>]
<!---
[<a href="comparison.cfm">Compare Numbers</a>]
--->
</div>

<div id="thankyou">
<h2>#conferencename#</h2>
This is a summary of <cfoutput>#data.recordcount#</cfoutput> survey responses for #conferenceNameShort#. To see individual survey's click #linkTo(text="HERE", controller="conference.surveys", action="all", params="event=v2014dc")#
</div>
<table>

<tr class="age">
<td colspan="2">Please indicate number of people that attended #conferenceNameShort# in your family by age brackets:</td></tr>
<tr class="age">
 <td class="ageoption">0-9</td>
 <td>#getsum("AGE0")#
 	<span style="font-size:.8em;color:gray">(in #comparisonyear# it was #getsum("AGE0",comparisonid)#)</span>
 </td> </tr>
<tr class="age">
 <td class="ageoption">10-19</td><td>#getsum("AGE10")# <span style="font-size:.8em;color:gray">(in #comparisonyear# it was #getsum("AGE10",comparisonid)# )</span></td> </tr>
<tr class="age">
 <td class="ageoption">20-29</td><td>#getsum("AGE20")#<span style="font-size:.8em;color:gray">(in #comparisonyear# it was #getsum("AGE20",comparisonid)# )</span></td> </tr>
<tr class="age">
 <td class="ageoption">30-39</td><td>#getsum("AGE30")# <span style="font-size:.8em;color:gray">(in #comparisonyear# it was #getsum("AGE30",comparisonid)# )</span></td> </tr>
<tr class="age">
 <td class="ageoption">40-49</td><td>#getsum("AGE40")# <span style="font-size:.8em;color:gray">(in #comparisonyear# it was #getsum("AGE40",comparisonid)# )</span></td> </tr>
<tr class="age">
 <td class="ageoption">50-59</td><td>#getsum("AGE50")# <span style="font-size:.8em;color:gray">(in #comparisonyear# it was #getsum("AGE50",comparisonid)# )</span></td> </tr>
<tr class="age">
 <td class="ageoption">60+</td><td>#getsum("AGE60")# <span style="font-size:.8em;color:gray">(in #comparisonyear# it was #getsum("AGE60",comparisonid)# )</span></td> </tr>
<tr class="age">
<td>Average Age of adults</td>
<td>
<cfset totalcount = getsum("AGE20") + getsum("AGE30") + getsum("AGE40") + getsum("AGE50") + getsum("AGE60")>
<cfset totalage = getsum("AGE20")*25 + getsum("AGE30")*35 + getsum("AGE40")*45 + getsum("AGE50")*55 + getsum("AGE50")*65>
<cftry><cfset average = totalage/totalcount><cfcatch></cfcatch></cftry>
<cftry>#numberformat(average,"99.9")#<cfcatch>NA</cfcatch></cftry>
<!---
<cfset totalcountcomp = thiscountcomp20 + thiscountcomp30 + thiscountcomp40 + thiscountcomp50 + thiscountcomp60>
<cfset totalagecomp = thiscountcomp20*25 + thiscountcomp30*35 + thiscountcomp40*45 + thiscountcomp50*55 + thiscountcomp60*65>
<cftry><cfset averagecomp = totalagecomp/totalcountcomp><cfcatch></cfcatch></cftry>
<cftry>(in #comparisonyear# it was #numberformat(averagecomp,"99.9")#)<cfcatch>NA</cfcatch></cftry>
--->
</td>
</tr>
<tr class="age">


 <td>How did you attend #conferenceNameShort#?</td><td>
 Alone: #numberformat(getCount("attend","alone",params.event).percent,"99.9")#%
 With your spouse: #numberformat(getCount("attend","spouse",params.event).percent,"99.9")#%
 With your family: #numberformat(getCount("attend","family",params.event).percent,"99.9")#%<br />
<span class="pastyear">In #comparisonyear#:
 Alone: #numberformat(getCount("attend","Alone",comparisonid).percent,"99.9")#%
 With your spouse: #numberformat(getCount("attend","Spouse",comparisonid).percent,"99.9")#%
 With your family: #numberformat(getCount("attend","Family",comparisonid).percent,"99.9")#%
</span>
</td>
</tr>
<tr class="cost">
 <td>Who paid the cost of attending #conferenceNameShort#?</td>
 <td>
<cfset thisquestion = "paid">
<cfset optionlist = "employer paid all of my cost,employer paid all of my and my spouse,employer paid all my family,we paid the total cost ourselves">
<cfloop list="#optionlist#" index="i">
	#i#: #numberformat(getCount(thisquestion,i,params.event).percent,"99.9")#%
</cfloop><br />
<span class="pastyear">in #comparisonyear#:
<cfset thisquestion = "paid">
<cfset optionlist = "my cost,my and my spouse,my family,ourselves">
<cfloop list="#optionlist#" index="i">
	#i#: #numberformat(getCount(thisquestion,i,comparisonid).percent,"99.9")#%
</cfloop>
</span>

</td> </tr>
<tr class="cost">
 <td>What was the total cost for you and your family to attend conference including travel, lodging, food and registration?</td>
 <td>Average: #dollarformat(getAvg("cost"))# <span class="pastyear">Average in #comparisonyear#: #dollarformat(getAvg("cost",comparisonid))#</span></td> </tr>

<tr class="count">
 <td>How many celebrations did you attend?</td>
 <td>Average (of 8): #numberformat(getAvg("celebrations"),"99.9")# </td>
</tr>

<tr class="count">
 <td>How many sponsored meals did you attend?</td>
 <td>Average (of 9): #numberformat(getAvg("SPONSOREDLUNCHEONS"),"99.9")# </td>
</tr>
<tr class="ratings">
<td colspan="2">One a scale of 1-10, 10 being the highest, rate the following aspects of #conferenceNameShort#. Leave the response "Select" if you did not attend the event(s). Use the space provide after each item for general comments about that aspect of the conference.</td></tr>

<cfset label = "Conference Theme">
<cfset thisquestion = "Theme">
<cfset average = getAvg(thisquestion)>

<cfif val(average)>
<tr class="ratings">
 <td>#label#</td>
 <td>#numberformat(average,"99.9")# out of 10 <span class="pastyear">
 <cfset average = getAvg(thisquestion,comparisonid)>
(in #comparisonyear# it was #numberformat(average,"99.9")#)</span> [<a href="comments/?question=#thisquestion#&event=#event#">See Comments</a>][#linkto(text="Spread", controller="conference.surveys", action="spread", params="event=#event#&question=#thisquestion#")#]</td>
</tr>
</cfif>

<cfset label = "Conference Location (#location#)">
<cfset thisquestion = "LOCATION">
<cfset average = getAvg(thisquestion)>

<cfif val(average)>
<tr class="ratings">
 <td>#label#</td>
 <td>#numberformat(average,"99.9")# out of 10 <span class="pastyear">
 <cfset average = getAvg(thisquestion,comparisonid)>
(in #comparisonyear# it was #numberformat(average,"99.9")#)</span> [<a href="comments/?question=#thisquestion#&event=#event#">See Comments</a>][#linkto(text="Spread", controller="conference.surveys", action="spread", params="event=#event#&question=#thisquestion#")#]</td>
</tr>
</cfif>

<cfset label = "Conference Speakers">
<cfset thisquestion = "SPEAKERS">
<cfset average = getAvg(thisquestion)>

<cfif val(average)>
<tr class="ratings">
 <td>#label#</td>
 <td>#numberformat(average,"99.9")# out of 10 <span class="pastyear">
 <cfset average = getAvg(thisquestion,comparisonid)>
 (in #comparisonyear# it was #numberformat(average,"99.9")#)</span> [<a href="comments/?question=#thisquestion#&event=#event#">See Comments</a>][#linkto(text="Spread", controller="conference.surveys", action="spread", params="event=#event#&question=#thisquestion#")#]</td>
</tr>
</cfif>

<cfset label = "Worship Music">
<cfset thisquestion = "MUSIC">
<cfset average = getAvg(thisquestion)>

<cfif val(average)>
<tr class="ratings">
 <td>#label#</td>
 <td>#numberformat(average,"99.9")# out of 10 <span class="pastyear">
 <cfset average = getAvg(thisquestion,comparisonid)>
 (in #comparisonyear# it was #numberformat(average,"99.9")#)</span> [<a href="comments/?question=#thisquestion#&event=#event#">See Comments</a>][#linkto(text="Spread", controller="conference.surveys", action="spread", params="question=#thisquestion#&event=#event#")#]</td>
</tr>
</cfif>

<cfset label = "Overall conference schedule">
<cfset thisquestion = "SCHEDULE">
<cfset average = getAvg(thisquestion)>

<cfif val(average)>
<tr class="ratings">
 <td>#label#</td>
 <td>#numberformat(average,"99.9")# out of 10 <span class="pastyear">
 <cfset average = getAvg(thisquestion,comparisonid)>
 (in #comparisonyear# it was #numberformat(average,"99.9")#)</span> [<a href="comments/?question=#thisquestion#&event=#event#">See Comments</a>][#linkto(text="Spread", controller="conference.surveys", action="spread", params="question=#thisquestion#&event=#event#")#]</td>
</tr>
</cfif>

<cfset label = "Sponsored Meals">
<cfset thisquestion = "LUNCHEONS">
<cfset average = getAvg(thisquestion)>

<cfif val(average)>
<tr class="ratings">
 <td>#label#</td>
 <td>#numberformat(average,"99.9")# out of 10 <span class="pastyear">
 <cfset average = getAvg(thisquestion,comparisonid)>
(in #comparisonyear# it was #numberformat(average,"99.9")#)</span> [<a href="comments/?question=#thisquestion#&event=#event#">See Comments</a>][#linkto(text="Spread", controller="conference.surveys", action="spread", params="question=#thisquestion#&event=#event#")#]</td>
</tr>
</cfif>

<cfset label = "Pre-conference">
<cfset thisquestion = "preconference">
<cfset average = getAvg(thisquestion)>

<cfif val(average)>
<tr class="ratings">
 <td>#label#</td>
 <td>#numberformat(average,"99.9")# out of 10 <span class="pastyear">
 <cfset average = getAvg(thisquestion,comparisonid)>
(in #comparisonyear# it was #numberformat(average,"99.9")#)</span> [<a href="comments/?question=#thisquestion#&event=#event#">See Comments</a>][#linkto(text="Spread", controller="conference.surveys", action="spread", params="question=#thisquestion#&event=#event#")#]</td>
</tr>
</cfif>

<cfset label = "Childcare (infant - Kindergarten)">
<cfset thisquestion = "CHILDCARE">
<cfset average = getAvg(thisquestion)>

<cfif val(average)>
<tr class="ratings">
 <td>#label#</td>
 <td>#numberformat(average,"99.9")# out of 10 <span class="pastyear">
 <cfset average = getAvg(thisquestion,comparisonid)>
 (in #comparisonyear# it was #numberformat(average,"99.9")#)</span> [<a href="comments/?question=#thisquestion#&event=#event#">See Comments</a>][#linkto(text="Spread", controller="conference.surveys", action="spread", params="question=#thisquestion#&event=#event#")#]</td>
</tr>
</cfif>

<cfset label = "Kids Konference (grades 1-8">
<cfset thisquestion = "KIDSKONF">
<cfset average = getAvg(thisquestion)>

<cfif val(average)>
	<tr class="ratings">
	 <td>#label#</td>
	 <td>#numberformat(average,"99.9")# out of 10 <span class="pastyear">
		<cfset average = getAvg(thisquestion,comparisonid)>
	  (in #comparisonyear# it was #numberformat(average,"99.9")#)</span> [<a href="comments/?question=#thisquestion#&event=#event#">See Comments</a>][#linkto(text="Spread", controller="conference.surveys", action="spread", params="question=#thisquestion#&event=#event#")#]</td>
	</tr>
</cfif>

<tr class="effect">
 <td>Please describe how you were able to apply the #conferenceNameShort# theme and concepts to your local church?</td><td>[<a href="comments/?question=apply&event=#event#">See Comments</a>]</td> </tr>

<tr class="effect">
 <td>What will you or your church do about planting new churches in this decade?</td><td>[<a href="comments./question=churchplanting&event=#event#">See Comments</a>]</td> </tr>

<tr class="effect">
 <td>What will you or your church do about leadership development in this decade?</td><td>[<a href="comments/?question=leadership&event=#event#">See Comments</a>]</td> </tr>

<tr class="effect">
 <td>What will you or your church do about integrated ministry (loving people, meeting needs) in this decade?</td><td>[<a href="comments/?question=integrated&event=#event#">See Comments</a>]</td> </tr>

<tr class="other">
 <td>Other suggestions for future planning:</td><td>[<a href="comments/?question=suggestions&event=#event#">See Comments</a>]</td> </tr>

 </table>
</cfoutput>

</div>
