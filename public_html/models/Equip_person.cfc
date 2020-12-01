<cfcomponent extends="Model" output="false">

	<cffunction name="config">
		<cfset table("equip_people")>
		<cfset belongsTo(name="equip_family", foreignKey="equip_familiesId")>
	</cffunction>
	
</cfcomponent>
