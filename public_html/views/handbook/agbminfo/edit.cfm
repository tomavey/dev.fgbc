<h1>Editing payment information:</h1>

<cfoutput>

			#errorMessagesFor("handbookagbminfo")#
	
			#startFormTag(action="update", key=params.key)#

			#putFormTag()#
		
			#includePartial("form")#	
				
			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", controller="Handbook-agbm", action="index")#
</cfoutput>
