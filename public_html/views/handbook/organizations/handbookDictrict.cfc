<cfcomponent extends="Model" output="false">
	
	<cffunction name="init">
		<cfset table("handbook_districts")>
		<cfset hasMany("handbookOrganization")>
	</cffunction>

</cfcomponent>