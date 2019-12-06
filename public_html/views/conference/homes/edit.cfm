<cfparam name="formaction" default="update">

<div class="container">

<h1>Editing home</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>

			
			#errorMessagesFor("home")#
	
			#startFormTag(action=formaction, key=params.key)#
		
			#putFormTag()#		

			#hiddenTagForKeyy()#
				
			#includePartial(formtype)#												
				
			#submitTag()#
				
			#endFormTag()#
			
		

#linkTo(text="Return to the listing", action="index")#
</cfoutput>

</div>
