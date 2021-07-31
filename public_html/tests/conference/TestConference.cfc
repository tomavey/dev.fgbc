component extends="tests.Test" output="true" {

<!----------------------------------->
<!--------VIEW TESTS----------------->  
<!----------------------------------->
function test_ActualEqualsExpected() {
  actual = true;
  expected = true;
  assert("actual eq expected");
}
  //REGISTRATION VIEWS
  public function test_registrations_Index() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.Registrations", action="index", message="Registrations", maxrows=10};
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
		loc.params = {controller="conference.events", action="index"};
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
		loc.params = {controller="conference.families", action="index", maxrows=10};
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
		loc.params = {controller="conference.families", action="envelopes", maxrows=10};
		$run_view_test();
	}

	public function test_families_Badges() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.families", action="badges", maxrows=10};
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

	//AGE_RANGES
	public function test_age_ranges_index() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.age_ranges", action="index"};
		$run_view_test();
	}

	public function test_age_ranges__new() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.age_ranges", action="new"};
		$run_view_test();
	}

	public function test_age_ranges__show() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.age_ranges", action="show", key=1};
		$run_view_test();
	}

	public function test_age_ranges__edit() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.age_ranges", action="edit", key=1};
		$run_view_test();
	}


	//ANNOUNCEMENTS
	public function Xtest_announcements_index() {
		//something is breaking on this test
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.announcements", action="index"};
		$run_view_test();
	}

	public function test_announcements__new() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.announcements", action="new"};
		$run_view_test();
	}

	public function test_announcements__show() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.announcements", action="show", key=579};
		$run_view_test();
	}

	public function test_announcements__edit() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.announcements", action="edit", key=579};
		$run_view_test();
	}


//COURSE QUESTIONS
	public function Xtest_course_questions_index() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.coursequestions", action="index"};
		$run_view_test();
	}

	public function test_course_questions__new() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.coursequestions", action="new"};
		$run_view_test();
	}

	public function test_course_questions__show() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.coursequestions", action="show", key=116};
		$run_view_test();
	}

	public function test_course_questions__edit() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.coursequestions", action="edit", key=116};
		$run_view_test();
	}


//COURSE RESOURCES
	// public function Xtest_course_resources_index() {
	// 	//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
	// 	loc.params = {controller="conference.courseresources", action="index"};
	// 	$run_view_test();
	// }

	// public function Xtest_course_resources__new() {
	// 	//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
	// 	loc.params = {controller="conference.courseresources", action="new"};
	// 	$run_view_test();
	// }

	// public function Xtest_course_resources__show() {
	// 	//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
	// 	loc.params = {controller="conference.courseresources", action="show", key=139};
	// 	$run_view_test();
	// }

	// public function Xtest_course_resources__edit() {
	// 	//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
	// 	loc.params = {controller="conference.courseresources", action="edit", key=139};
	// 	$run_view_test();
	// }


//COURSE INSTRUCTORS
	public function test_course_instructors__new() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="conference.courseinstructors", action="new"};
		$run_view_test();
	}


	// //CHILDCARE WORKERS
	// public function Xtest_childcare_workers_index() {
	// 	//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
	// 	loc.params = {controller="conference.childcareworkers", action="index"};
	// 	$run_view_test();
	// }

	// public function Xtest_childcare_workers__new() {
	// 	//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
	// 	loc.params = {controller="conference.childcareworkers", action="new"};
	// 	$run_view_test();
	// }



  //MISC VIEWS
  public function test_EmailBefore_Payment() {
		loc.params = {controller="conference.Register", action="EmailBeforePayment", message="Invoice"};
		$run_view_test();
	}

	public function test_backup_list() {
		loc.params = {controller="conference.Backups", action="list", message="Table Name", maxrows=10};
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
