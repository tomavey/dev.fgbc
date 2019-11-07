<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset table("auth_groupsrights")>
		<cfset belongsTo(modelName="Authgroup", name="Group", foreignKey="auth_groupsId")>
		<cfset belongsTo(modelName="Authright", name="Right", foreignKey="auth_rightsId")>
	</cffunction>

</cfcomponent>
