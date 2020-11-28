<cfoutput>

<div class="row-fluid well contentStart contentBg container">

<div class="span12">
<h1>Editing menu</h1>


			#errorMessagesFor("menu")#
	
			#startFormTag(action="update", key=params.key)#

			#putFormTag()#		

			#includePartial(partial="form")#		
				
			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</div>

</div>

</cfoutput>
