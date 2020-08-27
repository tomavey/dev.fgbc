<h1>Create a new note:</h1>

<cfoutput>

			#errorMessagesFor("handbooknote")#
	
			#startFormTag(action="create")#
		
			#includePartial("form")#	

			#submitTag("Create Note")#
				
			#endFormTag()#
			
</cfoutput>
