<cfoutput>
						#textField(objectName='announcement', property='title', label='Title: ')#

						#textArea(objectName='announcement', property='content', label='Content: ', cols="75", rows="10")#

						#textField(objectName='announcement', property='link', label='Link: ')#

						#fileField(objectName='announcement', property='image', label='Image: ')#
						<p>Note: images should be 250px wide and no more that 200px high.</p>

						#select(objectName='announcement', property='position', label='Position: ', options="1,2")#

						#select(objectName='announcement', property='type', label='Where to post? ', options="Both,Announcement Only,News Feed Only")#

						<p>
							Begin: #dateSelect(objectName='announcement', property='startAt')#
						</p>

						<p>
							End (will NOT show on this day): #dateSelect(objectName='announcement', property='endAt')#
						</p>

						#select(objectName='announcement', property='onhold', label='Onhold', options="N,Y")#

</cfoutput>