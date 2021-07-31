<div class="container span10">
	<cfoutput>
		
		<h1>Editing #setting.name#</h1>

	#includePartial(partial="showFlash")#</cfoutput>

	<cfoutput>
				
				#errorMessagesFor("setting")#
		
				#startFormTag(action="update")#

				#putFormTag()#

				#hiddenTagForKeyy()#
		
				#includePartial(partial="form")#
					
				#submitTag()#
					
				#endFormTag()#
				
			

	#linkTo(text="Return to the listing", action="index")#
	</cfoutput>
	<cfdump var="#params#">
</div>