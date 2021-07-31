<cfoutput>

			#errorMessagesFor("fgbcdelegate")#
	
			#startFormTag(action="update", key=params.key)#

				#putFormTag()#
		
				
						#hiddenField(objectName='fgbcdelegate', property='churchId')#
					
						#textField(objectName='fgbcdelegate', property='name', label='Name')#
					
						#textField(objectName='fgbcdelegate', property='email', label='Email')#
					
						#hiddenField(objectName='fgbcdelegate', property='Submitter', label='Submitter')#
					
						#hiddenField(objectName='fgbcdelegate', property="Submitter's email", label='Submitteremail')#
					
				#submitTag()#
				
			#endFormTag()#
			
</cfoutput>
