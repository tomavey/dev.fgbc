//TODO - Convert to cfscript
<cfcomponent extends="Model" output="false">

	<cffunction name="config">
		<cfset table("equip_users_families")>
		<cfset belongsTo(name="auth_users", modelName="auth_user", foreignKey="userid")>
		<cfset belongsTo(name="families", modelName="Conferencefamily", foreignKey="familyid", joinType="outer")>
	</cffunction>

<!---
	<cffunction name="findAllFamiliesRegs">
	<cfargument name="userid" required="true" type="numeric">
	<cfset var loc = structNew()>
	<cfset loc = arguments>
		<cfset loc.familyregs = findAll(where="userid=#loc.userid#", include="familes(people)")>
	</cffunction>
--->

</cfcomponent>
