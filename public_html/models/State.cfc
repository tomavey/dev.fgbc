<cfcomponent extends="Model" output="false">
	
	<cffunction name="config">
		<cfset table(name="state")>
		<cfset property(name="id", column="stateid")>
		<cfset hasMany("churches")>
	</cffunction>

</cfcomponent>