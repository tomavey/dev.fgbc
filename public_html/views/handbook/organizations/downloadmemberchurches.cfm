<cfif !isdefined("params.format") OR params.format NEQ "excel">
	<cfoutput>
		#linkTo(text="Download as Excel", route="handbookDownloadmembers", params="format=excel")# |
		<cfif isDefined("params.dba")>
			#linkTo(text="Use Public Names", controller=params.controller, action=params.action)#
		<cfelse>
			#linkTo(text="Use Official Names", controller=params.controller, action=params.action, params="dba=true")#
		</cfif>
	</cfoutput>
</cfif>

<cfsavecontent variable = "request.data">
<table>
	<cfoutput query="memberChurches">
	<tr>
		<td>
			#id#
		</td>
		<td>
			<cfif isDefined("params.dba") && len(alt_name)>
				#alt_name#
			<cfelse>
				#name#
			</cfif>
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
			#state_mail_abbrev#
		</td>
		<td>
			#zip#
		</td>
		<td>
			#phone#
		</td>
		<td>
			#email#
		</td>
		<td>
			#district#
		</td>
		<td>
			#status#
		</td>
		<td>
			#website#
		</td>
		<cfset seniorpastor = getSeniorPastor(id)>
		<td>
			#seniorpastor.lname#
		</td>
		<td>
			#seniorpastor.fname#
		</td>
		<td>
			<cfif len(seniorpastor.email)>
				#seniorpastor.email#
			<cfelse>
				#email#
			</cfif>
		</td>
		<td>
			#seniorpastor.phone#
		</td>
		<cfif gotrights("superadmin")>
		<td>
			#linkto(route="reviewhandbook", orgid=simpleEncode(id), onlyPath=false)#
		</td>
		</cfif>
	</tr>
	</cfoutput>
</table>

<cfoutput>Count:#memberChurches.recordcount# </cfoutput>
</cfsavecontent>
<cfoutput>#request.data#</cfoutput>