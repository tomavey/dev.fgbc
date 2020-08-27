<cfcomponent extends="Controller" output="false">
	
	<cffunction name="index">
		<cfset blogs = model("Mainblog").findAll(where="active='yes'", order="createdAt DESC")>
		<cfif isdefined("url.items")>
			<cfset nitems = url.items>
		<cfelse>
			<cfset nitems = 4>
		</cfif>
	</cffunction>

	<cffunction name="list">
		<cfset redirectTo("index")>
	</cffunction>
	
</cfcomponent>
