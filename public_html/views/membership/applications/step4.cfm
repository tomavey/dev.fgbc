<cfoutput>
#editButton("step4header")#
<h1>#getQuestion('step4header')#</h1>

#includePartial('reload')#

<div class="progress">
    <div class="bar" style="width: 50%;">Page 3 of 6 completed</div>
</div>

#includePartial("showFlash")#

			#errorMessagesFor("membershipapplication")#
	
			#startFormTag(action="update", key=session.membershipapplication.id)#
				
			#putFormTag()#		

			#includePartial("form4")#															
				#hiddenFieldTag(name="nextstep", value="step5")#

			#editButton("submitstep4")#
			#submitTag(trim(stripTags(getQuestion("submitstep4"))))#
				
			#endFormTag()#
			
</cfoutput>
