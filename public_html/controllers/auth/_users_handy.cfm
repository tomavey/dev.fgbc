	<cffunction name="handylogin">
	<cfargument name="email" default="#params.email#">
		<cfset data = model("Authuser").handylogin(arguments.email)>
		<cfif isJson(data)>
			<cfset loginUserFromJson(data)>
		</cfif>
		<cfset renderPage(layout="/layout_json", template="json", hideDebugInformation=true)>
	</cffunction>

	<cffunction name="loginUserFromJson">
	<cfargument name="userAsJson" required="true" type="string">
	<cfset var loc = structNew()>
	<cfset loc = arguments>
		<cfset loc.data = deserializeJson(loc.userAsJson)>
		<cfset loc = loc.data[1]>
		<cfset loginUser(loc.username, loc.email, loc.id,1)>
		<cfset session.auth.rightslist = "basic,handbook">
	</cffunction>

	<cffunction name="handysessionauth">
		<cfif structKeyExists(session,"auth")>
			<cfset data = model("Authuser").handysessionauth(session.auth)>
		<cfelse>
			<cfset data= '[{"rightslist":"","login_method":"0","username":"","email":"","passedstring":"","userid":"","fbid":"","login":"false"}]'>
		</cfif>
		<cfset renderPage(layout="/layout_json", template="json", hideDebugInformation=true)>
	</cffunction>

	<cffunction name="handyAuthenticate">
		<cfset data = model("Authuser").handyAuthenticate(params.email)>
		<cfset renderPage(layout="/layout_json", template="json", hideDebugInformation=true)>
	</cffunction>

	<cffunction name="handyLogout">
		<cfset structDelete(session,"auth")>
		<cfabort>
		<cfset data = '{"return","true"}'>
		<cfset renderPage(layout="/layout_json", template="json", hideDebugInformation=true)>
	</cffunction>
