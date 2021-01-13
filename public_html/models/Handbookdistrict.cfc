//TODO - Convert to cfscript
<cfcomponent extends="Model" output="false">
	
	<cffunction name="config">
		<cfset table("handbookdistricts")>
		<cfset hasMany(name="Organizations", modelName="Handbookorganization", foreignKey="districtId")>
		<cfset belongsTo(name="Agbmregion", modelName="Handbookagbmregion", foreignKey="agbmregionId", jointype="outer")>
	</cffunction>

</cfcomponent>