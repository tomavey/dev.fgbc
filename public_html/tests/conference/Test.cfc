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
  

<!----------------------------------->
<!--------VIEW TESTS----------------->  
<!----------------------------------->

  //REGISTRATION VIEWS
  public function test_registrations_Index() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.Registrations", action="index", message="Registrations"};
		$run_view_test();
	}

  public function test_registrations_Show() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.registrations", action="show", key=22315};
		$run_view_test();
	}

  public function test_registrations_Edit() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.registrations", action="edit", key=22315};
		$run_view_test();
	}

  public function test_registrations_Summary() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.registrations", action="summary", message="Regs"};
		$run_view_test();
	}

  //EVENTS VIEWS
  public function test_events_Index() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.events", action="index", message="Conference Events"};
		$run_view_test();
	}

  public function test_events_Show() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.events", action="show", key=1144};
		$run_view_test();
	}

  public function test_events_Edit() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.events", action="edit", key=1144};
		$run_view_test();
	}

  //LOCATIONS VIEWS
  public function test_locations_Index() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.locations", action="index", message="Listing locations"};
		$run_view_test();
	}

	public function test_locations_Show() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.locations", action="show", key=254, message="Showing Location"};
		$run_view_test();
	}

  public function test_locations_Edit() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.locations", action="edit", key=254, message="Editing Location"};
		$run_view_test();
	}

  //COURSES VIEWS
  public function test_courses_Index() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.courses", action="index", message="Listing"};
		$run_view_test();
	}

  public function test_courses_Show() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.courses", action="show", key=269, message="Showing"};
		$run_view_test();
	}

  public function test_courses_Edit() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.courses", action="edit", key=269, message="Editing"};
		$run_view_test();
	}

  //OPTIONS VIEWS
  public function test_options_Index() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.options", action="index"};
		$run_view_test();
	}

  public function test_options_Show() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.options", action="show", key=570};
		$run_view_test();
	}

  public function test_options_Edit() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.options", action="edit", key=570};
		$run_view_test();
	}

  //INSTRUCTORS VIEWS
  public function test_instructors_Index() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.instructors", action="index", message="Listing"};
		$run_view_test();
	}

  public function test_instructors_Show() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.instructors", action="show", key=182, message="Showing"};
		$run_view_test();
	}

  public function test_instructors_Edit() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.instructors", action="edit", key=182, message="Editing"};
		$run_view_test();
	}

  //PEOPLE VIEWS
  public function test_people_Index() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.people", action="index"};
		$run_view_test();
	}

  public function test_people_Show() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.people", action="show", key=200};
		$run_view_test();
	}

  public function test_people_Edit() {
		//  setup some default params for the tests plus the text/message we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.people", action="edit", key=200};
		$run_view_test();
	}

  //FAMILIES VIEWS
  public function test_families_Index() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.families", action="index"};
		$run_view_test();
	}

  public function test_families_Show() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.families", action="show", key=4084};
		$run_view_test();
	}

  public function test_families_Edit() {
		//  setup some default params for the tests plus the text/message we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.families", action="edit", key=4084};
		$run_view_test();
	}

	public function test_families_Envelopes() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.families", action="envelopes"};
		$run_view_test();
	}

	public function test_families_Badges() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.families", action="badges"};
		$run_view_test();
	}

  //INVOICES VIEWS
  public function test_invoices_Index() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.invoices", action="index"};
		$run_view_test();
	}

  public function test_invoices_Show() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.invoices", action="show", key=2985};
		$run_view_test();
	}

  public function test_invoices_Edit() {
		//  setup some default params for the tests plus the text/message we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.invoices", action="edit", key=2985};
		$run_view_test();
	}

  //MISC VIEWS
  public function test_EmailBefore_Payment() {
		loc.params = {controller="conference.Register", action="EmailBeforePayment", message="Invoice"};
		$run_view_test();
	}

	public function test_backup_list() {
		loc.params = {controller="conference.Backups", action="list", message="Table Name"};
		$run_view_test();
  }
  
  // public function getTestsArray(){
  //   const testsArray = [
  //     {
  //       CONTROLLER: "families",
  //       ACTION: "index"
  //     },
  //     {
  //       CONTROLLER: "families",
  //       ACTION: "show",
  //       KEY: 4143
  //     }
  //   ]
  // }

  // public function factory( testArray = getTestsArray() ) {

  // }

}
