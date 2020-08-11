<!--- <cfdump var="#people#"><cfabort> --->
<cfset count = 0>
<cfset emailall = "">
<cfif isDefined("params.download")>
	  <cfset downloadthis = true>
<cfelse>
	  <cfset downloadthis = false>
</cfif>
<cfoutput>
<cfif not downloadthis>
#linkto(text="<i class='icon-download-alt'></i>", controller="handbook.agbminfo", action="delinquent", params="download=true", class="tooltipleft btn download", title="Download this list as an excel spreadsheet")#
</cfif>
	<h2>AGBM Men who paid in #currentmembershipyear-1# but have not paid in #currentmembershipyear# (excluding lifetime members):</h2>
</cfoutput>


<table class="table table-striped">
	<tbody>
		<!--- <cfdump var="#people#"><cfabort> --->
	<cfoutput query="people">
			<tr>
			<cfif downloadthis>
				<td>#lname#</td>
				<td>#fname#</td>
			<cfelse>
				<td>#linkto(text="#lname#, #fname#" , controller="handbook-people", action="show", key=id)#</td>
			</cfif>	
			<cfif downloadthis>
				<td>#address1#</td>
				<td>#address2#</td>
			</cfif>	
				<td>#city#</td>
				<td>#state_mail_abbrev#</td>
			<cfif downloadthis>
				<td>#zip#</td>
			</cfif>	
				<td>#mailto(email)#</td>
			<cfif !downloadthis>	
				<td>
					#showTag(id)#
				</td>
			</cfif>	
			<cfif downloadthis>
				<td>

				</td>
			</cfif>
				<cfif len(email)>
					<cfset emailall = emailall & "; " & email>
				</cfif>
				<cfset count = count +1>
	
			</tr>
		
	</cfoutput>
	</tbody>
</table>

<cfset emailall = replace(emailAll,"; ","","once")>

<cfoutput>
	<p>Count:#count#</p>
	<p>Email everyone: #mailto(emailall)#</p>
<cfif not downloadthis>
#linkto(text="<i class='icon-download-alt'></i>", params="download=true", class="tooltipside", title="Download this list as an excel spreadsheet")#
</cfif>
</cfoutput>