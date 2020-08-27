<h1>Editing handbookupdate</h1>

<cfoutput>

			#errorMessagesFor("handbookupdate")#
	
			#startFormTag(action="update", key=params.key)#
		
				
						#textField(objectName='handbookupdate', property='tableName', label='Table Name')#
					
						#textField(objectName='handbookupdate', property='recordId', label='Record Id')#
					
						#textField(objectName='handbookupdate', property='columnName', label='Column Name')#
					
						#textField(objectName='handbookupdate', property='datatype', label='Datatype')#
					
						#textField(objectName='handbookupdate', property='oldData', label='Old Data')#
					
						#textField(objectName='handbookupdate', property='newData', label='New Data')#
					
						#textField(objectName='handbookupdate', property='createdBy', label='Created By')#
					
						#textField(objectName='handbookupdate', property='comment', label='Comment')#
					
				
				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
