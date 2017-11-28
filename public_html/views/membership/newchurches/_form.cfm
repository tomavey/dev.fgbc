<div id="newchurchform">
<cfoutput>

#ckeditor()#

				#hiddenField(objectName='newchurch', property='uuid')#

<fieldset class="well">
<legend>First, some information about the church starter (planter)...</legend>


						#textField(objectName='newchurch', property='fname', label='First name:')#



						#textField(objectName='newchurch', property='lname', label='Last name:')#



						#textField(objectName='newchurch', property='email', label='Email Address:')#



						#textField(objectName='newchurch', property='phone', label='Phone:')#

</fieldset>
<fieldset class="well">
<legend>Next, some basic info about the church name and location...</legend>

						#textField(objectName='newchurch', property='churchname', label='Church name:', class="input-xlarge")#

						#textField(objectName='newchurch', property='churchaddress', label='Church mailing address:')#

						#textField(objectName='newchurch', property='churchcity', label='Church city:')#

						#select(objectName='newchurch', property='churchstateid', label='Church state:', options=states)#

						#textField(objectName='newchurch', property='churchzip', label='Church zip:')#


</fieldset>

<fieldset class="well">
<legend>Now for the good stuff. Describe the church itself (the people and their commitment)...</legend>

<cfif isDefined("params.old")>

	<div id="newchurchinfo">
		#includePartial("gatherer")#
		#includePartial("shepherd")#
		#linkto(text="From 'Raising Rabbits' by Tony Webb", href="http://www.amazon.com/Raising-Rabbits-not-elephants-exploration-ebook/dp/B00JEPY29W/ref=sr_sp-atf_title_1_1?ie=UTF8&qid=1398521255&sr=8-1&keywords=tony+webb")#
		<p>&nbsp;</p>
		#includePartial("functions")#
	</div>

						#textField(objectName='newchurch', property='family01', label='Family (Gathering family)', class="input-xlarge")#

						#textField(objectName='newchurch', property='family02', label='Family (Shepherding family)', class="input-xlarge")#

						#textField(objectName='newchurch', property='family03', label='Family ##3', class="input-xlarge")#

						#textField(objectName='newchurch', property='family04', label='Family ##4', class="input-xlarge")#

						#textField(objectName='newchurch', property='family05', label='Family ##5', class="input-xlarge")#

						<p>When did your church commit to the #linkto(text="5 functions of a church", action="functions", target="_new", title="Click for more", data_toggle="tooltip", class="tooltipside")#?</p>
							#dateSelect(objectName='newchurch', property='committedAt', dateOrder='year,month,day', monthDisplay='abbreviations', label='', startyear=year(now()), endyear=year(now())-3, class="input-small", includeBlank="---")#

						#textArea(objectName='newchurch', property='committed', label='Describe that commitment: ', class="ckeditor")#

</cfif>

<cfif !isDefined("params.old")>

						#textArea(objectName='newchurch', property='meet', label='Describe this church. How often do you meet? How many do you typically have when you gather?', class="ckeditor")#

						#textArea(objectName='newchurch', property='together', label='How do you follow Jesus together?', class="ckeditor")#

						#textArea(objectName='newchurch', property='gospel', label='In 100 words or less, what is the Gospel?', class="ckeditor")#

						#textArea(objectName='newchurch', property='leaders', label='Who is/are your leader(s) (ie: gatherer, shepherd, elder)', class="ckeditor")#

						#textArea(objectName='newchurch', property='ordinances', label='Tell us about your practice of the ordinances (Baptism and Communion).', class="ckeditor")#

						#textArea(objectName='newchurch', property='mission', label='When you pray for this church, what do you ask for? In other words, what is the mission of this church.', class="ckeditor")#

</cfif>

						#select(objectName='newchurch', property='becomefgbc', label='Does this new church intend to become an official member of Charis Fellowship(*) within 3 years? ', options="No,Yes,Maybe", class="input-small")#


						#textArea(objectName='newchurch', property='story', label='Tell us your church starting story... ', class="ckeditor")#



</fieldset>

<cfif isOffice() || gotRights("handbookedit")>

<fieldset class="well">
<legend>For office only: </legend>
						#textArea(objectName='newchurch', property='comment', label='Comment', class="ckeditor")#


						#select(objectName='newchurch', property='motherchurchId', label='Mother church', options=churches, textField="selectname", class="input-xlarge", includeBlank="----------")#

						#select(objectName='newchurch', property='motherorgId', label='Mother Organization', options=organizations, textField="selectname", class="input-xlarge", includeBlank="----------")#

						<cfif isDefined("newchurch.handbookId") && val(newchurch.handbookId)>
							#linkto(text="Handbook Link - #newchurch.handbookId#", controller="handbook.organizations", action="show", key=newchurch.handbookId)#<br/>
						<cfelse>
							Handbook link<br/>	
						</cfif>	
						#select(objectName='newchurch', property='handbookid', options=churches, textField="selectName", label="", includeBlank="----------")#

						<p>Validated at:
						#dateSelect(objectName='newchurch', property='validatedAt', dateOrder='year,month,day', monthDisplay='abbreviations', label='', startyear=year(now()), endyear=year(now())-3, class="input-small", includeBlank="---")#
						</p>

						<p>Reviewed at:
						#dateSelect(objectName='newchurch', property='reviewedAt', dateOrder='year,month,day', monthDisplay='abbreviations', label='', startyear=year(now()), endyear=year(now())-3, class="input-small", includeBlank="---")#
						</p>


						#textField(objectName='newchurch', property='reviewedBy', label='Reviewed By')#

						#textField(objectName='newchurch', property='grantEligibleAt', label='Eligible for a grant at conference in: ')#

</fieldset>

<p>* Charis Fellowship is the DBA for the Fellowship of Grace Brethren Churches, inc.</p>

</cfif>


</cfoutput>
</div>