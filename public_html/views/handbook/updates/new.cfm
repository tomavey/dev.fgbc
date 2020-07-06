<h1>Create new handbookupdate</h1>

<cfoutput>

			#errorMessagesFor("handbookupdate")#
	
			#startFormTag(action="create")#
		
				
						#hiddentextField(objectName='handbookupdate', property='modelName', label='Model Name')#
					
						#hiddentextField(objectName='handbookupdate', property='recordId', label='Record Id')#
					
						#hiddentextField(objectName='handbookupdate', property='columnName', label='Column Name')#
					
						#hiddentextField(objectName='handbookupdate', property='datatype', label='Datatype')#
					
						#hiddentextField(objectName='handbookupdate', property='oldData', label='Old Data')#
					
						#textField(objectName='handbookupdate', property='newData', label='New Data')#
					
						#hiddentextField(objectName='handbookupdate', property='createdBy', label='Created By')#
					
						#textField(objectName='handbookupdate', property='comment', label='Comment')#
					

				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
