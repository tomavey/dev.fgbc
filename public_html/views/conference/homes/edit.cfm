<cfparam name="formaction" default="update">
<cfoutput>

#styleSheetLinkTag("conference/conferencehomes")#

<div class="container" style="background-color:white;padding:20px;border-radius:10px">

	#includePartial(partial="includes/navbar")#

<h1>Editing home</h1>

#includePartial(partial="includes/showFlash")#

			
			#errorMessagesFor("home")#
	
			#startFormTag(action=formaction, key=params.key)#
		
			#putFormTag()#		

			#hiddenTagForKeyy()#
				
			#includePartial(partial="includes/#formtype#")#												
				
			#submitTag()#
				
			#endFormTag()#
			
		

#linkTo(text="Return to the listing", action="index")#

</div>

</cfoutput>
