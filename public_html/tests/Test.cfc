component extends="wheelsMapping.Test" {

  public function setup() {
		session.authback = duplicate(session.auth);
		// login a test user
		session.auth.login = true;
		session.auth.username = "Tester";
		session.auth.email = "tester@fgbc.org";
		session.auth.userid = 7;
		session.auth.rightslist = "superadmin,office,basic";
	}

	public function teardown() {
		structDelete(session,"auth");
		session.auth = duplicate(session.authback);
		structDelete(session,"authback");
	}

	public function $run_view_test() {
		//  create an instance of the controller 
		loc.controller = controller(loc.params.controller, loc.params);
		//  process the create action of the controller 
		loc.controller.$processAction();
		//  get copy of the code the view generated 
		loc.response = loc.controller.response();
		// Set the text we are looking for defaulting to </body>
		if ( isDefined("loc.params.message") ) {
			loc.message = loc.params.message;
		} else {
			loc.message = "</body>";
		}
		//  make sure the message was displayed somewhere on the page
		assert('loc.response contains loc.message');
	}

	public function $run_controller_test() {
		//  create an instance of the controller 
		loc.controller = controller(loc.params.controller, loc.params);
		//  process the create action of the controller 
		loc.controller.$processAction();
		//  get the information about the redirect that should have happened 
		loc.redirect = loc.controller.$getRedirect();
		//  make sure that the redirect happened 
		assert('StructKeyExists(loc.redirect, "$args")');
		assert('loc.redirect.$args.action == loc.redirectToaction');
  }
  
}