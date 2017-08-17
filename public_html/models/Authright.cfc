<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset table("auth_rights")>
		<cfset hasMany(name="Groupsright", modelName="Authgroup", foreignKey="auth_rightsId")>
	</cffunction>

</cfcomponent>
