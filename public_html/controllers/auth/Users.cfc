<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
		<cfset filters(through="isSuperadmin", only="index,indexOld,show,loginAsUser")>
		<cfset filters(through="setReturn", only="index,indexOld,show")>
		<cfset filters(through="bypassCaptcha", only="new,create")>
	</cffunction>

<cfscript>
	private function useOldIndex(){
		return false
	}

	private function bypassCaptcha() {
		bypassCaptcha = true
	}

</cfscript>	

<!---Basic CRUD--->

	<!--- users/index --->
	<cffunction name="index">
		<cfargument name="orderby" default="createdAt DESC, lname,fname">
		<cfset var loc = arguments>
		<cfparam name="params.page" default="1">
		<cfparam name="params.maxPages" default="30">

		<cfif isDefined("params.orderby")>
			<cfset loc.orderby = params.orderby>
		</cfif>

		<cfif isDefined("params.search")>
			<cfset users = model("Authuser").findAll(where="lname like '%#params.search#%' OR fname like '%#params.search#%' OR username like '%#params.search#%' OR email like '%#params.search#%'", order="lname,fname", page=params.page, perPage=params.maxPages)>
		<cfelse>
			<!--- <cfset users = model("Authuser").findAll(order=loc.orderby, page=params.page, perPage=params.maxPages)> --->
			<cfset users = model("Authuser").findAll(order=loc.orderby)>
		</cfif>
		<!--- <cfset params.lastpage = pagination().totalpages> --->

		<cfif isdefined("params.page") AND params.page GT 1>
			<cfset params.previousPage = params.page - 1>
		<cfelse>
			<cfset params.previousPage = 0>
		</cfif>

	<!---
		<cfif isdefined("params.page") AND params.page lt params.lastpage>
			<cfset params.nextPage = params.page + 1>
		<cfelse>
			<cfset params.nextPage = 0>
		</cfif>
	--->

	</cffunction>

<cfscript>
	function Xindex(orderbyString = "createdAt DESC, lname,fname"){
			var args = arguments
			users = model("Authuser").findAll(order = orderbyString)
			users = serializeJSON(users, "struct")
		}
