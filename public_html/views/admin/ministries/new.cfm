<div class="postbox" id=#params.controller#.#params.action#>
<h1>Create a new ministry</h1>

<cfoutput>

			#errorMessagesFor("ministry")#
	
			#startFormTag(action="create")#

			#includePartial("form")#
		
			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
</div>