<cfif not isdefined("params.format") OR not params.format is "excel">
	<cfoutput>
		#linkTo(text="Download as Excel", action="download", key=params.key, params="format=excel")#
	</cfoutput>
</cfif>

<cfif showtitles>
	<h2>People:</h2>
</cfif>

<cfif TaggedPeople.recordcount>
	<table>
		<tr>
			<th>Last Name</th>
			<th>First Name</th>
			<th>Spouse</th>
			<th>Address1</th>
			<th>Address2</th>
			<th>City</th>
			<th>State</th>
			<th>Zip</th>
			<th>Phone1</th>
			<th>Phone2</th>
			<th>Email1</th>
			<th>Email2</th>
			<th>Position</th>
			<th>Organization</th>
			<th>Organization Address1</th>
			<th>Organization Address2</th>
			<th>Organization City</th>
			<th>Organization State</th>
			<th>Organization Zip</th>
			<th>Organization Phone</th>
			<th>Organization Email</th>
		</tr>
		<cfoutput query="TaggedPeople">
		<tr>
			<td>#lname#</td>
			<td>#fname#</td>
			<td>#spouse#</td>
			<td>#Address1#</td>
			<td>#address2#</td>
			<td>#city#</td>
			<td>#state_mail_abbrev#</td>
			<td>#zip#</td>
			<td>#phone#</td>
			<td>#phone2#</td>
			<td>#email#</td>
			<td>#email2#</td>
			<td>#position#</td>
			<td>#name#</td>
			<td>#handbookOrganizationAddress1#</td>
			<td>#handbookOrganizationAddress2#</td>
			<td>#Org_City#</td>
			<td><cftry>#getState(handbookOrganizationStateid)#<cfcatch>BAD STATE ID</cfcatch></cftry></td>
			<td>#handbookOrganizationZip#</td>
			<td>#handbookOrganizationPhone#</td>
			<td>#handbookOrganizationEmail#</td>
		</tr>
		</cfoutput>
	</table>
</cfif>

<cfif showtitles>
	<h2>Organizations:</h2>
</cfif>

<cfif TaggedOrganizations.recordcount>
	<table>
		<tr>
			<th>Organizations Name</th>
			<th>Address1</th>
			<th>Address2</th>
			<th>City</th>
			<th>State</th>
			<th>Phone</th>
			<th>Email</th>
			<th>Position</th>
			<th>First Name</th>
			<th>Last Name</th>
			<th>Email1</th>
			<th>Email2</th>
			<th>Phone1</th>
			<th>Phone2</th>
		</th>
		<cfoutput query="TaggedOrganizations">
		<tr>
			<td>#name#</td>
			<td>#Address1#</td>
			<td>#address2#</td>
			<td>#org_city#</td>
			<td>#state_mail_abbrev#</td>
			<td>#phone#</td>
			<td>#email#</td>
			<td>#position#</td>
			<td>#fname#</td>
			<td>#lname#</td>
			<td>#handbookpersonemail#</td>
			<td>#email2#</td>
			<td>#handbookpersonphone#</td>
			<td>#phone2#</td>
		</tr>
		</cfoutput>
	</table>
</cfif>
