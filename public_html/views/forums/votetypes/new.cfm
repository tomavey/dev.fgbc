<h1>Create new forumvotetype</h1>

<cfoutput>

			#errorMessagesFor("forumvotetype")#
	
			#startFormTag(action="create")#
		
				
						#textField(objectName='forumvotetype', property='vote', label='Vote')#
					
						#textField(objectName='forumvotetype', property='description', label='Description')#
					

				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
