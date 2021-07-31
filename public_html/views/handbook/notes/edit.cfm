<h1>Editing handbooknote</h1>

<cfoutput>

			#errorMessagesFor("handbooknote")#
	
			#startFormTag(action="update", key=params.key)#
			
			#includePartial(partial="form")#
		
			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
