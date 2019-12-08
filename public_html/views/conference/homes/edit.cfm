<cfparam name="formaction" default="update">
<cfoutput>

#styleSheetLinkTag("conference/conferencehomes")#

<div class="container">

<h1>Editing home</h1>

#includePartial("includes/showFlash")#

			
			#errorMessagesFor("home")#
	
			#startFormTag(action=formaction, key=params.key)#
		
			#putFormTag()#		

			#hiddenTagForKeyy()#
				
			#includePartial("includes/#formtype#")#												
				
			#submitTag()#
				
			#endFormTag()#
			
		

#linkTo(text="Return to the listing", action="index")#

</div>

</cfoutput>
