<cfparam name="exhibit" type="struct">
<cfparam name="params.office" default="false">
<cfparam name="optionslist" default="0,1,2">
<cfparam name='sectionslist' default="B,C,D">
<cfif params.action is "edit">
<cfset sectionslist = "A,B,C,D">
</cfif>
<cfset yesno = queryNew("dec,text","Integer,VarChar")>
<cfset queryAddRow(yesno,2)>
<cfset querySetCell(yesno,"dec",0,1)>
<cfset querySetCell(yesno,"text","no",1)>
<cfset querySetCell(yesno,"dec",1,2)>
<cfset querySetCell(yesno,"text","yes",2)>



<cfoutput>

			#hiddenFieldTag(name='exhibit[event]', value="#getEvent()#")#

	<fieldset>
		<legend>Contact Information</legend>
						#textField(objectName='exhibit', property='organization', label='Organization:', class="input-xlarge")#

						#textField(objectName='exhibit', property='address', label='Address:', class="input-xlarge")#

						#textField(objectName='exhibit', property='person', label='Contact Person:', class="input-xlarge")#

						#textField(objectName='exhibit', property='phone', label='Phone:', class="input-xlarge")#

						#textField(objectName='exhibit', property='email', label='Email:', class="input-xlarge")#

						#textField(objectName='exhibit', property='fax', label='Fax:', class="input-xlarge")#
	</fieldset>
	<fieldset>
		<legend>Specifications</legend>
						#select(objectName='exhibit', property='numbertables', label='Number of spaces w/tables:', options=optionslist, class="input-mini")#

						<cfif getEvent() is "visionconference2019">
							<p style="font-size: .8em">Note: if you would like 6' tables instead of 8' tables, indicate accordingly in the special request field below.</p>
							<p style="font-size: .8em">Also, you may be limited to one table depending on space and requests.  Space is limited!</p>
						</cfif>

						#select(objectName='exhibit', property='numberspaces', label='Number of spaces w/o tables:', options=optionslist, class="input-mini")#

						#hiddenFieldTag(name="exhibit[section]", value="A")#

						<!---#select(objectName='exhibit', property='section', label='Section: ', options=sectionslist)#--->

						#select(objectName='exhibit', property='elect', label='Will you need electricity?', options=yesno, valueField="dec", class="input-mini")#

						#select(objectName='exhibit', property='specialrequest', label='Do you want to participate in the give-away? We will invoice you an additional $50 and place a basket on your exhibit to collect names for a drawing:', class="input-block-level span9", options=yesno, class="input-mini")#

	</fieldset>
				<cfif params.action is "edit">

						#textField(objectName='exhibit', property='checkno', label='Check no.')#

						#textField(objectName='exhibit', property='checkdate', label='Check date')#

						#textField(objectName='exhibit', property='amount', label='Amount')#

						#select(objectName='exhibit', property='approved', label='Approved', options="Yes,No", includeBlank="---select one---")#

						#select(objectName='exhibit', property='type', label='Type', options="Exhibit,Sponsor,Both", includeBlank="---select one---")#

						#textField(objectName='exhibit', property='comments', label='Comments')#

						#textArea(objectName='exhibit', property='description', label='Description for mobile app: ', cass="input-block-level", style="width:100%;height:50px")#

						#textArea(objectName='exhibit', property='sponsordescription', label='Additional Sponsor Description for mobile app: ', cass="input-block-level")#

						#textField(objectName='exhibit', property='logo', label='Logo (file name): ', class="input-xlarge")#

						#textField(objectName='exhibit', property='website', label='Website: ', class="input-xlarge")#

						#textField(objectName='exhibit', property='sortOrder', label='Sort Order: ', class="input-small")#

						#textField(objectName='exhibit', property='files', label='Files (comma delimited list with quotes and full path : ', class="input-xxlarge")#

				</cfif>
	</cfoutput>