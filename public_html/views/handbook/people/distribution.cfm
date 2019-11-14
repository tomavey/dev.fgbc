<cfparam name="people" type="query">
<cfparam name="showHandbookLinkColumn" default="true">
<cfset count = 0>
<cfset sendhandbookcount = 0>
<cfif !isDefined("params.download")>
	<cfoutput>
		<cfif !isDefined("params.sendhandbookonly")>
			#linkto(text="Download as Excel", controller="handbook.people", action="distribution", params="download=1")# |
			#linkto(text="Only show send handbook", controller="handbook.people", action="distribution", params="sendhandbookonly")# |
													#linkto(text="Clear Send Handbook Fields", controller="handbook.people", action="clearSendHandbooks", onClick="return confirm('Are you sure? This action cannot be reversed.')")# | 
		<cfelse>
			#linkto(text="Download as Excel", controller="handbook.people", action="distribution", params="download=1&sendhandbookonly")# |
			#linkto(text="Show all", controller="handbook.people", action="distribution")# | 
		</cfif>
		<cfif !isDefined("params.showHandbookLinkColumn")>
			#linkto(text="Show Handbook Update Link Column", controller="handbook.people", action="distribution", params="showHandbookLinkColumn")#
		<cfelse>
			#linkto(text="Hide Handbook Update Link Column", controller="handbook.people", action="distribution", params="")#
		</cfif>
	</cfoutput>
	<p class="well">
		There is also a feature listed under handbook > administration > Send Update Person Links that can be used to send out links for people to update their pages.
	</p>
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
<cfif showHandbookLinkColumn>
	<th>
		SendHandbook Link
	</th>
</cfif>
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
<cfif showHandbookLinkColumn>
	<td>
		<cfif sendHandbook is "yes">
			Send Handbook!
			<cfset sendhandbookcount = sendhandbookcount + 1>
		<cfelse>
			<cfset thispersonid = simpleEncode(id)>
			#linkto(controller="handbook.people", action="setSendHandbook", key=thispersonid, onlyPath=false)#
		</cfif>
	</td>
</cfif>
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