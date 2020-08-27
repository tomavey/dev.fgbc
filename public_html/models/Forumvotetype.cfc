<cfcomponent extends="Model" output="false">


	<cffunction name="init" access="public" output="false" returntype="void">
		<cfset table("forum_votetypes")>	
		<cfset hasMany("Forumvotes")>	
	</cffunction>

</cfcomponent>