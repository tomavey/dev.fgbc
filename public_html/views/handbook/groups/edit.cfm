<h1>Editing handbookgroup</h1>

<cfoutput>

			#errorMessagesFor("handbookgroup")#
	
			#startFormTag(action="update", key=params.key)#
		
				
						#textField(objectName='handbookgroup', property='personId', label='Person Id')#
					
						#textField(objectName='handbookgroup', property='grouptypeId', label='Grouptype Id')#
					
				
				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
