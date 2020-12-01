<h1>Create a new membership app question:</h1>

<cfoutput>#includePartial(partial="showFlash")#</cfoutput>

<cfoutput>

			
			
			#errorMessagesFor("membershipappquestion")#
	
			#startFormTag(action="create")#
		
			#includePartial(partial="form")#																
			#submitTag()#
				
			#endFormTag()#
			
#linkTo(text="Return to the listing", action="index")#
</cfoutput>
