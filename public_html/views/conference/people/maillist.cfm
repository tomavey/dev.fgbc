<cfif isDefined("params.key") and params.key is "download">
<cfelse>
	<cfif isDefined("params.regonly")>
		<cfoutput>#linkto(text="Download as excel", key="download", params="regonly=true")#</cfoutput>
	<cfelse>
		<cfoutput>#linkto(text="Download as excel", key="download")#</cfoutput>
	</cfif>
</cfif>
<cfif isDefined("params.regonly")>
	<cfoutput>#linkto(text="All", params="")#</cfoutput>
<cfelse>
	<cfoutput>#linkto(text="Regs Only (do not include handbook people and churches)", params="regonly=true")#</cfoutput>
</cfif>	

<table>
	<tr>
		<td>
			Name
		</td>
	<cfif isDefined("params.regonly")>
		<td>
			Last Name
		</td>
		<td>
			First Name
		</td>
	</cfif>		
		<td>
			Address
		</td>
		<td>
			City
		</td>
		<td>
			State
		</td>
		<td>
			Zip
		</td>
		<td>
			Email
		</td>
	</tr>

<cfoutput query="distinctemail">
	<tr>
		<td>
			#name#
		</td>

	<cfif isDefined("params.regonly")>
		<td>
			#lname#
		</td>
		<td>
			#fname#
		</td>
	</cfif>		
		<td>
			#address#
		</td>
		<td>
			#city#
		</td>
		<td>
			#state_mail_abbrev#
		</td>
		<td>
			#zip#	
		</td>
		<td>
			#email#	
		</td>
	</tr>
	<cfset count = count +1>
</cfoutput>
</table>
<cfoutput>Count = #count#</cfoutput>