<cfcomponent extends="Controller" output="false">

	<cffunction name="config">
		<cfset usesLayout(template="/conference/adminlayout")>
	</cffunction>

	<cffunction name="getFolder">
		<cfset var folder = right(getEvent(),4)>
		<cfreturn folder>
	</cffunction>

	<cffunction name="speakers">
		<cfset thispath = replace(cgi.path_translated,"/index.cfm","")>
		<cfset thispath = replace(thispath,"\index.cfm","")>
		<cfset thispath = replace(thispath,"\rewrite.cfm","")>
		<cfset thispath = replace(thispath,"/rewrite.cfm","")>
		<cfset thispath = thispath & "/images/conference/speakers/#getFolder()#/">
		<cfdirectory action="list" directory="#thispath#" name="images" sort="name asc">
	</cffunction>

</cfcomponent>
