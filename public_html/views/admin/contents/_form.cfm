<cfoutput>

						#hiddenTagForKeyy()#
						
						#textField(objectName='content', property='name', label='Name: ')#

						#select(objectName="content", property="displayName", options="Yes,No")#

						#textArea(objectName='content', property='content', label='Content: ', rows="20", cols="200", class="ckeditor")#

						#textField(objectName='content', property='thread_of_id', label='Thread Of: ')#

						#textField(objectName='content', property='shortlink', label='Short Link: ')#

						#textField(objectName='content', property='author', label='Author: ')#

						#textField(objectName='content', property='redirectTo', label='Redirect to this url: ')#

						#select(objectName='content', property='rightsRequired', label='Rights Required (if you want to restrict access: ', options=rights, valueField="name", includeBlank="----Select if needed----")#

						#textArea(objectName='content', property='comment', label='Comment: ')#

</cfoutput>