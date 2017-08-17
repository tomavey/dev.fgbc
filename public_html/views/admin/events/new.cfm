<div class="row-fluid well contentStart contentBg">

<div class="span12"><h1>Create a new FGBC Event</h1>

<cfoutput>

			#errorMessagesFor("event")#
	
			#startFormTag(action="create")#
		
			#includePartial("form")#				

			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
</div></div>
