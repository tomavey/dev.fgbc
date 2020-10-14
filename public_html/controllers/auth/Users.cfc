component extends="Controller" output="false" {

	function init(){
		filters(through="isSuperadmin", only="index,indexOld,show,loginAsUser")
		filters(through="setReturn", only="index,indexOld,show,new")
		filters(through="bypassCaptcha", only="new,create")
	}

	private function useOldIndex(){
		return false
	}

	private function bypassCaptcha() {
		bypassCaptcha = true
	} 
	// TODO: need to remove all captcha methods later


<!------------------->
<!-----Basic CRUD---->
<!------------------->

<!--- users/index --->
	public function Xindex(orderByString = "createdAt DESC, lname,fname", whereString = ""){
		var args = arguments
		if ( isDefined('params.orderby') ) { args.orderByString = params.orderBy }
		if ( isDefined('params.search') ) {
			args.whereString = "lname like '%#params.search#%' OR fname like '%#params.search#%' OR username like '%#params.search#%' OR email like '%#params.search#%'"
		} 	
		users = model('Authuser').findAll(where=args.whereString, order=args.orderbyString)
	}

	public function index(orderbyString = "createdAt DESC, lname,fname"){
		var args = arguments
		users = model("Authuser").findAll(order = orderbyString)
		users = queryToJson(data = users, useSerializeJSON = true)
	}

	function search(){
		redirectTo(action="index", params="search=#params.search#")
	}	

<!--- users/show/key --->
	public function show(){
		if ( isDefined("params.key") ) {
			session.temp.key = params.key
			id = params.key
		} else if ( isDefined("params.keyy") ) {
			session.temp.key = params.keyy
			id = params.keyy
		} else if ( isDefined("session.temp.key") ) {
			id= session.temp.key
		}
		params.key = id
		user = model("Authuser").findOne(where="id=#id#")
		groups = model("Authusersgroup").findall(where="auth_usersid = #id#", include="Group")
		allgroups = model("Authgroup").findall(order="name")
		rights = model("Authuser").getRights(id)
		if ( !isObject(user) ) {
			flashInsert(error="User #params.key# was not found")
			redirectTo(action="index")
		}
	}

<!--- users/edit/key --->
	public function edit(id=params.key) {
		if ( !isDefined('params.key') ) { id = session.auth.userid }
		user = model("Authuser").findByKey(id)
		if ( !isObject(user) ) {
			flashInsert(error="User #id# was not found")
			redirectTo(action="index")
		}
	}

<!--- users/new --->
	public function new(){
		user = model("Authuser").new()
		if ( structKeyExists(session.auth,"tempUser") ) {
			structAppend(user,session.auth.tempUser)
		}
		if ( !bypassCaptcha ) {
			strCaptcha = getcaptcha()
		}
		if ( getSetting("requireUserCreateCodeConfirm") ) {
			formAction="confirmCode"
		} else {
			formAction="create"
		}
	}

	public function confirmCode(){
		session.auth.tempUser = params.user
		if ( params.charis != "grace" ) {
			flashInsert(usedEmail='Please answer the "charis" security question')
			returnBack() 
		}
		if ( !isUniqueEmail(params.user.email) ) { 
			flashInsert(usedEmail='We already have a user account with this email. Use a new email or use the "Forgot Password" option to reset.')
			returnBack() 
		}		
		if ( !isUniqueUsername(params.user.username) ) { 
			flashInsert(usedUsername='We already have an account with this username.')
			returnBack() 
		}		
		if ( !isValidAuthCheckCodeInSession() )
			{
				session.auth.tempUser.checkCode = randRange(100000, 999999)
			}
		emailCheckCode(session.auth.tempUser.email, session.auth.tempUser.checkCode)
		formaction = "checkCode"
	}

	public function isUniqueEmail(required string email) {
		if ( !isObject(getUserFromEmail(arguments.email)) ) { return true }
		return false
	}

	public function isUniqueUsername(required string username) {
		if ( !isObject(getUserFromUsername(arguments.username)) ) { return true }
		return false
	}

	public function checkCode(){
		params.user = session.auth.tempUser
		if ( params.user.checkCode IS params.code ) {
			redirectTo(action="create")
		} else {
			flashInsert(error="Try again")
			codeconfirm(params.user)
			renderPage(template="confirmCode")
		}
	}

	private function isValidAuthCheckCodeInSession(){
		return ( isDefined("session.auth.tempUser.checkCode") && val(session.auth.tempUser.checkCode) LTE 999999 && val(session.auth.tempUser.checkCode) GTE 100000 )
	}

	private function emailCheckCode(required string email,required codeToConfirm){
		code = codeToConfirm
		if ( !isLocalMachine() ) {
			sendEmail(template="emailCheckCode", layout="layoutforemail", from=getSetting("userAdminEmailAddress"), to=email, bcc="tomavey@fgbc.org", subject="Your User Account on charisfellowship.us")
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
		if ( !isDefined("params.user") && isDefined("session.auth.tempUser") ) {
			params.user = session.auth.tempUser
			structDelete(session.auth,"tempUser")
		} else {
			renderText("Something went wrong!")
		}
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

<!--- users/update --->
	function update(){
		// ddd(params)
		try {
			user = model("Authuser").findByKey(params.key)
		} catch (any e) {
			user = model("Authuser").findOne(where="token='#params.user.token#'")
			if ( user.update(params.user) ) {
				loginUser(user.username,user.email,user.id,5)
				redirectTo(controller="home", action="index")
			}
		}
		if ( user.update(params.user) ) {
			returnBack(error="The user was updated successfully.")
		} else {
			flashInsert(error="There was an error updating the user.")
			renderPage(action="edit")
		}
	}

<!--- users/delete/key --->
	public function delete(id=params.key){
		user = model("Authuser").findByKey(id)
		groups = model("Authusersgroup").findAll(where="auth_usersid=#id#")
		if ( user.delete() ) {
			model("Authusersgroup").deleteAll(where="auth_usersid=#id#")
			flashInsert(success="The user was deleted successfully.")
			returnBack()
		} else {
			flashInsert(error="There was an error deleting the user.")
			redirectTo(action="index")
		}
	}

<!---End of Basic CRUD--->


<!------------------------------->
<!-----Change Password Methods--->
<!------------------------------->

	public function changePassword(token=params.key){
		user = model("Authuser").findOne(where="token='#arguments.token#'")
		if ( !isObject(user) ) {
			flashInsert(error="Something didn't work correctly. Try again!")
			redirectTo(action="get-email-for-change-password-link", params="forceReset=true")
		} else {
			user.password=""
		}
	}

	public function getEmailForChangePasswordLink(){
		user= model("Authuser").new()
		formaction = "emailChangePasswordLink"
	}

	public function emailChangePasswordLink(){
		users = model("Authuser").findAll(where="email = '#params.user.email#'")
		if ( users.recordcount ) {
			for ( row in users ) {
				model("Authuser").setToken(row.id)
			}
			usersTokens = model("Authuser").findAll(where="email = '#params.user.email#'", reLoad=true)
			if ( usersTokens.recordcount && !isLocalMachine() ) {
				sendEmail(template="emailChangePasswordLink", layout="layoutforemail", from=application.wheels.userAdminEmailAddress, to=users.email, bcc="tomavey@fgbc.org", subject="Your Password on charisfellowship.us")
				renderPage(action="emailSent")
			} elseIf ( usersTokens.recordcount ) {
				renderPage(action="emailSent")
			} else {
				renderPage(action="tokenNotFound")
			}
		} else {
			renderPage(action="emailNotFound")
		}
	}

	public function emailNotFound(){
		rendertext("Email not found")
	}


<!------------------->
<!---Login Methods--->
<!------------------->

<!---show login form--->
	public function loginform(){
		user = model("Authuser").new()
		// user.return = cgi.HTTP_REFERER
	}

	private function checkLogin(){
		var loc = {}

		// redirectForFBLogin()
		pauseLoginAfterRepeatedFails()

		try {
			if ( isDefined("params.user.username") ) {
				loc.checkUserName = checkUserName('#params.user.username#')
			} else {
				redirectTo(action='loginform')
			}
		} catch (any e) {
			sendLoginErrorNotice(subject="Charisfellowship.us login problem check user name")
			redirectTo(controller="home", action="index")
		}

		try {
			if ( !loc.checkUserName.recordcount ) {
				flashInsert(success="User & Password Not Found")
				redirectTo(action='loginform')
			} elseif ( trim(loc.checkUsername.password) is "encrypted" and loc.checkUserName.encrypted_password is hash(loc.checkUserName.salt&trim(params.user.password),"SHA-256") ) {
				loginuser(username=loc.checkUserName.username, email=loc.checkUserName.email, userid=loc.checkUserName.id, login_method="1")
				returnBack()
			} else {
				flashInsert(success="User & Password Not Found")
				setFailedLoginCount()
				redirectTo(controller="auth.users", action='loginform')
			}
		} catch (any e) {
			sendLoginErrorNotice(subject="Charisfellowship.us login problem at last step")
			redirectTo(controller="home", action="index")			
		}
	}

	public void function loginUser ( 
			required string username,  
			required string email,
			required numeric userid,
			required numeric login_method
			fbid = 0,
			login = true,
			rightslist = "basic"
			) 
	{
		session.auth = arguments

		//Record last login method to user table
		model("Authuser").recordLastLoginResults(session.auth.userid,session.auth.login_method)

		//Add rights for user to the session auth rightslist
		rights= model("Authuser").getrights(arguments.userid)
		session.auth.rightslist = session.auth.rightslist & "," & valueList(rights.name)

		//Add group names to the session auth righslist
		groups = model("Authusersgroup").findall(where="auth_usersid = #arguments.userid#", include="Group")
		session.auth.rightslist = session.auth.rightslist & "," & valueList(groups.name)

		//Add handbook rights if email is in the handbook
		if ( emailIsInHandbook(arguments.email) ) {
			session.auth.rightslist = session.auth.rightslist & "," & "handbook,"
		}

		//Add fellowship council page rights if email is tagged for FC
		if ( emailIsInFC(arguments.email) ) {
			session.auth.rightslist = session.auth.rightslist & "fellowshipcouncil,"
		}

		if ( gotRights("superadmin") ) {
			var allgroups = model("Authusersgroup").findall(include="Group")
			session.auth.rightslist = session.auth.rightslist & "," & valueList(allgroups.name)
		}

		//Clean up the rightslist
		session.auth.rightslist = ListSort(session.auth.rightslist,"textnocase")
		session.auth.rightslist = removeDuplicatesFromList(session.auth.rightslist)
		//writeDump(session.auth.rightslist);abort;
	}

	public function logout() {
		structDelete(session,"auth")
		structDelete(session,"params");
		location(url="/", addToken="no")
	}

	private void function pauseLoginAfterRepeatedFails(){
		try {
			var loc = {}
			if  (isDefined("session.auth.failedLoginCount") AND session.auth.failedLoginCount GTE 7 ) {
				loc.milliseconds = (session.auth.failedLoginCount - 7) * 1000
				sleep(loc.milliseconds)
			}
		}	catch (any e) {
			sendLoginErrorNotice(subject="Charisfellowship.us login problem at pause login")
		}
	}

	private void function setFailedLoginCount() {
		if ( isDefined("session.auth.failedLoginCount") ) {
			session.auth.failedLoginCount = session.auth.failedLoginCount + 1
		} else {
			session.auth.failedLoginCount = 1
		}
	}

	private function putInBasicGroup(required numeric userid, groupid=2){
		var userGroup = {}
		var check = model("Authusersgroup").findAll(where="auth_usersId = #arguments.userID# AND auth_groupsId = #arguments.groupId#")
		if ( !check.recordCount ) {
			userGroup = model("Authusersgroup").new()
			userGroup.auth_usersid = arguments.userid
			userGroup.auth_groupsid = arguments.groupid
			usergroup.save()
		}
	}

	private function checkUsername(required string username) {
		var checkUsername = model("Authuser").findAll(where="username = '#arguments.username#'")
		return checkUsername
	}

	private function checkEmailAsUsername(required string email) {
		var checkUsername = model("Authuser").findAll(where="email = '#arguments.email#'")
		return checkUsername
	}

	private void function redirectForFBLogin(){
		try {
			if (isDefined("params.submit") and params.submit is "facebook") {
				redirectTo(action="facebookOAuth")
			}
		} catch (any e) {
			sendLoginErrorNotice(subject="Charisfellowship.us login problem at fb login")
			redirectTo(controller="home", action="index")
		}
	}
	
	private function emailIsInHandbook(required string email){
		try {
			var check = model("Handbookperson").findOne(where="email = '#arguments.email#' OR email2 = '#arguments.email#'", include="State")
			if ( isObject(check) ) {
				return true
			} else {
				return false
			}
		} catch (any e) {
			return false
		}
	}

	private function emailIsInFC(required string email){
		try {
			var check = model("Handbookperson").findOne(where="email = '#arguments.email#' AND tag = 'fc' && username = '#getSetting("superAdminUserName")#'", include="Handbooktags,Handbookstate")
			// writeDump(check);abort;
			if (isObject(check)) { return true }
			else { return false }
		} catch (any e) { return false }
	}

	private function getUserFromEmail (required string email) {
		var user = model("Authuser").findOne(where="email='#arguments.email#'")
		return user
	}

	private function getUserFromUsername (required string username) {
		var user = model("Authuser").findOne(where="username='#arguments.username#'")
		return user
	}

	public function loginAsUser(username=params.username, email=params.email, userid=params.userid) {
		if ( gotRights("superadmin") ) {
			loginUser(username, email, userid,5)
		} else { renderText("You do not have permission to do this?") }
	}

	private void function sendLoginErrorNotice(required string subject) {
		if ( !isLocalMachine() ) {
			sendEmail(from=getSetting("errorEmailAddress"), to=getSettingerrorEmailAddress, template="loginerroremail.cfm", subject=arguments.subject)			
		}
	}

<!------------------------------------->
<!----Adding a user to an auth group--->
<!------------------------------------->

	public function addToGroup( userId=params.key, groupId=params.groupId, username=params.username ) {
		var userGroup
		var check = model("Authusersgroup").findAll(where="auth_usersId = #arguments.userID# AND auth_groupsId = #arguments.groupId#")
		session.temp.key=userId
		if ( !check.recordCount ) {
			userGroup = model("Authusersgroup").new()
			userGroup.auth_usersid = arguments.userid
			userGroup.auth_groupsid = arguments.groupid
			if ( usergroup.save() ) {

				returnBack()			
			} else {
				flashInsert( error="Group was not added to #username#" )
				returnBack()
			}
		}
		flashInsert( error="#username# is already in this group" )
		returnBack()	
	}

	public function removeFromGroup( userId=params.userId, groupId=params.groupId ) {
		user = model( "Authusersgroup" ).deleteAll( where="auth_usersid='#arguments.userid#' AND auth_groupsid='#arguments.groupid#'" )
		returnBack()
	}

<!---------------------->	
<!-----Miscellaneous---->
<!---------------------->	

	public function findDuplicatesByEmail(orderBy="lastLoginAt", direction="ASC") {
		if ( isDefined("params.orderBy") ) { arguments.orderBy=params.orderBy }
		if ( isDefined("params.direction") ) { arguments.direction=params.direction }
		users = model("Authuser").findDuplicatesByEmail(arguments.orderBy, arguments.direction)
	}
	
}


