<cfoutput>				
	#select(objectName='registration', property='registrantId', label='Registrant: ', options=registrants, textField="fullnameLastFirstId")#
					
	#select(objectName='registration', property='itemId', label='Item: ', options=items, textfield="name")#
					
	#select(objectName='registration', property='invoiceId', label='Invoice: ', options=invoices, textfield="orderid")#
					
	#textField(objectName='registration', property='quantity', label='Quantity: ')#
					
	#textField(objectName='registration', property='cost', label='Cost: ')#
					
	#textArea(objectName='registration', property='comment', label='Comment')#
					
	#textField(objectName='registration', property='agent', label='Agent: ')#
					
</cfoutput>