<h1>Editing content</h1>

<cfoutput>

			#errorMessagesFor("content")#
	
			#startFormTag(action="update", key=params.key)#

			#putFormTag()#		
				
						#textField(objectName='content', property='name', label='Name')#
					
						#textArea(objectName='content', property='content', label='Content')#
					
						#textField(objectName='content', property='thread_of_id', label='Thread_of_id')#
					
				
				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
