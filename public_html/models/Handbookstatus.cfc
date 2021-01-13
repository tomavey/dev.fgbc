//TODO - Convert to cfscript
<cfcomponent extends="Model" output="false">
	
	<cffunction name="config">
		<cfset table("handbookstatus")>
		<cfset hasMany("handbookOrganizations")>
	</cffunction>

</cfcomponent>