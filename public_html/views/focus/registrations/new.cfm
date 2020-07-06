<h1>Create new registration</h1>

<cfoutput>

			#errorMessagesFor("registration")#
	
			#startFormTag(action="create")#
		
				
						#textField(objectName='registration', property='registrantId', label='Registrant Id')#
					
						#textField(objectName='registration', property='itemId', label='Item Id')#
					
						#textField(objectName='registration', property='invoiceId', label='Invoice Id')#
					
						#textField(objectName='registration', property='quantity', label='Quantity')#
					
						#textField(objectName='registration', property='cost', label='Cost')#
					
						#textField(objectName='registration', property='comment', label='Comment')#
					
						#textField(objectName='registration', property='retreat', label='Retreat')#
					
						#textField(objectName='registration', property='user', label='User')#
					
						#dateTimeSelect(objectName='registration', property='createAt', dateOrder='year,month,day', monthDisplay='abbreviations', label='Create At')#
					
						#dateTimeSelect(objectName='registration', property='deleteAt', dateOrder='year,month,day', monthDisplay='abbreviations', label='Delete At')#
					

				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
