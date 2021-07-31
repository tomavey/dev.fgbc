<cfparam name="pastors" type="query">
<cfset listfilter = true>
<cfset count = 0>

<cfoutput>
	<cfif isDefined("params.pastorsonly")>
		<h1>PASTORS ONLY...</h1>	
		#linkto(text="show all staff", params="", class="btn")#
	<cfelse>
		<h1>ALL STAFF...</h1>	
		#linkto(text="show pastors only", params="pastorsonly=true", class="btn")#
	</cfif>	
	<p>&nbsp;</p>
</cfoutput>

<table>
	<tr>
		<th>Name</th>
		<th>Position</th>
		<th>Email</th>
		<th>Phone</th>
		<th>Conferences attended</th>
	</tr>	
	<cfoutput query="pastors" group="id">
		<cfset regevents = listRegsEvents(id)>
			<tr>
				<td>#linkto(text=fullname, href="/index.cfm?controller=handbook-people&action=show&key=#id#")#</td>
				<td>#left(position,"25")#</td>
				<td>#mailto(email)#</td>
				<td>#phone#</td>	
				<td>#regevents#</td>
				</tr>
		<cfset count = count +1>
	</cfoutput>
</table>
<p>
<cfoutput>
Count = #count#
</cfoutput>
</p>
