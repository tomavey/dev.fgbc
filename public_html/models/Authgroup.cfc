<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset table(name="auth_groups")>
		<cfset hasMany(name="Groupsright", model="Authgroupsright", shortcut="rights", foreignKey="auth_groupsId")>
		<cfset nestedProperties(
            associations="Groupsright",
            allowDelete=true
        )>

	</cffunction>

</cfcomponent>
