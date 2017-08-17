<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset table("equip_registrations")>
		<cfset belongsTo(name="equip_person", foreignKey="equip_peopleid")>
		<cfset belongsTo(name="equip_options", foreignKey="equip_optionsid")>
	</cffunction>
	
</cfcomponent>
