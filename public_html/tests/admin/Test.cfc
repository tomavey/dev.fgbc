component extends="wheelsMapping.Test" {

  public function setup() {
		session.authback = duplicate(session.auth);
		// login a test user
		session.auth.login = true;
		session.auth.username = "Tester";
		session.auth.email = "tester@fgbc.org";
		session.auth.userid = 7;
		session.auth.rightslist = "office";
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
  
  //EVENTS
	public function test_events_index() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.events", action="index"};
		$run_view_test();
	}

	public function test_events_new() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.events", action="new"};
		$run_view_test();
	}

	public function test_events_show() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.events", action="show", key=118};
		$run_view_test();
	}

	public function test_events_edit() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.events", action="edit", key=118};
		$run_view_test();
	}

  //ANNOUNCEMENTS
	public function test_announcements_index() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.announcements", action="index"};
		$run_view_test();
	}

	public function test_announcements_new() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.announcements", action="new"};
		$run_view_test();
	}

	public function test_announcements_show() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.announcements", action="show", key=253};
		$run_view_test();
	}

	public function test_announcements_edit() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.announcements", action="edit", key=253};
		$run_view_test();
	}

  //MEMBERSHIP.APPLICATIONS
	public function test_applications_index() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="membership.applications", action="index"};
		$run_view_test();
	}

	public function test_applications_new() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="membership.applications", action="new"};
		$run_view_test();
	}

	public function test_applications_show() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="membership.applications", action="show", keyy="83FE0CAD-DAA3-4F13-A0004ADF2B90AEA6"};
		$run_view_test();
	}

	public function test_applications_edit() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="membership.applications", action="edit", keyy="83FE0CAD-DAA3-4F13-A0004ADF2B90AEA6"};
		$run_view_test();
	}

  //CONTENTS (PAGES)
	public function test_contents_index() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.contents", action="index"};
		$run_view_test();
	}

	public function test_contents_new() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.contents", action="new"};
		$run_view_test();
	}

	public function test_contents_show() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.contents", action="show", key=137};
		$run_view_test();
	}

	public function test_contents_edit() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.contents", action="edit", key=137};
		$run_view_test();
	}

  //JOBS
	public function test_jobs_index() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.jobs", action="index"};
		$run_view_test();
	}

	public function test_jobs_new() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.jobs", action="new"};
		$run_view_test();
	}

	public function test_jobs_show() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.jobs", action="show", key=542};
		$run_view_test();
	}

	public function test_jobs_edit() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.jobs", action="edit", key=542};
		$run_view_test();
	}

  //MENUS
	public function test_menus_index() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.menus", action="index"};
		$run_view_test();
	}

	public function test_menus_new() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.menus", action="new"};
		$run_view_test();
	}

	public function test_menus_show() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.menus", action="show", key=4};
		$run_view_test();
	}

	public function test_menus_edit() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.menus", action="edit", key=4};
		$run_view_test();
	}


}
