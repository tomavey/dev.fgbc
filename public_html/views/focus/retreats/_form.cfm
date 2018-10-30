<style>
	p span {margin-left:10px}
	p {margin-bottom:20px}
</style>
<cfoutput>

#ckeditor()#

						#textField(objectName='retreat', property='regid', label='ID for Registration Item: ')#

						#textField(objectName='retreat', property='title', label='Title: ')#

						#textField(objectName='retreat', property='menuname', label='Menu name: ')#

<!--- 						#fileField(objectName='retreat', property='image', label='Image: ')# --->

						#select(objectName='retreat', property='active', label='Active? (this retreat will show up in admin.', options="Yes,No", values = "1,0")#

						#select(objectName='retreat', property='showregs', label='Show in the admin list of registrations? ', options="Yes,No", values = "1,0")#

						#select(objectName='retreat', property='regisopen', label='Registration is open? ', options="Yes,No", values = "1,0")#

						<p>Beginning Date:
							#dateSelect(objectName='retreat', property='startAt', dateOrder='year,month,day', monthDisplay='abbreviations', class="input-small")#
						</p>

						<p>Ending Date:
							#dateSelect(objectName='retreat', property='endAt', dateOrder='year,month,day', monthDisplay='abbreviations', class="input-small")#
						</p>

						<p>Discount Deadline:
							#dateSelect(objectName='retreat', property='discountdeadline', dateOrder='year,month,day', monthDisplay='abbreviations', class="input-small")#
						</p>

						#select(objectName='retreat', property='priceincrease', label='Planned price increase (must increase reg prices manually): ', options="5,10,15,20")#

						<p>Registration Deadline:
							#dateSelect(objectName='retreat', property='deadline', dateOrder='year,month,day', monthDisplay='abbreviations', class="input-small")#</br>
							<span>After this date the public registration will be closed.</span>
						</p>

						<p>Stop showing who is coming:
							#dateSelect(objectName='retreat', property='whoiscomingdeadline', dateOrder='year,month,day', monthDisplay='abbreviations', class="input-small")#</br>
							<span>After this date the "Who is coming link on the retreat page will not show, unless the viewer is logged in as an admin.</span>
						</p>

						<p>Comments for Registration: <br/>
						#textArea(objectName='retreat', property='registrationcomments', label='Comments', cols="75", rows="10", class="ckeditor")#
						</p>

						<p>Not Open Message: <br/>
						#textArea(objectName='retreat', property='notopenmessage', label='', editor="ckeditor", rows=10, cols=100, class="ckeditor")#
						<span>This is what will show in place of the registration info when the retreat is marked 'No' in the 'Registration is open" field (above).</span>
						</p>

						<p>Past the deadline message: <br/>
						#textArea(objectName='retreat', property='pastdeadlinemessage', label='', editor="ckeditor", rows=10, cols=100, class="ckeditor")#
						<span>This is what will show in place of the registration info when it is past the registration deadline.</span>
						</p>

						<p>Schedule: <br/>
						#textArea(objectName='retreat', property='schedule', label='', editor="ckeditor", rows=10, cols=100, class="ckeditor")#
						</p>

						<p>Location: (images should be less than 400px wide @ 72dpi) <br/>
						#textArea(objectName='retreat', property='location', label='', editor="ckeditor", rows=10, cols=100, class="ckeditor")#
						</p>

						<p>Comments: <br/>
						#textArea(objectName='retreat', property='comments', label='', editor='ckeditor', rows=10, cols=100, class="ckeditor")#
						</p>

<!--- 						#textField(objectName='retreat', property='facebooklink', label='Facebook Link ')# --->

</cfoutput>