<h1>Add to this registration:</h1>
<cfoutput>
<p>Registrant: #registrant.fname# #registrant.lname#</p>
<p>Invoice: #invoice.orderid#</p>
</cfoutput>
<cfoutput>

			#startFormTag(action="add", key=params.key)#
		
			#hiddenField(objectName='registration', property='registrantId')#
			
			#hiddenField(objectName='registration', property='invoiceId')#

			#select(objectName='registration', property='itemId', options=items, label="Item: ")#

			#submitTag()#
				
			#endFormTag()#
			
</cfoutput>