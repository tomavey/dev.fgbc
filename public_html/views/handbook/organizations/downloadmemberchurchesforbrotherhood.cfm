<cfif not isdefined("params.format") OR not params.format is "excel" or not params.key is "excel">
	<cfoutput>
		#linkTo(text="Download as Excel", route="handbookDownloadMemberChurchesForBrotherhood", key="excel", params=#cgi.query_string#)# |
		<cfif isDefined("params.dba")>
			#linkTo(text="Use Public Names", controller=params.controller, action=params.action)#
		<cfelse>
			#linkTo(text="Use Official Names", controller=params.controller, action=params.action, params="dba=true")#
		</cfif>
	</cfoutput>
</cfif>

<cfsavecontent variable = "request.data">
<table>
	<tr>
		<td>Name of Ministry/Church</td>
		<td>Physical Address Street</td>
		<td>Physical Address City</td>
		<td>Physical Address State</td>
		<td>Physical Address Zip</td>
		<td>Mailing Address Street</td>
		<td>Mailing Address City</td>
		<td>Mailing Address State</td>
		<td>Mailing Address Zip</td>
		<td>Ministry Phone Number</td>
		<td>Pastor's First Name</td>
		<td>Pastor's Last Name</td>
		<td>Pastor's Email Address</td>
	</tr>
	<cfoutput query="memberChurches">
	<tr>
		<td>
			<cfif isDefined("params.dba") && len(alt_name)>
				#alt_name#
			<cfelse>
				#name#
			</cfif>
		</td>
		<td>
			#address1# #address2#
		</td>
		<td>
			#org_city#
		</td>
		<td>
			#state_mail_abbrev#
		</td>
		<td>
			#zip#
		</td>
		<td>
			<cfif address2 contains "box">
			#address2#
			<cfelse>
			#address1# #address2#
			</cfif>
		</td>
		<td>
			#org_city#
		</td>
		<td>
			#state_mail_abbrev#
		</td>
		<td>
			#zip#
		</td>
		<td>
			#phone#
		</td>
		<cfset seniorpastor = getSeniorPastor(id)>
		<td>
			#seniorpastor.fname#
		</td>
		<td>
			#seniorpastor.lname#
		</td>
		<td>
			<cfif len(seniorpastor.email)>
				#seniorpastor.email#
			<cfelse>
				#email#
			</cfif>
		</td>
	</tr>
	</cfoutput>
</table>

<cfoutput>Count:#memberChurches.recordcount# </cfoutput>
</cfsavecontent>
<cfoutput>#request.data#</cfoutput>