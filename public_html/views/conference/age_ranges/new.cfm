<h1>Create new age_range</h1>

<cfoutput>

			#errorMessagesFor("age_range")#
	
			#startFormTag(action="create")#
		
				
						#textField(objectName='age_range', property='name', label='Name')#
					
						#textField(objectName='age_range', property='type', label='Type')#

						#textField(objectName='age_range', property='description', label='Description')#
					

				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
