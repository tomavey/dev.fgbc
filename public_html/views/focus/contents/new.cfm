<h1>Create new content</h1>

<cfoutput>

			#errorMessagesFor("content")#
	
			#startFormTag(action="create")#
			
			#includePartial(partial="form")#
		
			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
