<cfoutput>
#editButton("step2header")#
<h1>#getQuestion("step2header")#</h1>

#includePartial(partial="reload")#

<div class="progress">
    <div class="bar" style="width: 16%;">Page 1 of 6 completed</div>
</div>

#includePartial(partial="showFlash")#

#ckeditor()#


			
			#errorMessagesFor("membershipapplication")#
	
			#startFormTag(action="update", key=session.membershipapplication.id)#

			#putFormTag()#		
				
			#includePartial(partial="form2")#	
																	
			#hiddenFieldTag(name="nextstep", value="step3")#

			#editButton("submitstep2")#
			#submitTag(trim(stripTags(getQuestion("submitstep2"))))#
				
			#endFormTag()#
			
</cfoutput>
