<h1>Editing Instructor</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>

			
			#errorMessagesFor("instructor")#
	
			#startFormTag(action="update", key=params.key)#
		
			#putFormTag()#

			#includePartial("form")#															
				
				
				#submitTag()#
				
			#endFormTag()#
			
		

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
