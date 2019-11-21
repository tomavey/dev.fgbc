<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset belongsTo(name="Teamteam", foreignKey="teamid")>
		<cfset belongsTo(name="Teamtab", foreignKey="tabid")>
	</cffunction>

</cfcomponent>
