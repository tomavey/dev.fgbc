<h1>Editing resource</h1>

<cfoutput>#includePartial(partial="showFlash")#</cfoutput>

<cfoutput>

			
			#errorMessagesFor("resource")#
	
			#startFormTag(action="update", key=params.key)#
		
				
															
				
					
						#textField(objectName='resource', property='url', label='Url')#
															
				
					
						#textField(objectName='resource', property='comment', label='Comment')#
															
				
					
						#textField(objectName='resource', property='author', label='Author')#
															
				
															
				
					
						#dateTimeSelect(objectName='resource', property='updateAt', dateOrder='year,month,day', monthDisplay='abbreviations', label='Update At')#
															
				
					
						#dateTimeSelect(objectName='resource', property='approvedAt', dateOrder='year,month,day', monthDisplay='abbreviations', label='Approved At')#
															
				
															
				
				
				#submitTag()#
				
			#endFormTag()#
			
		

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
