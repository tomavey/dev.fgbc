<div class="container">
	<h1>Editing fgbc_metas</h1>

	<cfoutput>#includePartial("showFlash")#</cfoutput>

	<cfoutput>
				
				#errorMessagesFor("setting")#
		
				#startFormTag(action="update", key=params.key)#

				#putFormTag()#
			
				#includePartial("form")#
					
				#submitTag()#
					
				#endFormTag()#
				
			

	#linkTo(text="Return to the listing", action="index")#
	</cfoutput>
	<cfdump var="#params#">
</div>