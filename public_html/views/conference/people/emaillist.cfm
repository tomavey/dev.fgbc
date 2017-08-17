<cfset count = 0>
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