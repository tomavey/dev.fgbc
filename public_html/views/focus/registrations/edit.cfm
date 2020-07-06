<h1>Editing registration</h1>

<cfoutput>

			#errorMessagesFor("registration")#
	
			#startFormTag(action="update", key=params.key)#

			#putFormTag()#
		
			#includePartial("form")#

			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
