component extends="Wheels" {

	dsn=getSetting("dataSourceName")

	private function footer(){
		//data function for footer partial called from layout
		var ministries = {}
		ministries.churchPlanting = model("Mainministry").findAll(where="status <> 'inactive' AND category = 'Church Planting Ministries' AND includeInFooter = 'Yes'", order="category,name")
		ministries.leadershipTraining = model("Mainministry").findAll(where="status <> 'inactive' AND category = 'Leadership Training Ministries' AND includeInFooter = 'Yes'", order="category,name")
		ministries.doingGood = model("Mainministry").findAll(where="status <> 'inactive' AND category = 'Doing Good' AND includeInFooter = 'Yes'", order="category,name")
		ministries.communication = model("Mainministry").findAll(where="status <> 'inactive' AND category = 'Communication' AND includeInFooter = 'Yes'", order="category,name")
		return ministries
	}

<!-------------->
<!---CAPTCHA---->
<!-------------->

	function getCaptcha() output=false {
		var arrValidChars = "";
		var strCaptcha = arraynew(1);
		var captchaForm = "";
		/* 
				Create the array of valid characters. Leave out the
				numbers 0 (zero) and 1 (one) as they can be easily
				confused with the characters o and l (respectively).
			*/
		arrValidChars = ListToArray(
				"A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z," &
				"2,3,4,5,6,7,8,9"
				);
		//  Now, shuffle the array. 
		CreateObject(
				"java",
				"java.util.Collections"
				).Shuffle(
					arrValidChars
					);
		/* 
				Now that we have a shuffled array, let's grab the
				first 4 characters as our CAPTCHA text string.
			*/
		strCaptcha = (
				arrValidChars[ 1 ] &
				arrValidChars[ 2 ] &
				arrValidChars[ 3 ] &
				arrValidChars[ 4 ] &
				arrValidChars[ 5 ]
				);
		return strCaptcha;
	}

	function checkCaptcha() {
		if ( len(params.captcha) && params.captcha == decrypt(params.captcha_check,getSetting("passwordkey"),"CFMX_COMPAT","HEX") ) {
			flashInsert(message="Type one adult (ie: 'John''), couple (ie:'John && Jane') || child (ie:'Johnny') on the left then select the appropriate registration options below before click 'Add To Cart'");
			redirectTo(action="selectoptions");
		} else {
			flashInsert(error="Please try again.");
			redirectTo(action="new");
		}
	}

<!------------------>
<!-----SECURITY---->
<!------------------>

	function getKey(required string email) output=false {
		var key="";
		key = encrypt(arguments.email,getSetting("passwordkey"),"CFMX_COMPAT","Hex");
		return key;
	}

<!--------------------------->
<!---AUTHORIZATION METHODS--->
<!--------------------------->

function isSuperadmin() {
	try {
		if ( !listFind(session.auth.rightslist,"superadmin") ) {
			redirectto(controller="home", action="loggedOut");
			abort;
		}
	} catch (any cfcatch) {
		redirectto(controller="home", action="loggedOut");
	}
}

function isOffice() {
	try {
		if ( !gotRights("superadmin,office,handbookedit") ) {
			redirectto(controller="home", action="loggedOut");
			abort;
		}
	} catch (any cfcatch) {
		redirectto(controller="home", action="loggedOut");
	}
}

function gotAgbmRights() {
	if ( !gotRights("superadmin,agbmadmin,agbm") ) {
		renderText("You do !have permission to access the AGBM Membership List");
	}
}

function gotBasicHandbookRights() {
	cfcookie( name="handbookLastRequest_url", value=cgi.request_url );
	if ( isDefined("params.action") && params.action == "sendHandbook" ) {
		return true;
	}
	if ( gotrights("superadmin,office,handbook,agbmadmin") ) {
		return true;
	}
	if ( isdefined("session.auth.email") && userInHandbook() ) {
		return true;
	}
	if ( isdefined("params.email") && userInHandbook(params.email) ) {
		return true;
	}
	if ( isDefined("session.auth.handbook.basic") && session.auth.handbook.basic ) {
		return true;
	}
	try {
		if ( session.auth.handbook.basic || gotrights("superadmin,office,handbook") ) {
			return true;
		} else {
			redirectTo(controller="handbook.welcome", action="checkin");
		}
	} catch (any cfcatch) {
		if ( isDefined("params.route") && params.route == "handbookPerson" ) {
			redirectTo(route="handbookviewperson", key=params.key);
		}
		redirectTo(controller="handbook.welcome", action="checkin");
	}
}

function isPageEditor() {
	if ( gotRights("office,pageEditor,agbm") ) {
		return true;
	} else {
		renderText("You do !have persmission to view this page");
	}
}


function userInHandbook(email="#session.auth.email#") {
	check = model("Handbookperson").findOne(where="email = '#arguments.email#' || email2='#arguments.email#'", include="Handbookstate");
	if ( isObject(check) ) {
		return true;
	} else {
		return false;
	}
}

<!---------------------------------->
<!---END OF AUTHORIZATION METHODS--->
<!---------------------------------->



<!------------------------------>	
<!-------NAVIGATION AIDS-------->	
<!------------------------------>	
	function setReturn() {
		if ( !isDefined("params.ajax") ) {
			if ( params.action == "index" || params.action == "list" ) {
				session.listingURL = $GetCurrentURL();
			}
			session.originalURL = $GetCurrentURL();
		}
	}

	function returnBack(string controller, string action, string error){
		if ( isDefined('arguments.error') ) { flashInsert(error = arguments.error) }
		try {
			var backURL = session.originalURL
			session.originalURL = ""
			IF ( Len(backURL) GT 0 ) {
				location(url="#backURL#", addtoken="false")
			} ELSE {
				redirectTo(argumentCollection=arguments)
			}
		} catch (any e) {
			redirectTo(argumentCollection=arguments)
		}
	}

	public function $GetCurrentURL() output=false {
		var theURL = getPageContext().getRequest().GetRequestUrl();
		if ( len( CGI.query_string ) ) {
			theURL = theURL & "?" & CGI.query_string;
		}
		if ( cgi.http_host == "localhost:8080" || cgi.http_host == "localhost:8888" ) {
		} else {
			try {
				theURL = replace(theUrl,"/rewrite.cfm","","one");
			} catch (any cfcatch) {
			}
		}
		return theURL;
	}
	

	function getActive(required category) {
		//used in layout - nav
		var loc = structNew();
		loc.return = "inactive";
		if ( !structKeyExists(params,"key") && category == "home" ) {
			loc.return = "active";
		} else if ( structKeyExists(params,"key") && params.key == arguments.category ) {
			loc.return = "active";
		} else if ( structKeyExists(params,"action") && params.action == arguments.category ) {
			loc.return = "active";
		} else if ( structKeyExists(params,"controller") && params.controller == arguments.category ) {
			loc.return = "active";
		}
		return loc.return;
	}
	

	//used in multiple controllers to log the view
	function logview() {
		if ( isDefined("params.email") && len(params.email) ) {
		} else if ( isDefined("session.auth.email") ) {
			params.email = session.auth.email;
		} else {
			params.email = "not logged in";
		}
		if ( isDefined("params.key") ) {
			params.paramskey = params.key;
		}
		params.browser = cgi.http_user_agent;
		if ( isdefined("params.key") ) {
			params.paramskey = params.key;
			check = model('Userview').findOne(where="email = '#params.email#' && controller = '#params.controller#' && action = '#params.action#' && paramskey = '#params.key#'");
		} else {
			check = model('Userview').findOne(where="email = '#params.email#' && controller = '#params.controller#' && action = '#params.action#' && paramskey == NULL");
		}
		if ( !isObject(check) ) {
			thisview = model('Userview').create(params);
		} else {
			params.updatedAt = now();
			test = check.update(params);
		}
		return true;
	}

	function Xlogview() {
		return true;
		if ( isDefined("params.email") && len(params.email) ) {
		} else if ( isDefined("session.auth.email") ) {
			params.email = session.auth.email;
		} else {
			params.email = "not logged in";
		}
		if ( isDefined("params.key") ) {
			params.paramskey = params.key;
		}
		params.browser = cgi.http_user_agent;
		if ( isdefined("params.key") ) {
			params.paramskey = params.key;
			check = model('Userview').findOne(where="email = '#params.email#' && controller = '#params.controller#' && action = '#params.action#' && paramskey = '#params.key#'");
		} else {
			check = model('Userview').findOne(where="email = '#params.email#' && controller = '#params.controller#' && action = '#params.action#' && paramskey == NULL");
		}
		if ( !isObject(check) ) {
			thisview = model('Userview').create(params);
		} else {
			params.updatedAt = now();
			test = check.update(params);
		}
	}

	function $setDownloadLayout(defaultLayout='/layout_naked', template=''){
		if ( (isdefined("params.key") && params.key is "excel") || (isdefined("params.format") && params.format is "excel") || (isDefined("params.download")) ) {
			renderPage(template=arguments.template, layout='/layout_download', showDebugOutput="No")
		} else {
			renderPage(template=arguments.template, layout=arguments.defaultLayout, showDebugOutput="No")
		}
	}	

	function logout() {
		structDelete(session,"auth");
		structDelete(session,"params");
		redirectTo(action="index");
	}
	
	function BirthDayAnniversary(required numeric personid) {
		var loc = structNew();
		loc.profile = model("Handbookprofile").findOne(where="personid = #arguments.personid#");
		if ( isObject(loc.profile) ) {
			loc.return.birthday = dateformat(loc.profile.birthday,"medium");
			loc.return.anniversary = dateformat(loc.profile.anniversary,"medium");
		} else {
			loc.return.birthday = "?";
			loc.return.anniversary = "?";
		}
		return loc.return;
	}
	
	private function isFellowshipCouncil() {
		if ( isDefined("session.auth.fellowshipcouncil") && session.auth.fellowshipcouncil ) {
			return true;
		} else if ( gotRights("superadmin,office,fellowshipcouncil") ) {
			return true;
		} else if ( isDefined("params.fc") && params.fc ) {
			return true;
		} else {
			return false;
		}
	}
	
	function isMembershipApp() {
		if ( isDefined("session.membershipapplication.id") && session.membershipapplication.id ) {
			return true;
		} else {
			return false;
		}
	}
	
	function linkTo(){
		var loc = structNew();
		for (var arg in arguments) {
			if (arg is "officeOnly" && arguments.officeOnly) { return arguments.text }
			loc[replace(arg,"_","-","all")] = arguments[arg];
		}
		if (isDefined('loc.key')) { 
			if (isDefined('loc.params')) { loc.params = loc.params & '&' & 'keyy=#loc.key#' }
			else { loc.params = 'keyy=#loc.key#' }
			};
		return super.linkTo(argumentCollection=loc);
	}

	<!---Probably should move to focus controller--->
	function showRegsFor(){
		return model("Focusretreat").findAll(where="showregs = 'yes'", order="startAt DESC")
	}

	function showOptionsFor(){
		return model("Focusretreat").findAll(where="active = 'yes'", order="startAt DESC")
	}

	function linkToList(text="Go Back") {
		var loc=structNew();
		if ( isDefined("session.listingURL") && len(session.listingURL) ) {
			loc.text = arguments.text;
			loc.href = session.listingURL;
			session.listingURL = "";
		} else {
			loc = arguments;
		}
		return super.linkTo(argumentCollection=loc);
	}
	
	function startFormTag() {
		var loc=structNew();
		for ( i in structKeylist(arguments) ) {
			loc[replace(i,"_","-","all")] = arguments[i];
		}
		return super.startFormTag(argumentCollection=loc);
	}

	function isOffice() {
		if ( gotRights("superadmin,office") ) {
			return true;
		}
		if ( isDefined("params.controller") && params.controller contains "handbook" ) {
			return true;
		}
		try {
			if ( structkeyexists(session.auth,"office") ) {
				return true;
			} else {
				return false;
			}
		} catch (any cfcatch) {
			return false;
		}
	}
	
	function checkOffice() {
		if ( !isoffice() ) {
			rendertext("You do !have permission to view this page");
		}
	}
	
	function getRegions() {
		regions = model("Handbookdistrict").findall(order="region");
	}
	
	function getRetreats() {
		retreats = model("Focusretreat").findAll(where="active='yes' && startAt > now()", order="startAt");
	}
	
	function getFocusContent(required id) {
		if ( isnumeric("arguments.id") ) {
			content = model("Focuscontent").findOne(where="id=#arguments.id#");
		} else {
			content = model("Focuscontent").findOne(where="name='#arguments.id#'");
		}
		if ( isObject(content) ) {
			return content.content;
		} else {
			return "no Content";
		}
	}
		

	function getStatus(required id) {
		var status = val(arguments.id);
		if ( len(arguments.id) >= 2 ) {
			status = arguments.id;
		} else if ( status == 0 ) {
			status = "Pending";
		} else if ( status == 1 ) {
			status = "Paid";
		} else if ( status == 2 ) {
			status = "Comp";
		} else {
			status = "NA";
		}
		return status;
	}
	
	function useDesktopLayout() {
		if ( isDefined("session.handbook.isMobile") && session.handbook.isMobile ) {
			return false;
		} else if ( isMobile() ) {
			return false;
		} else {
			return true;
		}
	}
	
	function isMobile() {
		if ( isDefined("params.isMobile") || isDefined("session.isMobile") ) {
			session.isMobile = true;
			return true;
		}
		return super.isMobile();
	}
	
	function isLoggedIn() {
		var loc = structNew();
		if ( isDefined("session.auth.login") && session.auth.login ) {
			return true;
		} else {
			return false;
		}
	}
	
	function simpleEncode(required numeric numbertoEncode, factor="3") {
		var loc=structNew();
		loc = arguments;
		loc.return = (loc.numbertoencode * loc.factor) + loc.factor;
		return loc.return;
	}
	
	function simpleDecode(required numeric numbertoDecode, factor="3") {
		var loc=structNew();
		loc = arguments;
		loc.return = (loc.numbertoDecode-loc.factor)/loc.factor;
		return loc.return;
	}
	

	function isMinistryStaff(userid) {
		try {
			checkForTag = model("Handbooktag").findOne(where="username IN (#getMinistryStaffAdmin()#) && itemId= #arguments.userid# && tag='ministrystaff'");
			if ( isObject(checkForTag) ) {
				return true;
			} else {
				return false;
			}
		} catch (any cfcatch) {
			return false;
		}
	}
	
	function facebookloginisopen() {
		if ( isDefined("session.auth.fblogin") && !session.auth.fblogin ) {
			return false;
		} else if ( get("facebookloginisopen") || isDefined("params.fblogin") || (isDefined("session.auth.fblogin") && session.auth.fblogin) ) {
			session.auth.fblogin = true;
			return true;
		} else {
			return false;
		}
	}
	
	function forcecfcatch() {
		if ( isDefined("params.forcecfcatch") || isDefined("params.forceerror") || isDefined("params.error") ) {
			test = nosuchvariable;
		}
	}
	
	function paramsKeyRequired() {
		if ( !isDefined("params.key") ) {
			renderText("This page cannot display - wrong parameters");
		}
	}

	function gotRights(required string rightsRequired){
		var permission = "no"
		var rightsRequiredArray = listToArray(arguments.rightsRequired)
		if ( structKeyExists(session.auth,'email') ) { arguments.email = session.auth.email }
		for ( right in rightsRequiredArray ){
			if ( isdefined("arguments.email") and listFindNoCase(session.auth.rightslist,right) ) {
				permission = "yes"
			}
			if ( right == 'handbook' && emailIsInHandbook(arguments.email) ) {
				permission = "yes"
			}
		}
		return permission
	}

	function emailIsInHandbook(required string email){
		var check = model("Handbookperson").findOne(where="email = '#arguments.email#' OR email2 = '#arguments.email#'", include="state")
		if ( isObject(check) ) { return true } else { return false }
	}

	function urlExists(required string url) {
			var test = "";
			if ( len(arguments.url) ) {
				cfhttp( url=arguments.url, result="test", method="head" );
				if ( isDefined("test.responseheader.status_code") && test.responseheader.status_code == 200 ) {
					return true;
				} else {
					return false;
				}
			} else {
				return false;
			}
		}
	
	public function isConferenceErrorEmailOn(){
		return application.wheels.sendConferenceEmailOnError;
	}

	public function isHandbookErrorEmailOn(){
		return application.wheels.sendHandbookEmailOnError;
	}

	public function isProduction(){
		if (application.wheels.environment is "production") {
			return true;
		}
		else {
			return false;
		}
	}

	public function paramsEmailRequired(){
		if (!isDefined("params.key")){
			renderText("This page cannot display - wrong parameters");
		}
	}

	public function removeDuplicatesFromList(list,delimiter,case=true){
		var i = 0;
		var listitem = "";
		var newlist = "";

		if(!isDefined("delimiter")){delimiter=","};
		for (i=1; i LTE listLen(list,delimiter); i=i+1){
			listItem = listGetAt(list,i,delimiter);
			if (case is true){
			if (!listFind(newlist,listitem,delimiter)){
				newlist = newlist & delimiter & listitem;
				}
			}
			else {
			if (!listFindNoCase(newlist,listitem,delimiter)){
				newlist = newlist & delimiter & listitem;
				}
			}	
		};
		return replace(newlist,',','','one');
	}

	public function onLocalHost(){
		if( getSetting('onLocalHost')){
			return true;
		}
		else {
			return false;
		}
	}

	<!--- This is also run in onRequestStart - using url.keyy and url.key. might not be needed here --->
	function setKeyToKeyy() {
		if (isDefined("params.keyy") && len(params.keyy)) { params.key = params.keyy};
	}

	private function requiresToken() {
		if (!isDefined('params.token') || params.token NEQ getSetting("requiredToken")) {
			reDirectTo(action="summary")
		}
	}


	function getDistinctColumnValuesFromQuery(required oldquery, required column) {
		cfquery( dbtype="query", name="newQuery" ) { //Note: queryExecute() is the preferred syntax but this syntax is easier to convert generically
	
			writeOutput("SELECT DISTINCT #column#
			FROM oldquery");
		}
		return newQuery;
	}
	
	function setAccessControlHeaders() {
		cfheader( name="Access-Control-Allow-Origin", value="https://access2018.app" );
		cfheader( name="Access-Control-Allow-Methods", value="GET,PUT,POST,DELETE" );
		cfheader( name="Access-Control-Allow-Headers", value="Content-Type" );
		cfheader( name="Access-Control-Allow-Credentials", value=true );
		cfheader( name="Content-Type", value="application/json" );
	}


<!---NOT USED ANYWHERE--->	

	function XsetOrgId() {
		if ( isDefined("session.auth.email") ) {
			org = model("Handbookorganization").findAll(where="Handbookpersonemail = '#session.auth.email#'", include="Handbookposition(Handbookorganization(Handbookstate))");
			if ( org.recordcount ) {
				session.auth.orgid = org.id;
			}
		}
	}
	
	
	
	
}