<cfcomponent extends="Model" output="false">
	
	<cffunction name="init">
		<cfset table("forum_forums")>
		<cfset hasMany("Forumpost")>
		<cfset hasMany("Forumresource")>
	</cffunction>

</cfcomponent>