</cfscript>	

	<cffunction name="search">
		<cfset redirectTo(action="index", params="search=#params.search#")>
	</cffunction>

	<!--- users/show/key --->
	<cffunction name="show">
		<!--- Find the record --->
    	<cfset user = model("Authuser").findOne(where="id=#params.key#")>
		<cfset groups = model("Authusersgroup").findall(where="auth_usersid = #params.key#", include="Group")>
		<cfset allgroups = model("Authgroup").findall(order="name")>
		<cfset rights = model("Authuser").getRights(params.key)>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(user)>
	        <cfset flashInsert(error="User #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>
	</cffunction>

	<!--- users/new --->
<cfscript>
	public function new(){
		if ( getSetting("requireUserCreateCode") ) {
			formAction="codeConfirm"
		} 
		user = model("Authuser").new()
		if ( !bypassCaptcha ) {
			strCaptcha = getcaptcha()
		}
	}
</cfscript>	

	<!--- users/edit/key --->
	<cffunction name="edit">

		<cfif not isDefined("params.key")>
			<cfset params.key = session.auth.userid>
		</cfif>

		<!--- Find the record --->
    	<cfset user = model("Authuser").findByKey(params.key)>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(user)>
	        <cfset flashInsert(error="User #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

<cfscript>
	public function codeconfirm(){		
		session.auth.tempUser = params.user
		if ( !isValidAuthCheckCodeInSession() )
			{
				session.auth.tempUser.checkCode = randRange(100000, 999999)
			}
		emailCheckCode(session.auth.tempUser.email, session.auth.tempUser.checkCode)
		formaction = "checkCode"
	}

	private function isValidAuthCheckCodeInSession(){
		return ( isDefined("session.auth.tempUser.checkCode") && val(session.auth.tempUser.checkCode) LTE 999999 && val(session.auth.tempUser.checkCode) GTE 100000 )
	}

	private function emailCheckCode(required string email,required string code){
		if ( !isLocalMachine() ) {
			sendEmail(template="emailCheckCode", layout="layoutforemail", from=getSetting("userAdminEmailAddress"), to=email, bcc="tomavey@fgbc.org", subject="Your User Account on charisfellowship.us")
		}
	}

	public function checkCode(){
		params.user = session.auth.tempUser
		if ( session.auth.checkCode IS params.code ) {
			structDelete(session.auth,"tempUser")
			create(params.user)
		} else {
			flashInsert(error="Try again")
			codeconfirm(params.user)
			renderPage(template="codeconfirm")
		}
	}

	private function checkCaptcha(){
		if ( bypassCaptcha ) { return true }
		strCaptcha = getcaptcha()
		if ( len(params.captcha) AND params.captcha is decrypt(params.captcha_check,getSetting("passwordkey"),"CFMX_COMPAT","HEX") ) {
			return true
		} else {
			flashInsert(error="Please try to enter the scrambled image again.")
			user = model("Authuser").new(params.user)
			strCaptcha = getcaptcha()
			return false
		}
	}

	<!--- users/create --->
	public function create(){
		user = model("Authuser").new(params.user)
		if ( user.save() ) {
			putInBasicGroup(user.id)
			flashInsert(success="The user was created successfully.")
			loginUser(user.username,user.email,user.id,5)
			redirectTo(action="thankYou")
		} else {
			flashInsert(error="There was an error creating the user.")
			renderPage(action="new")
		}
	}
</cfscript>


	<!--- users/update --->
	<cffunction name="update">

		<cftry>
			<cfset user = model("Authuser").findByKey(params.key)>
		<cfcatch>
			<cfset user = model("Authuser").findOne(where="token='#params.user.token#'")>
			<cfif user.update(params.user)>
				<cfset loginUser(user.username,user.email,user.id,5)>
	            <cfset redirectTo(controller="home", action="index")>
		</cfif>
		</cfcatch>
		</cftry>

		<!--- Verify that the user updates successfully --->
		<cfif user.update(params.user)>
			<cfset flashInsert(success="The user was updated successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the user.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>

	<!--- users/delete/key --->
	<cffunction name="delete">
		<cfset user = model("Authuser").findByKey(params.key)>

		<!--- Verify that the user deletes successfully --->
		<cfif user.delete()>
			<cfset flashInsert(success="The user was deleted successfully.")>
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the user.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>

<!---End of Basic CRUD--->

	<cffunction name="changePassword">
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

	<cffunction name="getEmailForChangePasswordLink">
		<cfset user= model("Authuser").new()>
	</cffunction>

	<cffunction name="emailChangePasswordLink">
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

	<cffunction name="emailNotFound">
		<cfset rendertext("Email not found")>
	</cffunction>

	<cffunction name="putInBasicGroup">
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

	<cffunction name="checkUsername">
	<cfargument name="username" required="true" type="string">
		<cfset checkUsername = model("Authuser").findAll(where="username = '#arguments.username#'")>
		<cfreturn checkUserName>
	</cffunction>

	<cffunction name="checkEmailAsUsername">
	<cfargument name="email" required="true" type="string">
		<cfset checkUsername = model("Authuser").findAll(where="email = '#arguments.email#'")>
		<cfreturn checkUserName>
	</cffunction>

<!---Login Methods--->

	<!---show login form--->
	<cffunction name="loginform">
		<cfset user = model("Authuser").new()>
		<!---cfset user.return = cgi.HTTP_REFERER--->
	</cffunction>

	<cffunction name="testcheck">
	testcheck...
	<cfdump var="#params#"><cfabort>
	</cffunction>

	<cffunction name="checklogin">
	<cfset var loc=structnew()>

	<cftry>
		<cfif isDefined("params.submit") and params.submit is "facebook">
			<cfset redirectTo(action="facebookOAuth")>
		</cfif>
	<cfcatch>
		<cfset sendLoginErrorNotice(subject="Charisfellowship.us login problem at fb login")>
		<cfset redirectTo(controller="home", action="index")>
	</cfcatch>
	</cftry>

	<cftry>
		<cfset pauseLogin()>
	<cfcatch>
		<cfset sendLoginErrorNotice(subject="Charisfellowship.us login problem at pause login")>
	</cfcatch>
	</cftry>

	<cftry>
		<cfif isDefined("params.user.username")>
			<cfset loc.checkUserName = checkUserName('#params.user.username#')>
		<cfelse>
			<cfset redirectTo(action='loginform')>
		</cfif>
	<cfcatch>
		<cfset sendLoginErrorNotice(subject="Charisfellowship.us login problem check user name")>
		<cfset redirectTo(controller="home", action="index")>
	</cfcatch>
	</cftry>

	<cftry>
		<cfif not loc.checkUserName.recordcount>
			<cfset flashInsert(success="User Not Found")>
			<cfset redirectTo(action='loginform')>
		<!---1-Login using salted and hashed password--->
		<cfelseif trim(loc.checkUsername.password) is "encrypted" and loc.checkUserName.encrypted_password is hash(loc.checkUserName.salt&trim(params.user.password),"SHA-256")>
			<cfset loginuser(username=loc.checkUserName.username, email=loc.checkUserName.email, userid=loc.checkUserName.id, login_method="1")>
			<cfset returnBack()>

		<cfelse>
			<cfset flashInsert(success="User Not Found")>
			<cfset setFailedLoginCount()>
			<cfset redirectTo(controller="auth.users", action='loginform')>
		</cfif>
	<cfcatch>
		<cfset sendLoginErrorNotice(subject="Charisfellowship.us login problem at last step")>
		<cfset redirectTo(controller="home", action="index")>
	</cfcatch>
	</cftry>
	</cffunction>

	<cffunction name="loginUser">
	<cfargument name="username" required="true" type="string">
	<cfargument name="email" required="true" type="string">
	<cfargument name="userid" required="true" type="numeric">
	<cfargument name="login_method" required="true" type="numeric">
	<cfargument name="fbid" default="0">
		<cfset session.auth.login = true>
		<cfset session.auth.username = arguments.username>
		<cfset session.auth.email = arguments.email>
		<cfset session.auth.userid = arguments.userid>
		<cfset session.auth.fbid = arguments.fbid>
		<cfset session.auth.login_method = arguments.login_method>
		<cfset session.auth.rightslist = "basic">
		<cfset model("Authuser").recordLastLoginResults(session.auth.userid,session.auth.login_method)>
		<cfset rights= model("Authuser").getrights(arguments.userid)>
		<cfloop query="rights">
			<cfset session.auth.rightslist = name & "," & session.auth.rightslist>
		</cfloop>
		<cfset groups = model("Authusersgroup").findall(where="auth_usersid = #arguments.userid#", include="Group")>
		<cfloop query="groups">
			<cfset session.auth.rightslist = name & "," & session.auth.rightslist>
		</cfloop>
		<cfif emailIsInHandbook(arguments.email)>
			<cfset session.auth.rightslist = session.auth.rightslist & "handbook,">
		</cfif>

		<cfif emailIsInFC(arguments.email)>
			<cfset session.auth.rightslist = session.auth.rightslist & "fellowshipcouncil,">
		</cfif>

		<cfset session.auth.rightslist = ListSort(session.auth.rightslist,"text")>
		<cfset session.auth.rightslist = removeDuplicatesFromList(session.auth.rightslist)>
		<cfset session.auth.rightslist = replace(session.auth.rightslist,",","","one")>

	</cffunction>

	<cffunction name="setFailedLoginCount">
		<cfif isDefined("session.auth.failedLoginCount")>
			<cfset session.auth.failedLoginCount = session.auth.failedLoginCount + 1>
		<cfelse>
			<cfset session.auth.failedLoginCount = 1>
		</cfif>
	</cffunction>

	<cffunction name="emailIsInHandbook">
	<cfargument name="email" required="true" type="string">
	<cfset var loc = structNew()>
	<cftry>
		<cfset loc.check = model("Handbookperson").findOne(where="email = '#arguments.email#' OR email2 = '#arguments.email#'", include="State")>
			<cfif isObject(loc.check)>
				<cfreturn true>
			<cfelse>
				<cfreturn false>
			</cfif>
		<cfcatch>
			<cfreturn false>
		</cfcatch>
	</cftry>
	</cffunction>

	<cffunction name="emailIsInFC">
	<cfargument name="email" required="true" type="string">
	<cfset var loc = structNew()>
	<cftry>
		<cfset loc.check = model("Handbookperson").findOne(where="email = '#arguments.email#' AND tag = 'fc'", include="Handbooktags,Handbookstate")>
			<cfif isObject(loc.check)>
				<cfreturn true>
			<cfelse>
				<cfreturn false>
			</cfif>
		<cfcatch>
			<cfreturn false>
		</cfcatch>
	</cftry>
	</cffunction>

	<cffunction name="getUserFromEmail">
	<cfargument name="email" required="true" type="string">
		<cfset var user = model("Authuser").findOne(where="email='#arguments.email#'")>
	<cfreturn user>
	</cffunction>

	<cffunction name="loginAsUser">
		<cfif gotRights("superadmin")>
		<cfset structDelete(session,"auth")>
		<cfset loginUser(params.username, params.email, params.userid,5)>
		</cfif>
	</cffunction>

	<cffunction name="logout">
		<cfset structDelete(session,"auth")>
		<cflocation url="/" addToken="no">
	</cffunction>

	<cffunction name="addToGroup">
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

	<cffunction name="removeFromGroup">
	<cfargument name="userId" default='#params.userid#'>
	<cfargument name="groupId" default='#params.groupid#'>

		<cfset user = model("Authusersgroup").deleteAll(where="auth_usersid='#arguments.userid#' AND auth_groupsid='#arguments.groupid#'")>

		<cfset returnBack()>
	</cffunction>

	<cffunction name="getpassword">
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

	<cffunction name="cleartoken">
		<cfset count = model("Authuser").clearToken(139)>
		<cfdump var='#count#'><cfabort>
	</cffunction>

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

<!---Used for facebook login--->
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

	<cffunction name="sendLoginErrorNotice">
	<cfargument name="subject"  default="Charis Fellowship Login Error">
		<cfset sendEmail(from=application.wheels.errorEmailAddress, to=application.wheels.errorEmailAddress, template="loginerroremail.cfm", subject=arguments.subject)>
	</cffunction>

<!--------------->

	<cffunction name="findDuplicatesByEmail">
		<cfset users = model("Authuser").findDuplicatesByEmail()>
	</cffunction>

</cfcomponent>
