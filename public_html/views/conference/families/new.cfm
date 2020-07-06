<div class="eachItemShown">

<cfoutput>

			#errorMessagesFor("family")#
	
			#startFormTag(action="create")#
		
				
						#textField(objectName='family', property='lname', label='Last Name')#
					
						#textField(objectName='family', property='address', label='Address')#
					
						#textField(objectName='family', property='city', label='City')#
					
						#select(objectName='family', property='handbook_statesid', label='State', options=states, valueField="id")#
						
						#textField(objectName='family', property='zip', label='Zip')#
					
						#textField(objectName='family', property='email', label='Email')#
					
						#textField(objectName='family', property='phone', label='Phone')#
					
						#textArea(objectName='family', property='comment', label='Comment')#
					
				
				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
</div>
