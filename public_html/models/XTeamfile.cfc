<cfcomponent extends="Model" output="false">

	<cffunction name="config">
		<cfset uploadableFile(property="file")>
		<cfset belongsTo(name="Teamteam", foreignKey="teamid")>
	</cffunction>

</cfcomponent>
