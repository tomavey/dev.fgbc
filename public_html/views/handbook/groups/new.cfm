<h1>Create new handbookgroup</h1>

<cfoutput>

			#errorMessagesFor("handbookgroup")#
	
			#startFormTag(action="create")#
		
				
						#textField(objectName='handbookgroup', property='personId', label='Person Id')#
					
						#textField(objectName='handbookgroup', property='grouptypeId', label='Grouptype Id')#
					

				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
