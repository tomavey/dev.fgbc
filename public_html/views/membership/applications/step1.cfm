<cfoutput>
#editButton("step1header")#
<h1>#getQuestion("step1header")#</h1>

#includePartial("reload")#

<div class="progress">
    <div class="bar" style="width: 0%;">progress...</div>
</div>

#includePartial("showFlash")#

</cfoutput>

<cfoutput>

			
			#errorMessagesFor("membershipapplication")#
	
			#startFormTag(action="update", key=session.membershipapplication.id)#

			#putFormTag()#		
				
			#includePartial("form1")#									
									
			#hiddenFieldTag(name="nextstep", value="step2")#

			#editButton("submitstep1")#
			#submitTag(trim(stripTags(getQuestion("submitstep1"))))#
				
			#endFormTag()#
			
</cfoutput>
