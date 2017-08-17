<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset table("auth_groupsrights")>
		<cfset belongsto(modelName="Authgroup", name="Group", foreignKey="auth_groupsId")>
		<cfset belongsto(modelName="Authright", name="Right", foreignKey="auth_rightsId")>
	</cffunction>

</cfcomponent>
