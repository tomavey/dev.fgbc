<cfoutput>				
						#textField(objectName='forumforum', property='forum', label='Forum Name: ')#
					
						#hiddenField(objectName='forumforum', property='createdBy')#

						#textField(objectName='forumforum', property='groupCode', label='Group Code: ')#
						
						#richTextField(objectName="forumforum", property="description", Label="description", editor='ckeditor', includeJSLibrary="false")#

						#richTextField(objectName="forumforum", property="instructions", Label="Instructions: ", editor='ckeditor', includeJSLibrary="false")#

						#richTextField(objectName="forumforum", property="message", Label="Welcome Message: ", editor='ckeditor', includeJSLibrary="false")#
</cfoutput>