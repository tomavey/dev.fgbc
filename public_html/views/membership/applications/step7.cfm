<h1>FGBC Membership Application - Step 7</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>

			
			#errorMessagesFor("membershipapplication")#
	
			#startFormTag(action="update", key=session.membershipapplication.id)#
				
			#putFormTag()#		

			#includePartial("form7")#															
			#hiddenFieldTag(name="nextstep", value="thankyou")#

			#submitTag()#
				
			#endFormTag()#
			
</cfoutput>
