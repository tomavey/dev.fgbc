<cfcomponent extends="Controller" output="false">
	
	<cffunction name="config">
		<cfset usesLayout("/forums/layout")>
	</cffunction>

	<cffunction name="list">
		<cfset users = model("forumuser").findAll(where="controller LIKE 'forum%'", order="email,createdat")>
	</cffunction>

</cfcomponent>