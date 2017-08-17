<cfcomponent extends="Model" output="false">
	
	<cffunction name="init">
		<cfset table("handbookstatus")>
		<cfset hasMany("handbookOrganizations")>
	</cffunction>

</cfcomponent>