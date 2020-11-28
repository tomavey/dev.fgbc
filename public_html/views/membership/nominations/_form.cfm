<cfoutput>
#ckeditor()#

						#hiddenTagForKeyy()#

						<cfif gotRights("office")>
							<p>#textField(objectName='nominations', property='year', label="Nominate year: ")#</p>
						<cfelse>
							#hiddenField(objectName='nominations', property='year')#
						</cfif>

						<p>#textField(objectName='nominations', property='name', label="Name of person filling out this form (that's you!): ")#</p>

						<p>#textField(objectName='nominations', property='email', label='Email address of person filling out this form (your email address): ')#</p>

						<p>#textField(objectName='nominations', property='position', label='Position of person filling out this form (what is your district office or role): ')#</p>

						<p>#textField(objectName='nominations', property='phone', label='Phone of person filling out this form (your phone number): ')#</p>

						<p>#select(objectName='nominations', property='districtid', label='District: ', options=districts, valuefield="districtid", includeBlank="--Select Your District--")#</p>

						<p>#textArea(objectName='nominations', property='describeNomination', label='Describe the nomination process (was there a district meeting?  When? Where?): ', class="ckeditor")#</p>

						<p>#textField(objectName='nominations', property='nomineeName', label='Name of person being nominated: ')#</p>

						<p>#textField(objectName='nominations', property='nomineeEmail', label='Email of person being nominated: ')#</p>

						<p>#textField(objectName='nominations', property='nomineeChurch', label='Church of person being nominated: ')#</p>

						#includePartial(partial="regions")#

						<p>#select(objectName='nominations', property='region', options='Region A,Region B,Region C', includeBlank="--Select Your Region--")#</p>

						<p>#textArea(objectName='nominations', property='bio', label='Bio of person being nominated: : ', class="ckeditor")#</p>

<cfif gotRights("superadmin,office")>
						<p>#textArea(objectName='nominations', property='bioShort', label='Short bio of person being nominated: : ', class="ckeditor")#</p>

						<p>#textField(objectName='nominations', property='piclink', label='Picture: (put pictures in /images/fellowshipcouncil/nominated - include a 62x85 _web version) location (url) : ')#</p>

						<p>#textField(objectName='nominations', property='handbookpeopleid', label='Handbook ID##: ')#</p>

</cfif>

<cfif params.action is "edit">

						<p>#select(objectName="nominations", property="status", options="Pending,Active,Archive")#</p>
<cfelse>
						#hiddenField(objectName="nominations", property="status")#
</cfif>

						<p>#textArea(objectName='nominations', property='comments', label='Additional comments: ', class="ckeditor")#</p>
</cfoutput>