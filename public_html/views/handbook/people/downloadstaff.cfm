<cfparam name="showdownloadbutton" default="true">
<cfif isdefined("params.key") and params.key is "excel">
	<cfset showdownloadbutton = false>
</cfif>
<cfif isdefined("params.download")>
	<cfset showdownloadbutton = false>
</cfif>
<cfif isdefined("params.preview")>
	<cfset showdownloadbutton = false>
</cfif>

<cfif showdownloadbutton>
	<cfoutput>#linkTo(text="Download as excel", key="download", class="btn")#</cfoutput>
</cfif>

<table>
	<tr>
		<th>Last Name</th>
		<th>First Name</th>
		<th>Spouse Name</th>
		<th>Address</th>
		<th>City</th>
		<th>State</th>
		<th>Zip</th>
		<th>Sr Pastor?</th>
		<th>Position</th>
		<th>Home Phone</th>
		<th>Cell Phone</th>
		<th>Work Phone</th>
		<th>Email</th>
		<th>Church</th>
		<th>Church Address</th>
		<th>Church City</th>
		<th>Church State</th>
		<th>Church Zip</th>
		<th>Church Phone</th>
		<th>Church Website</th>
		<th>District</th>
		<th>Updated</th>
		<th>Reviewed</th>
		<th>Reviewed By</th>
		<cfif gotrights("superadmin,office,handbookedit")>
			<th>Handbook Link</th>
		</cfif>
	</tr>
<cfset count = 0>

<cfoutput query="allHandbookPeople">

	<tr>
		<td>#alias('lname',lname,id)#</td>
		<td>#alias('fname',fname,id)#</td>
		<td>#alias('spouse',spouse,id)#</td>
		<td>#address1#</td>
		<td>#city#</td>
		<td>#state#</td>
		<td>#zip#</td>
		<td>
			<cfif p_sortorder is 1>
				Yes
			</cfif>
		</td>
		<td>#position#</td>
		<td>#phone#</td>
		<td>#phone2#</td>
		<td><cfif len(phone3)>
				#phone3#
			<cfelse>
				#handbookorganizationphone#
			</cfif>
		</td>
		<td>#email#</td>
		<td>#name#</td>
		<td>#handbookorganizationaddress1#</td>
		<td>#org_city#</td>
		<td>#state_mail_abbrev#</td>
		<td>#handbookorganizationzip#</td>
		<td>#handbookorganizationphone#</td>
		<td>#fixwebsite(website)#</td>
		<td>#district#</td>
		<td>#dateformat(updatedAt,"medium")#</td>
		<td>#dateformat(reviewedAt,"medium")#</td>
		<td>#reviewedBy#</td>
		<cfif gotrights("superadmin,office")>
		<td>#linkTo(controller="handbook.welcome", action="welcome", onlyPath=false, key=encrypt(email,getSetting("passwordkey"),"CFMX_COMPAT","HEX"))#</td>
		</cfif>

	</tr>
	<cfset count = count +1>

</cfoutput>
</table>
<cfoutput>#count#</cfoutput>