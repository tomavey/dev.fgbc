<cfset count = 1>

<cfif isdefined("params.format") and params.format is "excel">

<cfelse>	
	<cfoutput>#Linkto(text="Download as excel", route="handbookDownloadagbm", params="format=excel")#</cfoutput>
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
<th>zip</th>
<cfif isDefined("params.byage")>
<th>Birth Year</th>
</cfif>
</tr>
</thead>
<tbody>
<cfoutput query="agbmmembers" group="id">
<tr>
<td>#alias('fname',fname,id)#</td>
<td>#alias('lname',lname,id)#</td>
<td>#address1#</td>
<td>#address2#</td>
<td>#city#</td>
<td>#state_mail_abbrev#</td>
<td>#zip#</td>
<cfif isDefined("params.byage") && birthdayyear NEQ 1900>
<th>#birthdayyear#</th>
</cfif>
</tr>
<cfset count = count +1>
</cfoutput>
</tbody>
</table>
<cfoutput>
<p>Count = #count#</p>
<cfif !isDefined("params.byage") && gotRights("office,agbmadmin")>
	<p>#linkto(text="Add Birthyear", action="downloadagbm", params="byAge=DESC")#</p>
</cfif>
</cfoutput>