<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset table("church")>
		<cfset property(name="id", column="churchid")>
		<cfset belongsTo(name="state", foreignKey="stateid")>
	</cffunction>
	
	<cffunction name="getDbInfo">
	<cfargument name="table" required="true" type="string">	
		<cfquery datasource="#application.wheels.datasourcename#" name="dbinfo">
			SHOW columns
			FROM #arguments.table#
		</cfquery>
		<cfreturn dbinfo>
	</cffunction>

</cfcomponent>
