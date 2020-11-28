<h1><h1>Edit your comment:</h1></h1>

<cfoutput>

			#errorMessagesFor("forumpost")#
	
			#startFormTag(action="update", key=params.key)#
		
			#includePartial(partial="form")#				

			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
