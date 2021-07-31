<cfoutput>
<div class="container">

<h1>Editing #event.event#</h1>


			#errorMessagesFor("event")#
	
			#startFormTag(action="update", key=params.key)#
		
			#putFormTag()#		

			#includePartial(partial="form")#				
				
			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</div>
</cfoutput>
