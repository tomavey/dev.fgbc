<div class="eachItemShown">

<cfoutput>

			#errorMessagesFor("family")#
	
			#startFormTag(action="update", key=params.key)#
		
			#putFormTag()#		

				
						#textField(objectName='family', property='lname', label='Last Name')#
					
						#textField(objectName='family', property='address', label='Address')#
					
						#textField(objectName='family', property='city', label='City')#
					
						#select(objectName='family', property='handbook_statesid', label='State', options=handbook_states)#
						
						#textField(objectName='family', property='zip', label='Zip')#
					
						#textField(objectName='family', property='email', label='Email')#
					
						#textField(objectName='family', property='phone', label='Phone')#
					
						#textField(objectName='family', property='age', label='Age: ')#

						#textField(objectName='family', property='type', label='Type: ')#

						#textArea(objectName='family', property='comment', label='Comment')#
					
				
				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
</div>