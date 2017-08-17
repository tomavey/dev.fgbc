<cfparam name="thisyear" default="#year(now())#">
<cfparam name="yearRange" default="#thisyear-5#,#thisyear-4#,#thisyear-3#,#thisyear-2#,#thisyear-1#,#thisyear#">
<cfoutput>
						<cfif isDefined("handbookorganization.newchurchuuid")>
							#hiddenField(objectName='handbookorganization', property='newchurchuuid')#
						</cfif>
						<cfif isDefined("handbookorganization.applicationuuid")>
							#hiddenField(objectName='handbookorganization', property='applicationuuid')#
						</cfif>

						#textField(objectName='handbookorganization', property='name', label='Name: ')#

						#textField(objectName='handbookorganization', property='alt_name', label='Public Name (as used on web sites, signs, etc: ')#

						#textField(objectName='handbookorganization', property='address1', label='Address: ')#

						#textField(objectName='handbookorganization', property='address2', label='Address: ')#

						#textField(objectName='handbookorganization', property='org_city', label='City: ')#

						#textField(objectName='handbookorganization', property='listed_as_city', label='Listed-as city (optional):')#

						#select(objectName='handbookorganization', property='stateid', label='State: ', options=states)#

						#select(objectName='handbookorganization', property='listed_as_stateid', label='Listed-as State (optional): ', options=states)#

						#textField(objectName='handbookorganization', property='zip', label='Zip: ')#

						#textField(objectName='handbookorganization', property='country', label='Country: ')#

						#select(objectName='handbookorganization', property='districtid', label='District: ', options=districts)#

						#textField(objectName='handbookorganization', property='phone', label='Phone: ')#

						#textField(objectName='handbookorganization', property='fax', label='Fax: ')#

						#textField(objectName='handbookorganization', property='email', label='Email: ')#

						<cfif gotRights("office")>

						#textField(objectName='handbookorganization', property='email2', label='GTD Email: ')#

						</cfif>

						#textField(objectName='handbookorganization', property='website', label='Website: ')#

						#textField(objectName='handbookorganization', property='longitude', label='Longitude: ')#

						#textField(objectName='handbookorganization', property='latitude', label='Latitude: ')#

						#textField(objectName='handbookorganization', property='facebook', label='Facebook: ')#

						#textField(objectName='handbookorganization', property='twitter', label='Twitter: ')#

						#textField(objectName='handbookorganization', property='instagram', label='Instagram: ')#

						#textField(objectName='handbookorganization', property='meetingplace', label='Meetingplace: ')#

						#textArea(objectName='handbookorganization', property='comments', label='Comments: ')#

						<cfif gotRights("superadmin,office,handbookedit")>
							#select(objectName='handbookorganization', property='statusid', label='Status: ', options=status)#
							The following status' will not show in the online handbook: #noShowString#
							<br/><br/><br/>
							#textField(objectName='handbookorganization', property='reviewedBy', label='Reviewer: ')#

						<cfelse>
							#hiddenField(objectName='handbookorganization', property='statusid')#
						</cfif>

						#select(objectName='handbookorganization', property='joinedAt', label='Year Joined: ', options=yearRange, includeBlank="-Select Year-")#

						#textField(objectName='handbookorganization', property='fein', label='FEIN ##: ')#

						#select(objectName='handbookorganization', property='ingrouproster', label='Is this church in our 501c3 group roster? Select the year if relevant.', options=groupsRosterOptions, includeBlank="-Select Option-")#


</cfoutput>