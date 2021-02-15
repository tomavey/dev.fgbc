<cfset count = 1>
<cfif not isDefined("params.download")>
	<cfoutput>
		<cfif not isDefined("params.key")>
			#linkTo(text="Download as excel", controller="handbook.organizations", action="downloadmemberchurches", params="download=1", class="btn")#
			<cfif isDefined("params.dba")>
				#linkTo(text="Use Official Names", controller=params.controller, action=params.action, class="btn")#
			<cfelse>
				#linkTo(text="Use Public Names", controller=params.controller, action=params.action, params="dba=true", class="btn")#
			</cfif>
		<cfelse>
			#linkTo(text="Download as excel", key=params.key, controller="handbook.organizations", action="downloadmemberchurches", params="download=1", class="btn")#
			<cfif isDefined("params.dba")>
				#linkTo(text="Use Official Names", controller=params.controller, action=params.action, key=params.key, class="btn")#
			<cfelse>
				#linkTo(text="Use Public Names", controller=params.controller, action=params.action, key=params.key, params="dba=true", class="btn")#
			</cfif>
		</cfif>
	</cfoutput>
</cfif>
<table>
	<thead>
		<th>
			<cfif isDefined("params.dba")>
				Public Name
			<cfelse>
				Name
			</cfif>
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
			Phone
		</th>
		<th>
			Email
		</th>
		<th>
			Email
		</th>
		<th>
			Attendance
		</th>
		<th>
			Last stats
		</th>
		<th>
			Status
		</th>

	</thead>
<cfoutput query="churches">
<cfset seniorPastorEmail = $getSeniorPastorEmail(id)>
	<tr>
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
			#state#
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
	<cfif len(seniorpastoremail) and email NEQ seniorpastoremail>
		<td>
			#seniorpastoremail#
		</td>
	<cfelse>
		<td>
			&nbsp;
		</td>
	</cfif>
		<td>
			#$getLastAtt(id)#
		</td>
		<td>
			#$getLastAttYear(id)#
		</td>
		<td>
			#churches.status#
		</td>
	</tr>
	<cfset count = count + 1>
</cfoutput>
</table>
<cfif NOT isDefined("params.download")>
	<cfoutput>
		Count = #count#
	</cfoutput>
</cfif>
<div>
</div>
