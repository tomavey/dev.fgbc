<div class="postbox" id=#params.controller##params.action#>

<h1>Editing resource</h1>

<cfoutput>

			#errorMessagesFor("resource")#
	
			#startFormTag(action="update", key=params.key)#

			#putFormTag()#		

			#includePartial("form")#
				
			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
</div>