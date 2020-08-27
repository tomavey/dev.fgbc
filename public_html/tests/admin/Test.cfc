component extends="tests.Test" {

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
		loc.params = {controller="membership.applications", action="show", keyy=69, uuid="43FA5480-A287-464C-9F88E3C719732364"};
		$run_view_test();
	}

	public function test_applications_edit() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="membership.applications", action="edit", key="43FA5480-A287-464C-9F88E3C719732364"};
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

  //MESSAGES
	public function test_messages_index() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.messages", action="index"};
		$run_view_test();
	}

	public function test_messages_new() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.messages", action="new"};
		$run_view_test();
	}

	public function test_messages_show() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.messages", action="show", key=1035};
		$run_view_test();
	}

	public function test_messages_edit() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.messages", action="edit", key=1035};
		$run_view_test();
	}

  //MINISTRIES
	public function test_ministries_index() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.ministries", action="index"};
		$run_view_test();
	}

	public function test_ministries_new() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.ministries", action="new"};
		$run_view_test();
	}

	public function test_ministries_show() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.ministries", action="show", key=48};
		$run_view_test();
	}

	public function test_ministries_edit() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.ministries", action="edit", key=48};
		$run_view_test();
	}

  //RESOURCES
	public function test_resources_index() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.resources", action="index"};
		$run_view_test();
	}

	public function test_resources_new() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.resources", action="new"};
		$run_view_test();
	}

	public function test_resources_show() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.resources", action="show", key=22};
		$run_view_test();
	}

	public function test_resources_edit() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.resources", action="edit", key=22};
		$run_view_test();
	}

  //SENDEMAILS
	public function test_send_emails_index() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.sendemails", action="index"};
		$run_view_test();
	}

	public function test_send_emails_new() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.sendemails", action="new"};
		$run_view_test();
	}

	public function test_send_emails_show() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.sendemails", action="show", key=1};
		$run_view_test();
	}

	public function test_send_emails_edit() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.sendemails", action="edit", key=1};
		$run_view_test();
	}

  //SETTINGS
	public function test_settings_index() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.settings", action="index"};
		$run_view_test();
	}

	public function test_send_emails_new() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.settings", action="new"};
		$run_view_test();
	}

	public function test_send_emails_show() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.settings", action="show", key=54};
		$run_view_test();
	}

	public function test_send_emails_edit() {
		//  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
		loc.params = {controller="admin.settings", action="edit", key=54};
		$run_view_test();
	}

}
