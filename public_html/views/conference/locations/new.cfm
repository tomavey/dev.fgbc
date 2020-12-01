<h1>Create new location</h1>

<cfoutput>
	<div class="eachItemShown #params.action#">

			#errorMessagesFor("location")#
	
			#startFormTag(action="create")#
		
				#includePartial(partial="form")#

				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
	</div>
</cfoutput>
