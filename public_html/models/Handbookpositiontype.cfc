<cfcomponent extends="Model" output="false">
	
	<cffunction name="init">
		<cfset Table("handbookpositiontypes")>
		<cfset hasMany(name="Handbookpositions", foreignKey="positiontypeid")>
		<cfset beforeSave("positionTypeRequired")>
		<cfset beforeUpdate("positionTypeRequired")>
	</cffunction>


</cfcomponent>