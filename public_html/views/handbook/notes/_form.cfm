<cfoutput>
#ckeditor()#
	#hiddenField(objectName='handbooknote', property='createdBy')#
	
	<cfif showSelect>
		#select(objectName='handbooknote', property='personId', label='Person: ', options=people, textfield="selectname")#
					
		#select(objectName='handbooknote', property='organizationId', label='Organization:', options=organizations)#
	<cfelse>
		#hiddenField(objectName='handbooknote', property='personId')#
					
		#hiddenField(objectName='handbooknote', property='organizationId')#
	</cfif>				

	#textArea(objectName='handbooknote', property='note', label='', editor="ckeditor", includeJSLibrary="false", class="ckeditor")#
</cfoutput>