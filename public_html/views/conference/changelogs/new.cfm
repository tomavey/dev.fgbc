<h1>Create new changelog</h1>

<cfoutput>

			#errorMessagesFor("changelog")#
	
			#startFormTag(action="create")#
		
				
						#textField(objectName='changelog', property='table', label='Table')#
					
						#textField(objectName='changelog', property='column', label='Column')#
					
						#textField(objectName='changelog', property='olddata', label='Olddata')#
					
						#textField(objectName='changelog', property='user', label='User')#
					

				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
