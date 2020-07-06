<h1>Editing item</h1>

<cfoutput>

			#errorMessagesFor("item")#
	
			#startFormTag(action="update", key=params.key)#

			#putFormTag()#
		
			#includePartial("form")#				
				
			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
