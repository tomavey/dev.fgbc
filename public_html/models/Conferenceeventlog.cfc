<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset table("equip_eventlogs")>
		<cfset belongsTo(name="Event", modelName="Event", foreignKey="recordId")>
	</cffunction>

</cfcomponent>
