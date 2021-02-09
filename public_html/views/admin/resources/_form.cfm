<cfoutput>

	#textField(objectName='resource', property='author', label='Author: ')#

	#textField(objectName='resource', property='description', label='Description: ')#

	#textField(objectName='resource', property='file', label='File: ')#

	#select(objectName='resource', property='status', options="Private,Public", label='File: ')#

	#textField(objectName='resource', property='webaddress', label='Url: ')#

	#textField(objectName='resource', property='image', label='Image Url: ')#

	#textArea(objectName='resource', property='summary', label='Comment: ', rows='5', cols="75")#

</cfoutput>
