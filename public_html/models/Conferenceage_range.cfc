//TODO - Convert to cfscript
<cfcomponent extends="Model" output="false">

	<cffunction name="config">
		<cfset hasMany(name='people', modelName="Conferenceperson", foreignKey='age', joinType='outer')>
		<cfset table("equip_age_ranges")>
	</cffunction>

</cfcomponent>
