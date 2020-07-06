<cfparam name="registrations" type="query">

<table>
<cfoutput query="registrations" group="registrantid">
	
<tr>
<td>#fname#</td>
<td>#lname#</td>
<td>#email#</td>
<td>#roommate#</td>
</tr>
	<cfoutput>
	</cfoutput>
</cfoutput>
</table>