<div class="eachItemShown">
<h1>Create new equip invoice</h1>

<cfoutput>

			#errorMessagesFor("invoice")#
	
			#startFormTag(action="create")#
		
						#textField(objectName='invoice', property='ccOrderId', label='Order Id')#
					
						#textField(objectName='invoice', property='ccAmount', label='Amount')#
					
						#textField(objectName='invoice', property='ccStatus', label='Status')#
					
						#textField(objectName='invoice', property='ccName', label='Name')#
					
						#textField(objectName='invoice', property='ccEmail', label='Email')#
					
						#textField(objectName='invoice', property='agent', label='Agent')#
					

				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
</div>