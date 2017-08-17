<cfcomponent extends="Model" output="false">
	
	<cffunction name="init">
		<cfset table("handbookdistricts")>
		<cfset hasMany(name="Organizations", modelName="Handbookorganization", foreignKey="districtId")>
		<cfset belongsTo(name="Agbmregion", modelName="Handbookagbmregion", foreignKey="agbmregionId", jointype="outer")>
	</cffunction>

</cfcomponent>