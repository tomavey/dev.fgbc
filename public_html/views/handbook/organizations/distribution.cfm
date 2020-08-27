<cfparam name="distribution" type="query">
<cfset churchcount = 0>
<cfset handbookcount = 0>
<cfif not isDefined("params.download")>
<cfoutput>
#linkto(text="Download as Excel", controller="handbook.organizations", action="distribution", params="download=true")#
</cfoutput>
</cfif>
<table>
<thead>
<tr>
<th>
Name
</th>
<th>
Address1
</th>
<th>
Address2
</th>
<th>
City
</th>
<th>
State
</th>
<th>
Zip
</th>
<th>
Count
</th>
</tr>
</thead>
<tbody>
<cfoutput query="distribution">
<cfset churchcount = churchcount + 1>
<tr>
<td>
#name#
</td>
<td>
#address1#
</td>
<td>
#address2#
</td>
<td>
#org_city#
</td>
<td>
#state#
</td>
<td>
#zip#
</td>
<td>
<cfset thishandbookcount = getHandbooksCount(id)>
#thishandbookcount#
<cfset handbookcount = handbookcount + thisHandbookCount>
</td>
</tr>
</cfoutput>
</tbody>
</table>
<br/>
<cfoutput>
Church count = #churchcount#<br/>
Handbook count = #handbookcount#
</cfoutput>