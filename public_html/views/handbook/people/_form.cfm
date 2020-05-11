<cfoutput>

#ckeditor()#

						#flash("error")#

						#errorMessagesFor("handbookperson")#


				<fieldset class="well">
					<legend>Contact Information:</legend>
						#textField(objectName='handbookperson', property='fname', label='First Name: ')#

						#select(objectName='handbookperson', property='fnamegender', options="M,F", label="First name's gender: ", class="input-small")#

						#textField(objectName='handbookperson', property='lname', label='Last Name: ')#

						#textField(objectName='handbookperson', property='prefix', label='Prefix(title before name): ')#

						#textField(objectName='handbookperson', property='suffix', label='Suffix(title after name): ')#

						#textField(objectName='handbookperson', property='spouse', label='Spouse First Name: ')#

						#textField(objectName='handbookperson', property='address1', label='Address: ')#

						#textField(objectName='handbookperson', property='address2', label='Address: ')#

						#textField(objectName='handbookperson', property='city', label='City: ')#

						#select(objectName='handbookperson', property='stateid', options=states, label='State: ', includeBlank="---Select a State---")#

						#textField(objectName='handbookperson', property='zip', label='Zip: ')#

						#textField(objectName='handbookperson', property='country', label='Country: ')#

						#textField(objectName='handbookperson', property='email', label='Preferred Email: ')#

						#textField(objectName='handbookperson', property='email2', label='Secondary Email: ')#

						#textField(objectName='handbookperson', property='spouse_email', label="Email of spouse: ")#

						#textField(objectName='handbookperson', property='phone', label='Home Phone: ')#

						#textField(objectName='handbookperson', property='phone2', label='Cell Phone: ')#

						#textField(objectName='handbookperson', property='phone3', label='Work Phone: ')#

						#textField(objectName='handbookperson', property='phone4', label="Spouse's Cell Phone: ")#

						#textField(objectName='handbookperson', property='skype', label='Skype address: ')#

				</fieldset>

						<cfif !isDefined("params.simple")>
						<!---Testing nothing--->
							#includePartial(handbookPerson.handbookPositions)#
						</cfif>

 	 					<cfif isDefined("handbookprofile.personid")>
 	 						  #hiddenField(objectName='handbookprofile', property='personid')#
						</cfif>

						<cfif !isDefined("params.simple")>
							#includePartial("handbookprofile")#
						</cfif>	

					<cfif gotRights("superadmin,office,handbookedit,agbmadmin")>
					<fieldset class="well">
					<legend>For Office only:</legend>
						#textArea(objectName='handbookperson', property='comment', label='Comment: ')#

						#select(objectName='handbookperson', property='sendHandbook', options="Yes,No", label='Send Handbook: ')#

						#select(objectName='handbookperson', property='gtd', options="No,Yes,Never", label='GTD Person? (Use never to ignore for admin mailings) ')#

						#select(objectName='handbookperson', property='private', options="No,Yes", label='Not Public? (ie: Missionary working in difficult areas) ')#

						#select(objectName='handbookperson', association='handbookprofile', property='agbmlifememberAt', label="Lifetime Member of Inspire Since:", options=licensedOrOrdainedAtOptions(), class="input-small", includeBlank="---", order="year")#</p>

					</fieldset>
					</cfif>
</cfoutput>