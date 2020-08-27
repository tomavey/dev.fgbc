<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset table("fc_nominations")>
		<!--- <cfset property(name="year", defaultValue=year(now()))> --->
		<cfset belongsTo(name="District", modelName="Handbookdistrict", foreignKey="districtID")>
	</cffunction>

	<cffunction name="findAllDistricts">
	<cfset var loc=structNew()>	
		<cfset loc.return = findAll(where ="name <> 'Empty", order="name")>
	<cfreturn loc.return>		
	</cffunction>

</cfcomponent>
