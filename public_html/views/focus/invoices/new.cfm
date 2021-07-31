<h1>Create new invoice</h1>

<cfoutput>

			#errorMessagesFor("invoice")#
	
			#startFormTag(action="create")#
			
			#includePartial(partial="form")#
		
			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
