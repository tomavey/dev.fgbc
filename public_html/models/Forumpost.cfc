<cfcomponent extends="Model" output="false">
	
	<cffunction name="init">
		<cfset table("forum_posts")>
		<cfset belongsTo(name="Forumforum", foreignKey="forumId")>
		<cfset hasMany("forumVotes")>
		<cfset property(name="sortorder", defaultValue=999)>
	</cffunction>

</cfcomponent>