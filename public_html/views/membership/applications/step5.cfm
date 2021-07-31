<cfoutput>
#editButton("step5header")#
<h1>#getQuestion('step5header')#</h1>

#includePartial('reload')#

<div class="progress">
    <div class="bar" style="width: 66%;">Page 4 of 6 completed</div>
</div>

#includePartial(partial="showFlash")#

#ckeditor()#...

			#errorMessagesFor("membershipapplication")#
	
			#startFormTag(action="update", key=session.membershipapplication.id)#
				
			#putFormTag()#		

			#includePartial(partial="form5")#			

			#hiddenFieldTag(name="nextstep", value="step6")#

			#editButton("submitstep5")#
			#submitTag(trim(stripTags(getQuestion("submitstep5"))))#
				
			#endFormTag()#
			
</cfoutput>
