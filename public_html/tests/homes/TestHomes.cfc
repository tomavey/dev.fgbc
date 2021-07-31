component extends="tests.Test" output="true" {

//output hiddenMessagetoTestFor() somewhere on the tested view

	public function test_index() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.homes", action="index", message="for tests"};
		$run_view_test();
	}

	public function test_list() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.homes", action="list", message="for tests"};
		$run_view_test();
	}
  
	public function test_new() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.homes", action="new", type="host", message="for tests"};
		$run_view_test();
	}

}