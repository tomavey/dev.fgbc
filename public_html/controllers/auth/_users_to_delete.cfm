

<!--------------->
<!---I think these can be deleted --->

<cffunction name="XfindDuplicatesByEmail">
	<cfset users = model("Authuser").findDuplicatesByEmail()>
</cffunction>

<cffunction name="Xcleartoken">
	<cfset count = model("Authuser").clearToken(139)>
	<cfdump var='#count#'><cfabort>
</cffunction>

<cffunction name="Xgetpassword">
	<cfif isDefined("params.encrypt")>
		<cfset usersold = model("Authuser").findall(where="password <> 'encrypted'", maxrows="300")>
		<cfloop query="usersold">
			<cftry>
				<cfset dpassword = decrypt(password,getSetting("passwordkey"),"CFMX_COMPAT","Hex")>
				<cfcatch>
					<cftry>
						<cfset dpassword=decrypt(password,getSetting("passwordkey"))>
						<cfcatch>
							<cfset dpassword = password>
						</cfcatch>
					</cftry>
				</cfcatch>
			</cftry>
			<cfset user = model("Authuser").findOne(where="id=#id#")>
			<cfset user.password = dpassword>
			<cfset user.save()>
		</cfloop>
	</cfif>
	<cfset users = model("Authuser").findall()>
</cffunction>

<cffunction name="XaddToGroup">
	<cfargument name="userId" default='#params.key#'>
	<cfargument name="groupId" default='#params.groupid#'>
		<cfset check = model("Authusersgroup").findAll(where="auth_usersId = #arguments.userID# AND auth_groupsId = #arguments.groupId#")>
		<cfif not check.recordcount>
			<cfset userGroup = model("Authusersgroup").new()>
			<cfset userGroup.auth_usersid = arguments.userid>
			<cfset userGroup.auth_groupsid = arguments.groupid>
			<cfif usergroup.save()>
				<cfset returnBack()>
			</cfif>
				<cfset returnBack()>
		</cfif>
				<cfset returnBack()>
	</cffunction>

	<cffunction name="XremoveFromGroup">
	<cfargument name="userId" default='#params.userid#'>
	<cfargument name="groupId" default='#params.groupid#'>

		<cfset user = model("Authusersgroup").deleteAll(where="auth_usersid='#arguments.userid#' AND auth_groupsid='#arguments.groupid#'")>

		<cfset returnBack()>
	</cffunction>

	<cffunction name="XchangePassword">
		<!--- Find the record --->
    	<cfset user = model("Authuser").findOne(where="token='#params.key#'")>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(user)>
	        <cfset flashInsert(error="Something didn't work correctly. Try again!")>
			<cfset redirectTo(action="get-email-for-change-password-link", params="forceReset=true")>
		<cfelse>
			<cfset user.password="">
	    </cfif>

	</cffunction>

	<cffunction name="XgetEmailForChangePasswordLink">
		<cfset user= model("Authuser").new()>
	</cffunction>

	<cffunction name="XemailChangePasswordLink">
		<!---find all user accounts that use this email address--->
		<cfset users = model("Authuser").findAll(where="email = '#params.user.email#'")>

		<!---If there are any, proceed, if not show an emailnotfound message--->
		<cfif users.recordcount>

			<!---Reset tokens if needed--->
			<cfloop query="users">
				<cfset model("Authuser").setToken(id)>
			</cfloop>

			<!---Gather all the tokens as a query--->
			<cfset usersTokens = model("Authuser").findAll(where="email = '#params.user.email#'", reLoad=true)>

			<!---Send email links to reset password for each token--->
			<cfif usersTokens.recordcount>
				<cfset sendEmail(template="emailChangePasswordLink", layout="layoutforemail", from=application.wheels.userAdminEmailAddress, to=users.email, bcc="tomavey@fgbc.org", subject="Your Password on charisfellowship.us")>
				<cfif isLocalMachine()>
				<cfelse>
					<cfset renderPage(action="emailSent")>
				</cfif>
			<cfelse>
				<cfset renderPage(action="tokenNotFound")>
			</cfif>
		<cfelse>
			<cfset renderPage(action="emailNotFound")>
		</cfif>
	</cffunction>

	<cffunction name="XemailNotFound">
		<cfset rendertext("Email not found")>
	</cffunction>

	<cffunction name="XputInBasicGroup">
	<cfargument name="userId" required="true" type="numeric">
	<cfargument name="groupId" default="2">
		<cfset check = model("Authusersgroup").findAll(where="auth_usersId = #arguments.userID# AND auth_groupsId = #arguments.groupId#")>
		<cfif not check.recordcount>
			<cfset userGroup = model("Authusersgroup").new()>
			<cfset userGroup.auth_usersid = arguments.userid>
			<cfset userGroup.auth_groupsid = arguments.groupid>
			<cfset usergroup.save()>
		</cfif>
	</cffunction>


