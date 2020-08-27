<cfoutput>

<div class="postbox" id=#params.controller#.#params.action#>

<h1>Create new content</h1>


			#errorMessagesFor("content")#
	
			#startFormTag(action="create")#
		
			#includePartial("form")#

				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#

</div>

</cfoutput>
