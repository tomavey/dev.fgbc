component extends="Wheels" {

	dsn=getSetting("dataSourceName")

	private function footerData(){
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
				first 5 characters as our CAPTCHA text string.
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
<!--------------------->
<!---END OF CAPTCHA---->
<!--------------------->





<!------------------>
<!-----SECURITY----->
<!------------------>

	function getKey(required string email) output=false {
		var key="";
		key = encrypt(arguments.email,getSetting("passwordkey"),"CFMX_COMPAT","Hex");
		return key;
	}

	private function requiresToken() {
		if (!isDefined('params.token') || params.token NEQ getSetting("requiredToken")) {
			reDirectTo(action="summary")
		}
	}
<!------------------------->
<!-----END OF SECURITY----->
<!------------------------->





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

	// function isOffice() {
	// 	try {
	// 		if ( !gotRights("superadmin,office,handbookedit") ) {
	// 			redirectto(controller="home", action="loggedOut");
	// 			abort;
	// 		}
	// 	} catch (any cfcatch) {
	// 		redirectto(controller="home", action="loggedOut");
	// 	}
	// }

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
		if ( gotRights("superadmin,office,pageEditor,agbm") ) {
			return true;
		} else {
			renderText("You do not have persmission to view this page");
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

	function isOffice() {
		if ( gotRights("superadmin,office") == 'yes' ) {
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
			rendertext("You do !have permission to view this page...");
		}
	}

	function isMobile() {
		if ( isDefined("params.isMobile") || isDefined("session.isMobile") ) {
			session.isMobile = true;
			return true;
		}
		return super.isMobile();
	}

	function setAccessControlHeaders() {
		cfheader( name="Access-Control-Allow-Origin", value="https://access2018.app" );
		cfheader( name="Access-Control-Allow-Methods", value="GET,PUT,POST,DELETE" );
		cfheader( name="Access-Control-Allow-Headers", value="Content-Type" );
		cfheader( name="Access-Control-Allow-Credentials", value=true );
		cfheader( name="Content-Type", value="application/json" );
	}

	function gotRights(required string rightsRequired){
		var loc = {}
		var loc.permission = "no"
		var loc.rightsRequiredArray = listToArray(arguments.rightsRequired)
			if ( structKeyExists(session,'auth') && structKeyExists(session.auth,'email') ) { loc.email = session.auth.email }
			for ( loc.right in loc.rightsRequiredArray ){
				if ( isdefined("loc.email") && listFindNoCase(session.auth.rightslist,loc.right) ) {
					loc.permission = "yes"
				}
				if ( isDefined('loc.email') && loc.right == 'handbook' && emailIsInHandbook(loc.email) ) {
					loc.permission = "yes"
				}
			} 
		return loc.permission
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
		
<!---------------------------------->
<!---END OF AUTHORIZATION METHODS--->
<!---------------------------------->





<!------------------------------>	
<!-------NAVIGATION AIDS-------->	
<!------------------------------>	
	//Used in conjunction with returnBack() to return to referring page
	private void function setReturn() {
		if ( !isDefined("params.ajax") ) {
			if ( params.action == "index" || params.action == "list" ) {
				session.listingURL = $GetCurrentURL();
			}
			session.originalURL = $GetCurrentURL();
		}
	}

	//Used in conjunction with setReturn() to return to referring page
	private void	function returnBack(string controller, string action, string error){
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

	//used by setReturn()
	public string function $GetCurrentURL() {
		var theURL = getPageContext().getRequest().GetRequestUrl();
		if ( !isLocalMachine() ) {
			if ( !find(CGI.query_string,theUrl) ){
				theURL = theURL & "?" & CGI.query_string;
			}
			if ( findNoCase(theURL,'charisfellowship.us') ) {
				theUrl = replace(theURL,'http://','https://','one')
				if ( gotRights("superadmin") ) {
					ddd(theURL)
				}
				}
			return replace(theUrl, "/rewrite.cfm","")
		}
		//HACK: this is for the local machine since getPageContext().getRequest().GetRequestUrl() does not report the full path on my localmachine
		if ( len( CGI.path_info) ) {
			theURL = theURL & CGI.path_info;
		} 
		if ( len( CGI.query_string ) ) {
			theURL = theURL & "?" & CGI.query_string;
		}
		return theURL;
	}

	// Overflow method
	// For custom data attributes we convert underscores and camel case to hyphens.
	// E.g. "dataDomCache" and "data_dom_cache" becomes "data-dom-cache".
	// This is to get around the issue with not being able to use a hyphen in an argument name in CFML.
	function linkTo(){
		var loc = structNew();
		var OKTags = ["<i","<b","<img"]
		// loop through arguments and replace _ with -
		for (var arg in arguments) {
			if (arg is "officeOnly" && arguments.officeOnly) { return arguments.text }
			loc[replace(arg,"_","-","all")] = arguments[arg];
		}
		// Add a params.keyy - needed for cfwheels1x - might not be needed for cfwheels2x
		if (isDefined('loc.key')) { 
			if (isDefined('loc.params')) { loc.params = loc.params & '&' & 'keyy=#loc.key#' }
			else { loc.params = 'keyy=#loc.key#' }
			};
		//add encode="attributes" if the text is an image or icon	
		if ( isDefined("loc.text") ) {
			for ( var OKTag in OKTags ) {
				if( find(OKTag,loc.text) ) { loc.encode= "attributes"	}
			}
		}
		return super.linkTo(argumentCollection=loc);
	}

	// Overflow method
	// For custom data attributes we convert underscores and camel case to hyphens.
	// E.g. "dataDomCache" and "data_dom_cache" becomes "data-dom-cache".
	// This is to get around the issue with not being able to use a hyphen in an argument name in CFML.
	function startFormTag() {
		var loc=structNew();
		for ( i in structKeylist(arguments) ) {
			loc[replace(i,"_","-","all")] = arguments[i];
		}
		return super.startFormTag(argumentCollection=loc);
	}

	function submitTag() {
		var loc=structNew();
		for ( i in structKeylist(arguments) ) {
			loc[replace(i,"_","-","all")] = arguments[i];
		}
		return super.submitTag(argumentCollection=loc);
	}

	// Overflow method
	// For custom data attributes we convert underscores and camel case to hyphens.
	// E.g. "dataDomCache" and "data_dom_cache" becomes "data-dom-cache".
	// ie: v_model becomes v-model used in vue
	// This is to get around the issue with not being able to use a hyphen in an argument name in CFML.
	function textField() {
		var loc=structNew();
		for ( i in structKeylist(arguments) ) {
			loc[replace(i,"_","-","all")] = arguments[i];
		}
		return super.textField(argumentCollection=loc)
	}

	//Used when linking back to a list of things. . ie action=index
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
<!------------------------------------->	
<!-------END OF NAVIGATION AIDS-------->	
<!------------------------------------->	





<!------------------------->	
<!-------SET LAYOUTS------->	
<!------------------------->	

	function useDesktopLayout() {
		if ( isDefined("session.handbook.isMobile") && session.handbook.isMobile ) {
			return false;
		} else if ( isMobile() ) {
			return false;
		} else {
			return true;
		}
	}

	private void function $setDownloadLayout(defaultLayout='/layout_naked', template=''){
		if ( 
				(isdefined("params.key") && params.key is "excel") 
				|| (isdefined("params.format") && params.format is "excel") 
				|| (isDefined("params.download") && params.download is "excel")
			) {
			renderView(template=arguments.template, layout='/layout_download', showDebugOutput="No")
		} else {
			renderView(template=arguments.template, layout=arguments.defaultLayout, showDebugOutput="No")
		}
	}	
<!-------------------------------->	
<!-------END OF SET LAYOUTS------->	
<!-------------------------------->	





<!-------------------------------------->
<!--------GETTERS FOR SETTINGS---------->
<!-------------------------------------->

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

	public function onLocalHost(){
		if( getSetting('onLocalHost')){
			return true;
		}
		else {
			return false;
		}
	}
<!-------------------------------------->
<!-----END OF GETTERS FOR SETTINGS------>
<!-------------------------------------->
	




<!-------------------------------------->
<!---------GENERAL METHODS-------------->
<!-------------------------------------->

	//used in multiple controllers to log the view
	function logview() {
		if ( !getsetting("logviews") ) { return false }
		if ( isDefined("params.email") && len(params.email) ) {
		} else if ( isDefined("session.auth.email") ) {
			params.email = session.auth.email;
		} else {
			params.email = "not logged in";
		}
		if ( isDefined("params.key") ) {
			params.paramskey = params.key;
		}
		if ( isDefined("params.keyy") ) {
			params.paramskey = params.keyy;
		}
		params.browser = cgi.http_user_agent;
		writeDump(params)
		//Check to see if this userView already exists so I don't duplicate
		if ( isdefined("params.key") ) {
			params.paramskey = params.key;
			log = model('Viewlog').findOne(where="email = '#params.email#' AND controller = '#params.controller#' AND action = '#params.action#' AND paramskey = '#params.key#'");
		} else {
			log = model('Viewlog').findOne(where="email = '#params.email#' AND controller = '#params.controller#' AND action = '#params.action#' AND paramskey IS NULL");
		}
		if ( !isObject(log) ) {
			//if not, create a new userView
			log = model('Viewlog').new(params)
			test = log.save()
			} else {
			//else update the updatedField on the one that already exists
			params.updatedAt = now();
			log.update(params);
		}
		return true;
	}
	
	//Used by conference and focus registration system to interpret payment return codes
	function getStatus(required id) {
		var status = val(arguments.id);
		if ( len(arguments.id) >= 3 ) {
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
	
	function forcecfcatch() {
		if ( isDefined("params.forcecfcatch") || isDefined("params.forceerror") || isDefined("params.error") ) {
			test = nosuchvariable;
		}
	}

}