<h1>Create a New Instructor</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>

			
			
			#errorMessagesFor("instructor")#
	
			#startFormTag(action="create")#
		
				
																
				
					
																
				#includePartial("form")#

				#submitTag()#
				
			#endFormTag()#
			
		

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
