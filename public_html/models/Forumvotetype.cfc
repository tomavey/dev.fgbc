<cfcomponent extends="Model" output="false">


	<cffunction name="config" access="public" output="false" returntype="void">
		<cfset table("forum_votetypes")>	
		<cfset hasMany("Forumvotes")>	
	</cffunction>

</cfcomponent>