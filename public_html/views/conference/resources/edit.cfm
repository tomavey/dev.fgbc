<div class="new">
<h1>Editing resource</h1>

<cfoutput>

			#errorMessagesFor("resource")#
	
			#startFormTag(action="update", key=params.key)#
		
			#putFormTag()#		

						#textField(objectName='resource', property='email', label='Email')#
					
						#textField(objectName='resource', property='name', label='Name')#
					
						#textField(objectName='resource', property='address', label='Address')#
					
						#textField(objectName='resource', property='item', label='Item')#
					
						#checkBox(objectName='resource', property='approvedAt', checkedValue=now(), label='Approved:', class="datepicker")#
					
						#textField(objectName='resource', property='sendAt', label='Sent on (date):', class="datepicker")#
					
						#textField(objectName='resource', property='comment', label='Comment')#
					
				
				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
</div>