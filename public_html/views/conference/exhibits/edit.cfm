<h1>Editing exhibit</h1>

<cfoutput>

			#errorMessagesFor("exhibit")#
	
			#startFormTag(action="update", key=params.key)#

			#putFormTag()#
		
				#includePartial(partial="form")#
			
				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
