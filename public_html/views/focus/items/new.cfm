<h1>Create new item</h1>

<cfoutput>

			#errorMessagesFor("item")#
	
			#startFormTag(action="create")#
		
			#includePartial("form")#				

			#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
