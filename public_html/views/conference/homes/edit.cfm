<h1>Editing home</h1>

<cfoutput>

			#errorMessagesFor("home")#
	
			#startFormTag(action="update", key=params.key)#
		
			#putFormTag()#		

				#includePartial("form")#
				
				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
