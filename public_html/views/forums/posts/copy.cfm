<h1>Create a new post:</h1>

<cfoutput>

			#errorMessagesFor("forumpost")#
	
			#startFormTag(action="create")#
			
			<cfif isdefined("params.replyto")>
			#hiddenFieldTag(name="replyto", value=params.replyto)#
			</cfif>

			#includePartial(partial="form")#
		
			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
