<h1>Editing forumforum</h1>

<cfoutput>

			#errorMessagesFor("forumforum")#
	
			#startFormTag(action="update", key=params.key)#
			
			#includePartial('form')#
		
			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
