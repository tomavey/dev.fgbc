component extends="wheelsMapping.Test" {

	public function setup() {
		session.authback = duplicate(session.auth);
		// login a test user
		session.auth.login = true;
		session.auth.username = "Tester";
		session.auth.email = "tester@fgbc.org";
		session.auth.userid = 7;
		session.auth.rightslist = "basic,handbook,office";
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

	public function test_welcome() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="focus.main", action="welcome"};
		$run_view_test();
	}

	public function test_show_retreat() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="focus.main", action="retreat", key=48};
		$run_view_test();
	}

	// public function test_show_whoiscoming() {
	// 	//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
	// 	loc.params = {controller="focus.registrations", action="whoiscoming", key=48};
	// 	$run_view_test();
	// }

  public function test_retreats_index() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="focus.Retreats", action="index"};
		$run_view_test();
	}

  public function test_retreats_show() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="focus.Retreats", action="show", key=50};
		$run_view_test();
	}

  public function test_retreats_edit() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="focus.Retreats", action="edit", key=50};
		$run_view_test();
	}

  public function test_retreats_new() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="focus.Retreats", action="new", key=50};
		$run_view_test();
	}

	public function test_about() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="focus.Main", action="about"};
		$run_view_test();
	}

	public function test_testimonies() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="focus.Testimonies", action="list"};
		$run_view_test();
	}

	public function test_retreat() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="focus.Main", action="retreat", key=18};
		$run_view_test();
	}

	public function test_registrations_index() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="focus.Registrations", action="index"};
		$run_view_test();
	}

	public function test_registrants_show() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="focus.registrants", action="show", key=2432};
		$run_view_test();
	}

	public function test_registrants_edit() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="focus.registrants", action="edit", key=2432};
		$run_view_test();
	}

	public function test_items_index() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="focus.items", action="index"};
		$run_view_test();
	}

	public function test_items_show() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="focus.items", action="index", key=297};
		$run_view_test();
	}

	public function test_items_edit() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="focus.items", action="index", key=297};
		$run_view_test();
	}

	public function test_items_new() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="focus.items", action="new", retreatId=46};
		$run_view_test();
	}

  public function test_newshoppingcart() {
		loc.params = {controller="focus.Shoppingcarts", action="new", retreatid=18};
		$run_view_test();
	}

	public function test_createshoppingcart() {
		loc.shoppingcart = {email="tomavey@fgbc.org", fname="Tom", lname="Avey", items="95", phone="574-527-6061", retreat="18", roommate="Sandi"};
		loc.params = {controller="focus.Shoppingcarts", action="create",   shoppingcart=loc.shoppingcart};
		loc.redirectToaction = "show";
	}

}
