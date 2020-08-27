<cfoutput>
						#textArea(objectName='handbookprofile', property='ministrystart', label='How long have you been in ministry? How did you get started? ')#
					
						<div class="checkboxes">
						#checkBox(objectName='handbookprofile', property='licensed', label='Licensed? ')#
					
						#checkBox(objectName='handbookprofile', property='ordained', label='Ordained? ')#
						</div>
					
						#textArea(objectName='handbookprofile', property='ordination', label='What is the date of your ordination? Where? Who were involved? ')#
					
						<p>When did you begin your current ministry?<br/> #dateSelect(objectName='handbookprofile', property='currentministrystartat', label='', startyear="1913", endyear=year(now()))#</p>
					
						#textField(objectName='handbookprofile', property='currentministry', label='Which church are you at currently? How long have you been there? How did you get there? ')#
					
						#textField(objectName='handbookprofile', property='website', label='Does your church have a website address? ')#
					
						#textField(objectName='handbookprofile', property='blog', label='Do you write a blog? ')#
					
						<p class="checkboxes">
						#checkBox(objectName='handbookprofile', property='agbmmember', label='Are you a member of AGBM (Association of Grace Brethren Ministers)? ')#
						</p>
					
</cfoutput>