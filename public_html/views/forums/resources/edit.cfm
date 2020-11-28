<h1>Editing forumresource</h1>

<cfoutput>

			#errorMessagesFor("forumresource")#
	
			#startFormTag(action="update", key=params.key)#
		
			#includePartial(partial="form")#
				
			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
