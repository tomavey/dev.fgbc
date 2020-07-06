<div class="container" id=#params.controller#.#params.action#>
<h1>Editing content.</h1>

<cfoutput>

	<cftry>
			#errorMessagesFor("contents")#
	<cfcatch></cfcatch>
	</cftry>		
	
			#startFormTag(action="update", key=params.key)#
		
			#includePartial("form")#

			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
</div>
