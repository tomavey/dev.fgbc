<h1>Editing Coursequestion</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>

			
			#errorMessagesFor("Coursequestion")#
	
			#startFormTag(action="update", key=params.key)#
		
				
															
			#includePartial("form")#				
				
			#submitTag()#
				
			#endFormTag()#
			
		

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
