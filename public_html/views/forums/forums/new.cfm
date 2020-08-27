<h1>Create new forumforum</h1>

<cfoutput>

			#errorMessagesFor("forumforum")#
	
			#startFormTag(action="create")#
			
			#includePartial('form')#
		
			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
