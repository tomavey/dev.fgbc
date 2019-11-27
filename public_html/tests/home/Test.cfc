component extends="wheelsMapping.Test" {

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

	public function test_home() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="Home", action="index"};
		$run_view_test();
	}

	public function test_statementOfFaith() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="About", action="statementoffaith", message="COVENANT"};
		$run_view_test;
	}

	public function test_ourStory() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="About", action="ourstory", message="The FGBC Story"};
		$run_view_test;
	}

	public function test_constitution() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="About", action="constitution", message="Constitution"};
		$run_view_test;
	}

	public function test_MOP() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="About", action="manual-of-procedure", message="Manual of Procedure"};
		$run_view_test;
	}

	public function test_fellowshipcouncil() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="Page", key="22", message="Fellowship Council"};
		$run_view_test;
	}

	public function test_contactus() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="Contactus", message="message"};
		$run_view_test;
	}

	public function test_churches() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="About", action="constitution", message="message"};
		$run_view_test;
	}

	public function test_events() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="Events", action="index", message="Focus Retreat"};
		$run_view_test;
	}

	public function test_ministries() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="Ministries", action="index", message="Camps"};
		$run_view_test;
	}

	public function test_jobs() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="Jobs", action="index", message="ministry opportunities"};
		$run_view_test;
	}

	public function test_blogs() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="Blogs", action="list", message="Blogs around the FGBC"};
		$run_view_test;
	}

	public function test_handbook() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="Handbook", action="welcome"};
		$run_view_test;
	}

}
