<cfset count=1>
<cfset countchurches = 1>
<cfset previousIndex = "">
<cfset previousOrgId = "">
<cfif NOT isDefined("params.download")>
<cfoutput>
#linkTo(text="Download as Excel", controller="handbook.organizations", action="updatelinks", params="#cgi.query_string#&download=yes", class="btn")#
<cfif isDefined("params.reviewedBefore")>
	#linkTo(text="Show All", params="", class="btn", controller="handbook.organizations", action="updatelinks")#
<cfelse>
	#linkTo(text="Show only NOT reviewed after #year(now())#-08-01", controller="handbook.organizations", action="updatelinks", params="reviewedBefore=#year(now())#-08-01", class="btn")#
</cfif>
<cfif isDefined("params.ministries")>
	#linkTo(text="Show Churches", params="", class="btn", controller="handbook.organizations", action="updatelinks")#
<cfelse>
	#linkTo(text="Show Ministries", controller="handbook.organizations", action="updatelinks", params="ministries=true", class="btn")#
</cfif>
</cfoutput>
</cfif>
<table>
<tr>
<th>
Church Name
</th>
<th>
Email Address
</th>
<th>
Link
</th>
<th>
Last Reviewed
</th>
</tr>

<cfoutput query="organizations">
	<cfset emailallthischurch = email & ";" & handbookpersonemail & ";" & reviewedBy>
	<cfloop list="#emailallthischurch#" index="i" delimiters=";">
		<cfif i NEQ previousIndex>
			<tr>
				<td>
					#selectName#
				</td>
					<cfif NOT len(email) and len(handbookpersonemail)>
						  <cfset email = handbookpersonemail>
					</cfif>
				<td>
					#mailto(i)#
				</td>
				<td>
					#linkto(route="reviewhandbook", orgid=simpleEncode(id), onlyPath=false)#
				</td>
				<td>
					#dateformat(reviewedAt)#
				</td>
			</tr>
			<cfset count = count + 1>
			<cfif id NEQ previousOrgId>
				<cfset countChurches = countChurches + 1>
			</cfif>
		</cfif>
		<cfset previousIndex = i>
		<cfset previousOrgId = id>
	</cfloop>
</cfoutput>
</table>
<cfoutput>
Count = #count#<br/>
Church count = #countChurches#
</cfoutput>
