<cfoutput>
#ckeditor()#

						#textField(objectName='announcement', property='title', label='Title: ')#

						#textField(objectName='announcement', property='link', label='Link: (Title will link to this. Use full URL (ie: "http://..." or "https://..."))')#

						#textArea(objectName='announcement', property='content', label='Content (images should be less than 400px wide): ', cols="75", rows="10", class="ckeditor")#


<!--- 						#textField(objectName="announcement", property="image", label="imageUrl")# --->

<!---Not working - needs to be fixed---

						#fileField(objectName='announcement', property='image', label='Image: ')#
						<p>Note: images should be 250px wide and no more that 200px high.</p>

Might need to do without plugin
Hint - check into how the FC site does it using cffile tag
------------------------------------->

<!--- Not used
						#hidden(objectName='announcement', property='position', label='Position: ', options="1,2")#
--->
						#select(objectName='announcement', property='type', label='Where to post? ', options="Both,Announcement Only,News Feed Only")#
						<ul style="margin-top:-20px; font-size:.8em">
						<li>Announcement only means just the web page - no twitter feed</li>
						<li>Newsfeed only means just twitter feed - will not show on web page</li>
						<li>Both means both</li>
						</ul>
						<p style="margin-top:30px; font-size:.8em; margin-bottom:5px">About selecting dates: make sure the date exists.  For example November 31 does not exist!</p>
						<p>
							Begin: #dateSelect(objectName='announcement', property='startAt')#
						</p>

						<p>
							End (will NOT show on this day): #dateSelect(objectName='announcement', property='endAt')#
						</p>

						#select(objectName='announcement', property='onhold', label='Onhold', options="N,Y")#

</cfoutput>