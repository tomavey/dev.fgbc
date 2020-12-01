<cfcomponent extends="Model" output="false">
	
	<cffunction name="config">
		<cfset table("handbookgrouptypes")>
		<cfset hasMany("handbookGroups")>
	</cffunction>

</cfcomponent>