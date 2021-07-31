<h1>Create a New resource</h1>

<cfoutput>#includePartial(partial="showFlash")#</cfoutput>

<cfoutput>

			
			
			#errorMessagesFor("resource")#
	
			#startFormTag(action="create")#
		
				
																
				
					
						#textField(objectName='resource', property='url', label='Url')#
																
				
					
						#textField(objectName='resource', property='comment', label='Comment')#
																
				
					
						#textField(objectName='resource', property='author', label='Author')#
																
				

				#submitTag()#
				
			#endFormTag()#
			
		

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
