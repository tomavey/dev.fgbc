<cfoutput query="churches">
	#state_mail_abbrev#,#org_city#,#name#: #$addStatNote(id)# <cfif hasNoStaff(id)>*NoStaff Listed*</cfif><br/>
</cfoutput>
Count = <cfoutput>#churches.recordcount#</cfoutput>