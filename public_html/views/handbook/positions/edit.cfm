<h1>Editing handbookposition</h1>

<cfoutput>

			#errorMessagesFor("handbookposition")#
	
			#startFormTag(action="update", key=params.key)#
		
				
						#textField(objectName='handbookposition', property='position', label='Position')#
					
						#textField(objectName='handbookposition', property='position2', label='Position2')#
					
						#textField(objectName='handbookposition', property='positiontypeid', label='Positiontypeid')#
					
				
				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
