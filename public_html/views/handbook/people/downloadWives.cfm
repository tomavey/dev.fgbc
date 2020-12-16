<!--- <cfdump var="#pastorsWives#"><cfabort> --->
<cfparam name="showdownloadbutton" default="true">
<cfif isdefined("params.download")>
	<cfset showdownloadbutton = false>
</cfif>
<cfif isdefined("params.preview")>
	<cfset showdownloadbutton = false>
</cfif>

<cfif showdownloadbutton>
	<cfoutput>#linkToPlus(text="Download as excel", addParams="download=excel", class="btn")#</cfoutput>
</cfif>

<cfif !isDefined('params.onlyIfEmail') && showdownloadbutton>
	<cfoutput>#linkToPlus(text="List ONLY if there IS an email address", addParams="onlyIfEmail", class="btn")#</cfoutput>
</cfif>

<cfif isDefined('params.onlyIfEmail') && showdownloadbutton>
	<cfoutput>#linkTo(text="List EVEN if there IS NOT an email address", route="handbookPeoplePastorsWives", class="btn")#</cfoutput>
</cfif>

<table>
	<tr>
		<th>Last Name</th>
		<th>First Name</th>
		<th>Address</th>
		<th>City</th>
		<th>State</th>
		<th>Zip</th>
		<th>Email</th>
		<th>Cell Phone</th>
		<th>His Position</th>
		<th>Church Name</th>
	</tr>
<cfset count = 0>

<cfoutput query="pastorsWives" group="id">

	<tr>
		<td>#alias('lname',lname,id)#</td>
		<td>#alias('spouse',spouse,id)#</td>
		<td>#address1#</td>
		<td>#city#</td>
		<td>#state_mail_abbrev#</td>
    <td>#zip#</td>
    <td>#spouse_email#</td>
    <td>#phone4#</td>
		<td>#hisPosition#</td>
		<td>#churchNameCity#</td>
	</tr>
	<cfset count = count +1>

</cfoutput>
</table>
<cfoutput>#count#</cfoutput>