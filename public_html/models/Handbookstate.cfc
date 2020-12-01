<cfcomponent extends="Model" output="false">

	<cffunction name="config">
		<cfset Table("handbookstates")>
		<cfset hasMany(name="Handbookpeople")>
		<cfset hasMany(name="Handbookorganizations", foreignKey="stateid")>
	</cffunction>

</cfcomponent>