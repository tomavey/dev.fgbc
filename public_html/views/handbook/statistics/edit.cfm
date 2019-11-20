<cfparam name="formaction" default="update">

<h1>Editing handbookstatistic</h1>

<cfoutput>

			#errorMessagesFor("handbookstatistic")#
	
			#startFormTag(action=formaction, key=params.key)#

			#putFormTag()#

			#hiddenTagForKeyy()#
		
			#includePartial("form")#	
					
			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
