<h1>Editing location</h1>

<cfoutput>
	<div class="eachItemShown #params.action#">

			#errorMessagesFor("location")#
	
			#startFormTag(action="update", key=params.key)#
		
			#putFormTag()#		

				#includePartial("form")#
				
				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
	</div>
</cfoutput>
