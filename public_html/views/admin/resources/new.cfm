<div class="postbox" id=#params.controller##params.action#>

<h1>Create new resource</h1>

<cfoutput>

			#errorMessagesFor("resource")#
	
			#startFormTag(action="create", multipart="true")#
		
			#includePartial("form")#

			#submitTag("Submit Resource")#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="list")#
</cfoutput>
</div>