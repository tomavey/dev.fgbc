<h1>Create new handbooksubscribe</h1>

<cfoutput>

			#errorMessagesFor("handbooksubscribe")#
	
			#startFormTag(action="create")#
		
				
						#textField(objectName='handbooksubscribe', property='email', label='Email')#
					
						#textField(objectName='handbooksubscribe', property='type', label='Type')#
					

				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
