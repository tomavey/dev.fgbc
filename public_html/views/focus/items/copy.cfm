<h1>Copying item</h1>

<cfoutput>

			#errorMessagesFor("item")#
	
			#startFormTag(action="create", key=params.key)#
		
			#includePartial(partial="form")#				
				
			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
