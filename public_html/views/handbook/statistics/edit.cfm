<h1>Editing handbookstatistic</h1>

<cfoutput>

			#errorMessagesFor("handbookstatistic")#
	
			#startFormTag(action="update", key=params.key)#

			#putFormTag()#
		
			#includePartial("form")#	
					
			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
