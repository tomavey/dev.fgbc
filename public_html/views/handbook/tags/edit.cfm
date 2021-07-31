<h1>Editing handbooktag</h1>

<cfoutput>

			#errorMessagesFor("handbooktag")#
	
			#startFormTag(action="update", key=params.key)#
		
				
						#textField(objectName='handbooktag', property='tag', label='Tag')#
					
						#textField(objectName='handbooktag', property='itemId', label='Item Id')#
					
						#textField(objectName='handbooktag', property='username', label='Username')#
					
						#textField(objectName='handbooktag', property='type', label='Type')#
					
						#textField(objectName='handbooktag', property='access', label='Access')#
					
						#textField(objectName='handbooktag', property='comment', label='Comment')#
					
				
				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
