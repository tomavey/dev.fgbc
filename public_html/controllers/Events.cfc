<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
		<!---
		<cfset filters(through="logview")>
		--->
	</cffunction>

	<cffunction name="index">
		<cfset setreturn()>
		<cfset events = model("Mainevent").findAll(where="begin > now()", order="begin,end")>
	</cffunction>

	<cffunction name="list">
		<cfset redirectTo("index")>
	</cffunction>

	<cffunction name="json">
		<cfset var events = model("Mainevent").findAll(order="begin,end")>
		<cfset data = queryToJson(events)>
		<cfset renderPage(template="/json", layout="/layout_json", hideDebugInformation=true)>
	</cffunction>
	
</cfcomponent>
