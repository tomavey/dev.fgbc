<cfcomponent extends="Model" output="false">
	
	<cffunction name="config">
		<cfset table("forum_votes")>
		<cfset belongsTo(name="Forumpost", foreignkey="postId")>
		<cfset belongsTo(name="Forumvotetype", foreignkey="votetypeId")>
	</cffunction>

</cfcomponent>