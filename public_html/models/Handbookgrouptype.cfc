<cfcomponent extends="Model" output="false">
	
	<cffunction name="init">
		<cfset table("handbookgrouptypes")>
		<cfset hasMany("handbookGroups")>
	</cffunction>

</cfcomponent>