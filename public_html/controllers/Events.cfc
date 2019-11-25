<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
		<!---
		<cfset filters(through="logview", type="after")>
		--->
	</cffunction>

<cfscript>

	public function index() {
		setReturn()
		var whereString = "begin > now()"
		var orderString = "begin,end"
		if (isDefined("params.search")) {
			whereString = whereString & " AND (event LIKE '%#params.search#%' OR sponsor LIKE '%#params.search#%')"
		}
		events = model("Mainevent").findAll(where=whereString, order = orderString)
	} 

</cfscript>	

<cffunction name="list">
		<cfset redirectTo("index")>
	</cffunction>

	<cffunction name="json">
		<cfset var events = model("Mainevent").findAll(order="begin,end")>
		<cfset data = queryToJson(events)>
		<cfset renderPage(template="/json", layout="/layout_json", hideDebugInformation=true)>
	</cffunction>
	
</cfcomponent>
