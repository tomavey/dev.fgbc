<h1>Editing registrant</h1>

<cfoutput>

			#errorMessagesFor("registrant")#
	
			#startFormTag(action="update", key=params.key)#

			#putFormTag()#
		
				
						#textField(objectName='registrant', property='fname', label='Fname')#
					
						#textField(objectName='registrant', property='lname', label='Lname')#
					
						#textField(objectName='registrant', property='email', label='Email')#
					
						#textField(objectName='registrant', property='phone', label='Phone')#
					
						#textField(objectName='registrant', property='roommate', label='Roommate')#
					
						#textField(objectName='registrant', property='comment', label='Comment')#
					
				
				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
