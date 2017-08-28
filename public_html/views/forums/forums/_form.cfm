<cfoutput>				
#ckeditor()#
						#textField(objectName='forumforum', property='forum', label='Forum Name: ')#
					
						#hiddenField(objectName='forumforum', property='createdBy')#

						#textField(objectName='forumforum', property='groupCode', label='Group Code: ')#
						
						#Textarea(objectName="forumforum", property="description", Label="description", class='ckeditor', includeJSLibrary="false")#

						#Textarea(objectName="forumforum", property="instructions", Label="Instructions: ", class='ckeditor', includeJSLibrary="false")#

						#Textarea(objectName="forumforum", property="message", Label="Welcome Message: ", class='ckeditor', includeJSLibrary="false")#
</cfoutput>