component extends="tests.Test" output="true" {

<!--------------------------->
<!------VIEW TESTS----------->  
<!--------------------------->

	public function test_welcome() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="focus.main", action="welcome"};
		$run_view_test();
	}

  //RETREATS
  public function test_show_retreat() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="focus.main", action="retreat", key=48};
		$run_view_test();
	}

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

	public function test_retreat() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="focus.Main", action="retreat", key=18};
		$run_view_test();
	}

  //CONTENTS
	public function test_contents_index() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="focus.contents", action="index"};
		$run_view_test();
	}

	public function test_contents_show() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="focus.contents", action="show", key=20};
		$run_view_test();
	}

	public function test_contents_edit() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="focus.contents", action="edit", key=20};
		$run_view_test();
	}

  //REGISTRATIONS
	public function test_registrations_index() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="focus.Registrations", action="index"};
		$run_view_test();
	}

	public function test_registrations_show() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="focus.Registrations", action="show", key=4153};
		$run_view_test();
	}

	public function test_registrations_edit() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="focus.Registrations", action="edit", key=4153};
		$run_view_test();
	}

  //REGISTRANTS
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

  //ITEMS/OPTIONS
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

  //REGISTRATION SYSTEM
  public function test_newshoppingcart() {
		loc.params = {controller="focus.Shoppingcarts", action="new", retreatid=18};
		$run_view_test();
	}

	public function test_createshoppingcart() {
		loc.shoppingcart = {email="tomavey@fgbc.org", fname="Tom", lname="Avey", items="95", phone="574-527-6061", retreat="18", roommate="Sandi"};
		loc.params = {controller="focus.Shoppingcarts", action="create",   shoppingcart=loc.shoppingcart};
		loc.redirectToaction = "show";
  }
  
  //INVOICES
	public function test_invoices_index() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="focus.invoices", action="index"};
		$run_view_test();
	}

  public function test_invoices_show() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="focus.invoices", action="show", key=2275};
		$run_view_test();
	}

  public function test_invoices_edit() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="focus.invoices", action="edit", key=2275};
		$run_view_test();
	}

  public function test_invoices_show() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="focus.invoices", action="show", key=2275};
		$run_view_test();
	}


  //MISC
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


  // public function test_show_whoiscoming() {
	// 	//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
	// 	loc.params = {controller="focus.registrations", action="whoiscoming", key=48};
	// 	$run_view_test();
	// }


}
