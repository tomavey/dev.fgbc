<h1>Upload a file:</h1>

<cfoutput>

			#errorMessagesFor("forumresource")#

			#startFormTag(action="create", multipart="true")#
			
			#includePartial("form")#

			#submitTag("Upload")#
				
			#endFormTag()#
			
<cftry>
	#linkTo(text="Return", action=session.return.action, controller=session.return.controller)#
<cfcatch>
	#linkTo(text="Return to the listing", action="index")#
</cfcatch>
</cftry>
</cfoutput>
