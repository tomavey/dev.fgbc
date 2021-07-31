<h1>Editing membershipappresource</h1>

<cfoutput>#includePartial(partial="showFlash")#</cfoutput>

<cfoutput>

			
			#errorMessagesFor("membershipappresource")#
	
			#startFormTag(action="update", key=params.key)#
		
				
															
				
					
						#textField(objectName='membershipappresource', property='applicationID', label='Application ID')#
															
				
					
						#textField(objectName='membershipappresource', property='applicationUUID', label='Application UUID')#
															
				
					
						#textField(objectName='membershipappresource', property='description', label='Description')#
															
				
					
						#textField(objectName='membershipappresource', property='file', label='File')#
															
				
															
				
															
				
															
				
				
				#submitTag()#
				
			#endFormTag()#
			
		

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
