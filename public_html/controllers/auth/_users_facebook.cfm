<!---Used for facebook login--->

	<cffunction name="createOauthState">
		<cfset cookie.state = createUUID()>
		<cfset session.state = createUUID()>
		<cfset application.state = createUUID()>
	</cffunction>

	<cffunction name="getOauthState">
	<cfset var state = "">
		<cfif structKeyExists(session,"state")>
			<cfreturn session.state>
		<cfelseif structKeyExists(cookie,"state")>
			<cfreturn cookie.state>
		<cfelseif structKeyExists(application,"state")>
			<cfreturn application.state>
		<cfelse>
			<cfreturn "None">
		</cfif>
	</cffunction>

	<cffunction name="facebookOAuth">
		<cfset createOauthState()>
		<cflocation url="https://www.facebook.com/dialog/oauth?client_id=#application.fbappid#&redirect_uri=#application.fbredirecturl#&state=#getOauthState()#&scope=email" addtoken="false">
	</cffunction>

	<cffunction name="getFbaccesstoken">
	<cfset var loc=structNew()>
	<cfset loc.noaccess = "noaccess">

	<cftry>
		<cfif isDefined("params.code") and params.state is getOauthState()>
			<cfset session.fbcode = params.code>

			<cfhttp url="https://graph.facebook.com/oauth/access_token?client_id=#application.fbappid#&redirect_uri=#urlEncodedFormat(application.fbredirecturl)#&client_secret=#application.fbsecret#&code=#session.fbcode#">

			<cfif findNoCase("access_token=", cfhttp.filecontent)>
				<cfset loc.parts = listToArray(cfhttp.filecontent, "&")>
				<cfset loc.at = loc.parts[1]>
				<cfset loc.fbaccesstoken = listGetAt(loc.at, 2, "=")>
				<cfreturn loc.fbaccesstoken>
			<cfelseif isDefined("params.error_reason")>
				<cfset loc.error_message = "">
				<cfif isDefined("params.error_reason")>
					<cfset loc.error_message = loc.error_message & params.error_reason & "<br/>">
				</cfif>
				<cfif isDefined("params.error_description")>
					<cfset loc.error_message = loc.error_message & params.error_description & "<br/>">
				</cfif>

				<cfset flashInsert(facebookfail = loc.error_message)

			<cfelse>
				<cfset flashInsert(facebookfail = "Oops, Something went wrong!")>
				<cfreturn "#loc.noaccess#">
			</cfif>

		<cfelse>
			<cfset flashInsert(facebookfail = "Oops, Something went wrong!")>
			<cfreturn "#loc.noaccess#">
		</cfif>

		<cfcatch>
			<cfset session.fblogin = false>
			<cfset redirectTo(controller="home", action="index")>
		</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="facebookLogin">

	<cftry>

			<cfset session.fbaccesstoken = getFbaccesstoken()>

			<cfset session.fbAPI = createObject("component","facebook").init(session.fbaccesstoken)>
			<cfset loc = session.fbAPI.getMe()>
			<cfset loc.fbid = session.fbAPI.getMe().id>

			<cfset loc.user = model("Authuser").findOne(where="email='#loc.email#'")>

			<cfif isObject(loc.user)>
				<cfset loc.id = loc.user.id>
			</cfif>

			<cfset loginUser(loc.email,loc.email,loc.id,6,loc.fbid)>

			<cfset returnBack()>

		<cfcatch>
			<cfset session.auth.fblogin = false>
			<cfset redirectTo(controller="home", action="index")>
		</cfcatch>
		</cftry>

	</cffunction>

<!---End of facebook login methods--->	