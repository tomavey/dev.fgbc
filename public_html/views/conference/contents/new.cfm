<h1>Create new content</h1>

<cfoutput>

			#errorMessagesFor("content")#
	
			#startFormTag(action="create")#
		
				
						#textField(objectName='content', property='name', label='Name')#
					
						#textArea(objectName='content', property='content', label='Content')#
					

				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
