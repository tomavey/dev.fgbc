<cffunction name="getlist">
<cfargument name="field" required="yes"> 
<cfset var responses = "">
<cfset var list="">
	<cfquery datasource="#dsn#" name="list">
		select #field# as conference
		from cel_survey_10
	</cfquery>
	<cfset responses = "">
	<cfloop query="list">
	<cfif conference is not "">
	<cfset responses = responses & "," & conference>
	</cfif>
	</cfloop>
	<cfset responses = replace(responses,",","","1")>
<cfreturn responses>
</cffunction>			

<cfoutput>#getlist(field="OTHERCONFERENCE")#</cfoutput>
