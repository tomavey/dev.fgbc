<cfoutput>

#ckeditor()#
						#hiddenField(objectName='announcement', property='event')#



						#textField(objectName='announcement', property='subject', label='Subject: ')#


						#textArea(objectName='announcement', property='content', label='Announcement (200 words or less, one simple paragraph):', id="textarea-a", class="ckeditor")#


						#textField(objectName='announcement', property='link', label='Link (optional): ')#



						#textField(objectName='announcement', property='author', label="Author's email address: ")#


						#select(objectName='announcement', property='approved', label='Approved: ', options="yes,no")#

						#select(objectName='announcement', property='emailOnly', label='Email Only (if "yes", this will not show in the app): ', options="no,yes")#

						#select(objectName='announcement', property='showHomeScreen', label='Show On Home Screen (if "yes", this will display on the home screen of the app): ', options="no,yes")#

						<!---
						#select(objectName='announcement', property='sendType', label='Type of Send: ', options="never,digest,immediate")#
--->
					<p>
						#radioButton(objectName='announcement', property='invoiceLink', tagValue="yes", label="Include link to Invoice")#
					</p><br/>
					<p>When to post?</p>
						#dateTimeSelect(objectName='announcement', property='postAt', timeOrder="hour,minute")#
<!---
					<p>When would you like your announcement to post?</p>

					<cfif isBefore("2016-07-21")>

						#radioButton(objectName='announcement', property='postAt', tagValue=dateformat(now(),"yyyy-mm-dd"), label="Before Conference")#

					</cfif>

					<cfif isBefore("2016-07-22")>

						#radioButton(objectName='announcement', property='postAt', tagValue="2016-07-21", label="Thursday")#
					</cfif>

					<cfif isBefore("2016-07-23")>

						#radioButton(objectName='announcement', property='postAt', tagValue="2016-07-22", label="Friday")#

					</cfif>

					<cfif isBefore("2016-07-24")>

						#radioButton(objectName='announcement', property='postAt', tagValue="2016-07-23", label="Saturday")#

					</cfif>

					<cfif isBefore("2016-07-25")>

						#radioButton(objectName='announcement', property='postAt', tagValue="2016-07-24", label="Sunday")#

					</cfif>

					<cfif isBefore("2017-07-26")>

						#radioButton(objectName='announcement', property='postAt', tagValue="2016-07-25", label="Monday")#

					</cfif>

						#radioButton(objectName='announcement', property='postAt', tagValue="2016-07-26", label="After conference")#
--->

</cfoutput>