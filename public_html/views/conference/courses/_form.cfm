<cfoutput>

<!---#ckeditor()#--->

						#hiddenField(objectName='course', property='event')#

						#textField(objectName='course', property='title', label='Title')#

						#select(objectName='course', property='type', label='Type of event:', options=typesOfCoursesForDropdown())#

						#select(objectName='course', property='subtype', label='Sub Type of event:', options=subTypesOfCourses(), includeBlank="---Optional---")#

						#select(objectName='course', property='track', label='Track', options=tracksOfCourses(), includeBlank="---Select one track---")#

						#textField(objectName='course', property='radioButtonGroup', label='Radio Button Group')#

						#textField(objectName='course', property='recordinglink', label='Link to recording (without path it will add http://www.fgbc.org/files/Audio), for by request only, enter "request"')#

						#textField(objectName='course', property='max', label='Maximum sign-ups allowed: ')#

						#textArea(objectName='course', property='descriptionLong', label='Description Long', class="ckeditor", class="span10", rows="7")#

						#textArea(objectName='course', property='descriptionShort', label='Description Short', class="ckeditor", class="span10", rows="7")#

						#select(objectName='course', property='eventid', label='Event', options=events, textfield="selectnameid", class="input-xxlarge")#

						#select(objectName='course', property='display', label='Display?', options="Yes,No")#

						#textArea(objectName='course', property='comment', label='Comment')#

						#textArea(objectName='course', property='commentPublic', label='Comment Public')#



</cfoutput>
