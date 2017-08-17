<cfoutput>

<div class="row-fluid well contentStart contentBg">

<div class="span12">

<h1>Create new menu</h1>


			#errorMessagesFor("menu")#
	
			#startFormTag(action="create")#
		
			#includePartial("form")#	

			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</div>
</div>
</cfoutput>
