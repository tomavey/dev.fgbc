//TODO - Convert to cfscript
<cfcomponent extends="Model" output="false">
	
	<cffunction name="config">
		<cfset table("forum_forums")>
		<cfset hasMany("Forumpost")>
		<cfset hasMany("Forumresource")>
	</cffunction>

</cfcomponent>