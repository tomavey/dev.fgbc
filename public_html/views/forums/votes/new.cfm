<h1>Create new forumvote</h1>

<cfoutput>

			#errorMessagesFor("forumvote")#
	
			#startFormTag(action="create")#
		
				
						#textField(objectName='forumvote', property='postId', label='Post Id')#
					
						#textField(objectName='forumvote', property='votetypeId', label='Votetype Id')#
					
						#textField(objectName='forumvote', property='createdBy', label='Created By')#
					

				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
