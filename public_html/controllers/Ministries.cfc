//TODO - Convert to cfscript
<cfcomponent extends="Controller" output="false">
	<cffunction name="config">
		<cfset filters(through="setReturn", only="show,index")>
	</cffunction>

	<!--- ministries/show/key --->
	<cffunction name="index">
		<cfif isdefined("params.key")>
			<cfset wherestring = "id=#params.key#">
		<cfelseif isDefined("params.category")>
			<cfset params.category = urlDecode(params.category)>	
			<cfset wherestring = "category='#params.category#' AND status <> 'inactive'">
		<cfelse>
			<cfset params.category = "all">
			<cfset wherestring = "status <> 'inactive'">
		</cfif>

    	<cfset ministry = model("Mainministry").findAll(where=whereString, order="category,sortorder,name")>
    	<cfset categories = model("Mainministry").findAll(where="category <> 'none'", order="category,name")>

	</cffunction>

</cfcomponent>
