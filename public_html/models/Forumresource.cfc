<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset uploadableFile(property="file")>
		<cfset belongsTo(name="Forumforum", foreignKey="forumid")>
	</cffunction>

</cfcomponent>
