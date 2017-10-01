<cfset count = 1>

<cfif isdefined("params.key") and params.key is "excel">

<cfelse>	
	<cfoutput>#buttonTo(text="Download as excel", key="excel")#</cfoutput>
</cfif>

<table class="table">
<thead>
<tr>
<th>fname</th>
<th>lname</th>
<th>address1</th>
<th>address2</th>
<th>city</th>
<th>state_mail_abbrev</th>
<th>zip#</th>
</tr>
</thead>
<tbody>
<cfoutput query="agbmmembers" group="id">
<tr>
<td>#fname#</td>
<td>#lname#</td>
<td>#address1#</td>
<td>#address2#</td>
<td>#city#</td>
<td>#state_mail_abbrev#</td>
<td>#zip#</td>
</tr>
<cfset count = count +1>
</cfoutput>
</tbody>
</table>
<cfoutput>
Count = #count#
</cfoutput>