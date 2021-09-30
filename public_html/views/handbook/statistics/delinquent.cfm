<div class="table table-stripped">
<cfoutput>
	<cfif isDefined("params.download")>
		<cfset isdownload = true>
	<cfelse>
	#linkto(text="<i class='icon-download-alt'></i>", controller="handbook.statistics", action="delinquent", params="download=true", class="tooltipleft btn download", title="Download this as an excel spreadsheet")#
		<cfset isdownload = false>
	</cfif>
</cfoutput>

	<table>
		<thead>
			<tr>
				<th>
					Church
				</th>
				<th colspan="5" align="center">
					Delinquent Years:
				</th>
			<cfif not isdownload>
				<th colspan="2">
					&nbsp;
				</th>
			</cfif>
			</tr>
		</thead>
		<tbody>
		<cfoutput query="churches">
			<cfif howdelinquent(id) IS NOT false>
				<tr>
					<td>#linkTo(text=name, action="show", controller="Handbook.organizations", key=id)#- #state_mail_abbrev#, #org_city# #joinedAt#</td>
					<td>#howDelinquent(id)# </td>
				<cfif not isdownload>
					<td>#linkTo(
						text='<i class="fa fa-list" aria-hidden="true"></i>',
						controller=handbook.statistics,
						action="list",
						title="List"
					)#</td>
					<td>
						<cfif gotrights("office")>
							<cfset body = "Greetings!%0D%0A%0D%0AI am working on the membership and stat report for the Fellowship Council and would like it as complete as possible.%0D%0A%0D%0AWould it be possible for you to use this link to submit that information this week? https://charisfellowship.us/sendstats/?churchid=#id#.%0D%0A%0D%0AIf you believe this has already been cared for, let me know and I will check it out!%0D%0A%0D%0A(note:the Fellowship of Grace Brethren Churches is now doing business as Charis Fellowship)">
							<cfset subject = "Charis Fellowship">
							#mailTo(emailaddress="#getOrgEmails(id)#?subject=#subject#&body=#body#" , name="Send Link")#
						<cfelse>
							&nbsp;	
						</cfif>
					</td>
				</cfif>
				</tr>
			</cfif>
		</cfoutput>
		<tbody>
	</table>
</div>
