<cfparam name="people" type="query">
<cfset count = 0>
<cfset sendhandbookcount = 0>
<cfif not isDefined("params.download")>
<cfoutput>
	<cfif NOT isDefined("params.sendhandbookonly")>
		#linkto(text="Download as Excel", controller="handbook.people", action="distribution", params="download=1")# |
		#linkto(text="Only show send handbook", controller="handbook.people", action="distribution", params="sendhandbookonly")# |
                        #linkto(text="Clear Send Handbook Fields", controller="handbook.people", action="clearSendHandbooks", onClick="return confirm('Are you sure? This action cannot be reversed.')")#
	<cfelse>
		#linkto(text="Download as Excel", controller="handbook.people", action="distribution", params="download=1&sendhandbookonly")# |
		#linkto(text="Show all", controller="handbook.people", action="distribution")#
	</cfif>
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
SendHandbook Link
</th>
<th>
Email
</th>
</tr>
</thead>
<tbody>
<cfoutput query="people" group="id">
<cfset count = count + 1>
<tr>
<td>
#fullname#
</td>
<td>
#address1#
</td>
<td>
#address2#
</td>
<td>
#city#
</td>
<td>
#state#
</td>
<td>
#zip#
</td>
<td>
<cfif sendHandbook is "yes">
Send Handbook!
<cfset sendhandbookcount = sendhandbookcount + 1>
<cfelse>
<cfset thispersonid = simpleEncode(id)>
#linkto(controller="handbook.people", action="sendHandbook", key=thispersonid, onlyPath=false)#
</cfif>
</td>
<td>
#email#
</td>
</tr>
</cfoutput>
</tbody>
</table>
<br/>
<cfoutput>
Count = #count#<br/>
Send Handbook Count = #sendhandbookcount#
</cfoutput>