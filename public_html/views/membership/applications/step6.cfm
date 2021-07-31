<cfoutput>
#editButton("step6header")#
<h1>#getQuestion("step6header")#</h1>

#includePartial(partial="reload")#

<div class="progress">
    <div class="bar" style="width: 83%;">Page 5 of 6 completed</div>
</div>

#includePartial(partial="showFlash")#

			
			#errorMessagesFor("membershipapplication")#
	
			#startFormTag(action="update", key=session.membershipapplication.id)#
				
			#putFormTag()#		

			#includePartial(partial="form6")#

			<cfif isFellowshipCouncil()>
				#hiddenFieldTag(name="nextstep", value="step7")#
			<cfelse>
				#hiddenFieldTag(name="nextstep", value="thankyou")#
			</cfif>

			#editButton("save")#
			#submitTag(trim(striptags(getQuestion("save"))))#
				
			#endFormTag()#

<div class="well">
#getQuestion("returnLink")#
#linkto(controller="membership.applications", action="checkin", key=session.membershipapplication.uuid, onlyPath=false)#
</div>			

</cfoutput>
