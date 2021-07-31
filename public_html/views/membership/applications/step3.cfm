<cfoutput>
#editButton("step3header")#
<h1>#getQuestion('step3header')#</h1>

#includePartial('reload')#

<div class="progress">
    <div class="bar" style="width: 30%;">Page 2 of 6 completed</div>
</div>

#includePartial(partial="showFlash")#


			
			#errorMessagesFor("membershipapplication")#
	
			#startFormTag(action="update", key=session.membershipapplication.id)#
				
			#putFormTag()#		

			#includePartial(partial="form3")#			

			#hiddenFieldTag(name="nextstep", value="step4")#

			#editButton("submitstep3")#
			#submitTag(trim(stripTags(getQuestion("submitstep3"))))#
				
			#endFormTag()#
			
</cfoutput>
