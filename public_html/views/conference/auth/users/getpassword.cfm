<cfparam name="users" type="query">
<table>

<cfoutput query="users">
<tr>
	<td>#left(password,"20")#</td>
	<td>
		<cftry>
			<cfset dpassword = decrypt(password,application.wheels.passwordKey,"CFMX_COMPAT","Hex")>
		<cfcatch>
		<cftry>
			<cfset dpassword=decrypt(password,application.wheels.passwordKey)>
			<cfcatch>
				<cfset dpassword = password>
			</cfcatch>
		</cftry>
		</cfcatch>	
		</cftry>	
		#dpassword#
	</td>
</tr>	
</cfoutput>

</table>