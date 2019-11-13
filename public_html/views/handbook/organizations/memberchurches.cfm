<cfoutput query="churches">
	#state_mail_abbrev#,#org_city#,#name#: #statNote#<br/>
</cfoutput>
Count = <cfoutput>#churches.recordcount#</cfoutput>