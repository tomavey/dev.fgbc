<h1>Copy a membership application question</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>

			
			#errorMessagesFor("membershipappquestion")#
	
			#startFormTag(action="create", key=params.key)#
		
			#includePartial("form")#				
				
			#submitTag()#
				
			#endFormTag()#
			
		

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
