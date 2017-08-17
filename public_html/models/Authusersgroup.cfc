<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset table("auth_usersgroups")>
		<cfset belongsTo(name="Group", modelName="auth_groups", foreignKey="auth_groupsid")>
		<cfset belongsTo(name="User", foreignKey="auth_usersid")>
		<cfset hasMany(name="Groupsright", foreignKey="auth_groupsid")>
	</cffunction>

</cfcomponent>
