<cfcomponent extends="Model" output="false">

	<cffunction name="config">
		<cfset setTableNamePrefix("")> 
		<cfset table('handbookstates')>
		<cfset hasMany(name="families", modelName="Conferencefamily")>
	</cffunction>
	
</cfcomponent>
