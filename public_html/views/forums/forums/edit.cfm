<cfoutput>
<cfif isDefined("forumForum.forum")>
<h1>Editing #forumForum.forum#</h1>
<cfelse>
<h1>Editing this Forum</h1>
</cfif>

			#errorMessagesFor("forumforum")#
	
			#startFormTag(action="update", key=params.key)#
			
			#includePartial('form')#
		
			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
