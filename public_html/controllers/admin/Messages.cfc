component extends="Controller" output="false" {

	public function init() {
		filters(through="checkOffice", only="index,edit");
	}

<!------------------------->
<!------CRUD--------------->
<!------------------------->

	//  messages/index 
	public function index() {
		if ( isDefined("params.search") ) {
			messages = model("Mainmessage").findAll(where="name LIKE '%#params.search#%'", order="createdAt DESC");
		} else if ( isDefined("params.showall") ) {
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
		strCaptcha = getcaptcha();
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
		strCaptcha = getcaptcha();
		if ( len(params.captcha) && params.captcha == decrypt(params.captcha_check,getSetting("passwordkey"),"CFMX_COMPAT","HEX") ) {
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

	//  messages/update 
	public function update() {
		message = model("Mainmessage").findByKey(params.key);
		//  Verify that the message updates successfully 
		if ( message.update(params.message) ) {
			flashInsert(success="The message was updated successfully.");
			redirectTo(action="index");
			//  Otherwise 
		} else {
			flashInsert(error="There was an error updating the message.");
			renderPage(action="edit");
		}
	}

	//  messages/delete/key 
	public function delete() {
		message = model("Mainmessage").findByKey(params.key);
		//  Verify that the message deletes successfully 
		if ( message.delete() ) {
			flashInsert(success="The message was deleted successfully.");
			redirectTo(action="index");
			//  Otherwise 
		} else {
			flashInsert(error="There was an error deleting the message.");
			redirectTo(action="index");
		}
	}

	//  messages/delete/key 
	public function deleteOlder() {
		var oneYearAgo = dateAdd('yyyy',-1,now())
		ddd(oneYearAgo)
		message = model("Mainmessage").deleteAll(where="createdAt < '#oneYearAgo#'")

		//  Verify that the message deletes successfully 
		if ( message ) {
			flashInsert(success="The messages were deleted successfully.");
			redirectTo(action="index");
			//  Otherwise 
		} else {
			flashInsert(error="There was an error deleting the messages.");
			redirectTo(action="index");
		}
	}

	<!---------------------------------->
<!------END OF CRUD----------------->	
<!---------------------------------->



	public function notification() {
		message = model("Mainmessage").findByKey(params.key);
		sendEmail(template="notification", from=message.email, to="tomavey@comcast.net", subject="A message from charisfellowship.us contact page...", layout="/layout_naked");
		redirectTo(action="thankyou");
	}

}
