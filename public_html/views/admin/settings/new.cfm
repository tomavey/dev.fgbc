<div class="container">
<h1>Create a New Setting</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>

			
			
			#errorMessagesFor("setting")#
	
			#startFormTag(action="create")#

			#includePartial("form")#
				
			#submitTag()#
				
			#endFormTag()#
			
		

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
</div>