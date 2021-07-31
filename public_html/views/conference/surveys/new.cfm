<cfoutput>
<div id="survey">
    <div id="thankyou">
    <cfif conferencenameshort is "Vision2020South">
    <img src="http://www.fgbc.org/vision2020/images/vision2020south_web250.jpg">
    </cfif>
    <h2>#conferenceName#</h2>
    Thanks so much for helping us evaluate the #conferenceName#. We deeply appreciate your partnership in planting churches, developing leaders and loving people. This survey can help us improve in our service to you!
    </div>

#startFormTag(action="create")#
    <cfif isDefined("params.author")>
        #hiddenFieldTag(name="author", value=params.author)#
    </cfif>
        #hiddenFieldTag(name="event", value=event)#
    <table>

        <tr>
            <td>Name & email:</td>
            <td>
                #textFieldTag(name="fname", placeholder="First Name", prepend="", append="")#
                #textFieldTag(name="lname", placeholder="Last Name", prepend="", append="")#
                #textFieldTag(name="email", placeholder="Email", prepend="", append="")#
            </td>
        </tr>

        <tr class="age">
            <td colspan="2">
                Please indicate number of people that attended #conferenceNameShort# in your family by age brackets:
            </td>
        </tr>

        <tr class="age">
         	<td class="ageoption">
            	0-9
            </td>
            <td>
            	<select name="age0" id="age0">
                	#optionslist("0,1,2,3,4,5")#>
                </select>
            </td>
        </tr>

        <tr class="age">
	         <td class="ageoption">
             	10-19
             </td>
             <td>
             	<select name="age10" id="age10">
                    #optionslist("0,1,2,3,4,5")#>
                </select>
             </td>
        </tr>

        <tr class="age">
         	<td class="ageoption">
            	20-29
            </td>
            <td>
            	<select name="age20" id="age20">
                    #optionslist("0,1,2,3,4,5")#>
                </select>
            </td>
        </tr>

        <tr class="age">
         	<td class="ageoption">
            	30-39
            </td>
            <td>
            	<select name="age30" id="age30">
                    #optionslist("0,1,2,3,4,5")#>
                </select>
            </td>
        </tr>
        <tr class="age">
         	<td class="ageoption">
            	40-49
            </td>
            <td>
            	<select name="age40" id="age40">
                    #optionslist("0,1,2,3,4,5")#>
                </select>
            </td>
        </tr>
        <tr class="age">
         	<td class="ageoption">
            	50-59
            </td>
            <td>
            	<select name="age50" id="age50">
                    #optionslist("0,1,2,3,4,5")#>
                </select>
            </td>
        </tr>
        <tr class="age">
         	<td class="ageoption">
            	60+
            </td>
            <td>
            	<select name="age60" id="age60">
                    #optionslist("0,1,2,3,4,5")#>
                </select>
            </td>
        </tr>
        <tr class="age">
         	<td>
            	How did you attend #conferenceNameShort#?
            </td>
            <td>
            	<select name="attend" id="attend">
                	#optionslist("Alone,With your spouse,With your family")#
            </td>
        </tr>

        <tr class="cost">
         	<td>
            	Who paid the cost of attending #conferenceNameShort#?
            </td>
            <td>
            	<select name="paid" id="whopaid">
                	#optionslist("My employer paid all of my cost,My employer paid all of my and my spouse's cost,My employer paid all my family's cost,We paid the total cost ourselves")#
            </td>
        </tr>
        <tr class="cost">
         	<td>
            	What was the total cost for you and your family to attend conference including travel, lodging, food and registration?
            </td>
            <td>
                #textFieldTag(text="COST", name="cost")#
            </td>
        </tr>

        <tr class="count">
         	<td>
            	How many celebrations did you attend?
            </td>
            <td>
            	<select name="CELEBRATIONS" id="celebrations">
                    #optionslist("0,1,2,3,4,5")#>
                </select>
            </td>
        </tr>
        <tr class="count">
         	<td>
            	How many sponsored meals did you attend?
            </td>
            <td>
            	<select name="SPONSOREDLUNCHEONS" id="luncheons">
                    #optionslist("0,1,2,3,4,5,6,7,8")#>
                </select>
            </td>
        </tr>

        <tr class="ratings">
        	<td colspan="2">
            	On a scale of 1-10, 10 being the highest, rate the following aspects of #conferenceNameShort#. Leave the response "Select" if you did not attend the event(s). Use the space provide after each item for general comments about that aspect of the conference.
        	</td>
        </tr>
        <tr class="ratings">
         	<td>
            	Conference Theme
            </td>
            <td>
            	<select name="theme">
                    #optionslist()#>
                </select>
            </td>
        </tr>
        <tr class="ratings">
         	<td>
            	Comments about theme of #conferenceNameShort#
            </td>
            <td>
            	<textarea name="THEMECOMMENTS" class="comments"></textarea>
            </td>
        </tr>
        <tr class="ratings">
         	<td>
            	Conference Location (#location#)
            </td>
            <td>
            	<select name="LOCATION">
                    #optionslist()#>
                </select>
            </td>
        </tr>
        <tr class="ratings">
         	<td>
            	Comments about the location
            </td>
            <td>
            	<textarea name="LOCATIONCOMMENTS" class="comments"></textarea>
            </td>
        </tr>
        <tr class="ratings">
         	<td>
            	Conference Speakers
            </td>
            <td>
            	<select name="SPEAKERS" id="SPEAKERS">
                    #optionslist()#>
                </select>
            </td>
        </tr>
        <tr class="ratings">
         	<td>
            	Comments about our Speakers
            </td>
            <td>
            	<textarea name="SPEAKERSCOMMENTS" class="comments"></textarea>
            </td>
        </tr>
        <tr class="ratings">
         	<td>
            	Worship Music
            </td>
            <td>
            	<select name="MUSIC" id="MUSIC" type="text">
                    #optionslist()#>
                </select>
            </td>
        </tr>
        <tr class="ratings">
         	<td>
            	Comments about worship music
            </td><td><textarea name="MUSICCOMMENTS" class="comments"></textarea></td> </tr>
        <tr class="ratings">
            <td>Overall conference schedule</td>
            <td>
                <select name="SCHEDULE" id="SCHEDULE">
                    #optionslist()#
                </select>
            </td>
        </tr>
        <tr class="ratings">
            <td>Comments about the Schedule</td>
            <td>
                <textarea name="SCHEDULECOMMENTS" class="comments"></textarea>
            </td>
        </tr>
        <tr class="ratings">
            <td>Sponsored Meals</td>
            <td>
                <select name="LUNCHEONS" id="LUNCHEONS">
                    #optionslist()#>
                </select>
            </td>
        </tr>
        <tr class="ratings">
            <td>Comments about sponsored meals</td>
            <td>
                <textarea name="LUNCHEONSCOMMENTS" class="comments"></textarea>
            </td>
        </tr>
        <tr class="ratings">
            <td>Grace Kids (infant, toddler and preschool)</td>
            <td>
                <select name="CHILDCARE">
                    #optionslist()#
                </select>
            </td>
        </tr>
        <tr class="ratings">
            <td>Comments about Grace Kids - Infant, Toddle, Pre-school</td>
            <td>
                <textarea name="CHILDCARECOMMENTS" class="comments"></textarea>
            </td>
            </tr>
        <tr class="ratings">
            <td>Grace Kids (elementary)</td>
            <td><select name="KIDSKONF">#optionslist()#</select></td>
        </tr>
        <tr class="ratings">
            <td>Comments about Grace Kids - Elementary</td>
            <td><textarea name="KIDSKONFCOMMENTS" class="comments"></textarea></td>
        </tr>

        <tr class="effect">
         <td>Where there principles or ideas from #conferenceNameShort# that you will be able to apply to your local church ministry?</td><td><select name="APPLY" id="apply">
            #optionslist("Yes,No")#</select></td> </tr>
        <tr class="effect">
         <td>Please describe how you were able to apply these #conferenceNameShort# principles and concepts to your local church?</td><td><textarea name="APPLYCOMMENTS" id="APPLYCOMMENTS"></textarea></td> </tr>
        <tr class="effect">
        <!---
         <td>What will you or your church do about planting new churches in this decade?</td><td><textarea name="churchplanting" id="churchplanting"></textarea></td> </tr>
        <tr class="effect">
         <td>What will you or your church do about leadership development in this decade?</td><td><textarea name="leadership" id="leadership"></textarea></td> </tr>
        <tr class="effect">
         <td>What will you or your church do about integrated ministry (loving people, meeting needs) in this decade?</td><td><textarea name="integrated" id="integrated"></textarea></td> </tr>
         --->

        <tr class="other">
         <td colspan="2"><p>Access2017 will be different! We will create more time in the schedule for you to gather with other leaders who know what you need and need what you know. Call them cohorts, or round-tables, or interest groups but we will provide ample time for you to talk about what you are learning in ministry.</p><ul><li>What are your ministry needs?</li><li>What help can you offer to others?</li><li>Who would you like to hangout with?</li></ul><p> Help us form the groupings that will be the core of access2017!</p></td>
         </tr>
         <tr>
         <td colspan="2"><textarea name="SUGGESTIONS" id="xsuggestions" style="width:100%"></textarea></td> </tr>

         <td colspan="2" align="center">
            #submitTag("Submit")#
         </td> </tr>
     </table>
#endFormTag()#
</cfoutput>
</div>
