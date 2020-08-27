<cfparam name="users" type="query">
<table>

<cfoutput query="users">
<tr>
	<td>#left(password,"20")#</td>
	<td>
		<cftry>
			<cfset dpassword = decrypt(password,getSetting("passwordkey"),"CFMX_COMPAT","Hex")>
		<cfcatch>
		<cftry>
			<cfset dpassword=decrypt(password,getSetting("passwordkey"))>
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