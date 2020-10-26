component extends="Controller" output="false" {

	public function init() {
		filters(through="setShowCaptcha", only="new,create");
	}

	function setShowCaptcha(){
			showCaptcha = getSetting('showCaptcha')
		}
	//  messages/index 

	public function index() {
		if ( isDefined("params.showall") ) {
			messages = model("Mainmessage").findAll(order="createdAt DESC");
		} else {
			messages = model("Mainmessage").findAll(order="createdAt DESC", maxrows=100);
		}
	}
	//  messages/show/key 

	public function show() {
		//  Find the record 
		message = model("Mainmessage").findByKey(params.key);
		//  Check if the record exists 
		if ( !IsObject(message) ) {
			flashInsert(error="Message #params.key# was !found");
			redirectTo(action="index");
		}
	}
	//  messages/new 

	public function new() {
		message = model("Mainmessage").new();
		if ( isDefined("params.subject") ) {
			message.subject = params.subject;
		} else {
			message.subject = "";
		}
		formaction="create";
		if ( showCaptcha ) {
			strCaptcha = getcaptcha();
		}
	}
	//  messages/new 

	public function cci_new() {
		params.subject= "Constitution Questions";
		params.headermessage = "Send your question:";
		message = model("Mainmessage").new();
		if ( isDefined("params.subject") ) {
			message.subject = params.subject;
		} else {
			message.subject = "";
		}
		strCaptcha = getcaptcha();
		renderPage(action="new");
	}
	//  messages/edit/key 

	public function edit() {
		//  Find the record 
		message = model("Mainmessage").findByKey(params.key);
		//  Check if the record exists 
		if ( !IsObject(message) ) {
			flashInsert(error="Message #params.key# was !found");
			redirectTo(action="index");
		}
	}
	//  messages/create 

	public function create() {

		if ( isBadMessage(params.message.email, params.message.message) ) { 
				redirectTo(action="thankyou")
			}
			
		if ( showCaptcha ) {
			strCaptcha = getcaptcha();
			params.captcha_check = decrypt(params.captcha_check,getSetting("passwordkey"),"CFMX_COMPAT","HEX");
		}
		//  <cfset ddd(params)> 
		if ( !showCaptcha || (len(params.captcha) && params.captcha == params.captcha_check) ) {
			message = model("Mainmessage").new(params.message);
			//  Verify that the message creates successfully 
			if ( message.save() ) {
				flashInsert(success="The message was created successfully.");
				redirectTo(action="notification", key=message.id);
				//  Otherwise 
			} else {
				flashInsert(error="There was an error creating the message.");
				renderPage(action="new");
			}
		} else {
			flashInsert(error="Please try to enter the scrambled image again.");
			message = model("Mainmessage").new(params.message);
			strCaptcha = getcaptcha();
			renderPage(action="new");
		}
	}

	function isBadMessage( 
		email,
		message,
		badContactUsMessages = listToArray(getSetting('badContactUsMessage')), 
		badContactUsEmails = listToArray(getSetting('badContactUsEmail')) 
		){
			for ( var BadMessage in badContactUsMessages ) {
				if ( findNoCase(BadMessage,message) ) { return true }
			}
			for ( var BadEmail in badContactUsEmails ) {
				if ( findNoCase(BadEmail,email) ) { return true }
			}
		return false
	}

	public function notification() {
		var loc = structNew();
		message = model("Mainmessage").findByKey(params.key);
		if ( len(message.subject) ) {
			loc.subject = message.subject;
		} else {
			loc.subject = "A message from charisfellowship.us contact page...";
		}
		if ( !isLocalMachine() ) {
			sendEmail(template="notification", from=message.email, to=getSetting('sendContactUsTo'), subject=loc.subject, layout="/layout_naked");
		} else {
			flashInsert(failed="Email was !sent from this local machine to #getSetting('sendContactUsTo')#");
		}
		redirectTo(action="thankyou");
	}

}
