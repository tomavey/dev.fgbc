<h1>Editing invoice</h1>

<cfoutput>

			#errorMessagesFor("invoice")#
	
			#startFormTag(action="update", key=params.key)#

			#putFormTag()#
		
			#includePartial(partial="form")#

			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
