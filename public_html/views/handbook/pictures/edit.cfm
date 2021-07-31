<h1>Editing handbookpicture</h1>

<cfoutput>

			#errorMessagesFor("handbookpicture")#
	
			#startFormTag(action="update", key=params.key)#

			#putFormTag()#
				
						#textField(objectName='handbookpicture', property='personid', label='Personid')#
					
						#textField(objectName='handbookpicture', property='description', label='Description')#
					
						#textField(objectName='handbookpicture', property='file', label='File')#

						#textField(objectName='handbookpicture', property='createdBy', label='Created By')#
					
				
				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
