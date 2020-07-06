<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset hasMany(name='people', modelName="Conferenceperson", foreignKey='age', joinType='outer')>
		<cfset table("equip_age_ranges")>
	</cffunction>

</cfcomponent>
