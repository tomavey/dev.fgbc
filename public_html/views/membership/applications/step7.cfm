<h1>FGBC Membership Application - Step 7</h1>

<cfoutput>#includePartial(partial="showFlash")#</cfoutput>

<cfoutput>

			
			#errorMessagesFor("membershipapplication")#
	
			#startFormTag(action="update", key=session.membershipapplication.id)#
				
			#putFormTag()#		

			#includePartial(partial="form7")#															
			#hiddenFieldTag(name="nextstep", value="thankyou")#

			#submitTag()#
				
			#endFormTag()#
			
</cfoutput>
