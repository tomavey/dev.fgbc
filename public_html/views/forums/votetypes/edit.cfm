<h1>Editing forumvotetype</h1>

<cfoutput>

			#errorMessagesFor("forumvotetype")#
	
			#startFormTag(action="update", key=params.key)#
		
				
						#textField(objectName='forumvotetype', property='vote', label='Vote')#
					
						#textField(objectName='forumvotetype', property='description', label='Description')#
					
				
				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
