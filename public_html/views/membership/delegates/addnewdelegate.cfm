<cfoutput>

			#errorMessagesFor("fgbcdelegate")#
	
			#startFormTag(action="createOne", key=params.key)#
		
				
						#hiddenField(objectName='fgbcdelegate', property='churchId')#
					
						#hiddenField(objectName='fgbcdelegate', property='year')#

						#hiddenField(objectName='fgbcdelegate', property='status')#

						#textField(objectName='fgbcdelegate', property='name', label='Name')#
					
						#textField(objectName='fgbcdelegate', property='email', label='Email')#
					
						#hiddenField(objectName='fgbcdelegate', property="submitter", label="Submitter's Name")#
					
						#hiddenField(objectName='fgbcdelegate', property="submitteremail", label="Submitter's email")#
					
				#submitTag()#
				
			#endFormTag()#
			
</cfoutput>
