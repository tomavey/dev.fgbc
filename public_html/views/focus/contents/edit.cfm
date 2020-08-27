<h1>Editing content</h1>

<cfoutput>

			#errorMessagesFor("content")#
	
			#startFormTag(action="update", key=params.key)#

			#putFormTag()#
			
			#includePartial("form")#
		
			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
