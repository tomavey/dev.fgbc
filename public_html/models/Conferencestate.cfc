<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset setTableNamePrefix("")> 
		<cfset table('handbookstates')>
		<cfset hasMany(name="families", modelName="Conferencefamily")>
	</cffunction>
	
</cfcomponent>
