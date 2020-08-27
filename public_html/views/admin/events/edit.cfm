<cfoutput>
<div class="container">

<h1>Editing Event</h1>


			#errorMessagesFor("event")#
	
			#startFormTag(action="update", key=params.key)#
		
			#putFormTag()#		

			#includePartial("form")#				
				
			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</div>
</cfoutput>
