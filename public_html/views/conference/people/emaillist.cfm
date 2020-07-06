<cfset count = 0>

<cfif isDefined("params.key") and params.key is "download">
<cfelse>
	<cfoutput>#linkto(text="Download as excel", key="download")#</cfoutput>
</cfif>

<table>
	<tr>
		<td>
			Name
		</td>
		<td>
			Email
		</td>
	</tr>

<cfoutput query="emailList">
	<tr>
		<td>
			#name#
		</td>

		<td>
			#email#	
		</td>
	</tr>
	<cfset count = count +1>
</cfoutput>
</table>
<cfoutput>Count = #count#</cfoutput>