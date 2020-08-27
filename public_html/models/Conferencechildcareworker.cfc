<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset belongsTo(modelName="Handbookstate", name="state", foreignKey="stateid", joinType="outer")>
		<cfset table("equipchildcareworkers")>
	</cffunction>

</cfcomponent>
