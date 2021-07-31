<h1>Create a new note:</h1>

<cfoutput>

			#errorMessagesFor("handbooknote")#
	
			#startFormTag(action="create")#
		
			#includePartial(partial="form")#	

			#submitTag("Create Note")#
				
			#endFormTag()#
			
</cfoutput>
