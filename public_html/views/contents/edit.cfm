<div class="container" id=#params.controller#.#params.action#>
<h1>Editing content</h1>

<cfoutput>

			#errorMessagesFor("content")#
	
			#startFormTag(action="update", key=params.key)#
		
			#includePartial("form")#

			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
</div>
