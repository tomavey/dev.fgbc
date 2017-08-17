<cffunction name="combineEmail">
	<cfargument name="ccemail">
	<cfargument name="familyemail">
	<cfargument name="email">
	<cfset var combinedEmail = "">
	<cfset var set = structNew()>
	<cfset var list = ccemail & "," & familyemail & "," & email>
<cfloop list="#list#" index="i">
	<cfif isValid("email",i)>
		<cfset set[i] = "">	
	</cfif>
</cfloop>
<cfset combinedEmail = structKeyList(set)>
<cfset combinedEmail = ListChangeDelims(combinedEmail,";")>
<cfreturn combinedEmail>	
</cffunction>

<cfinclude template="../helpers.cfm">