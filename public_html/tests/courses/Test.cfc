component extends="tests.Test" {

  //COURSES VIEWS
  public function test_courses_Index() {
    //  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
    loc.params = {controller="conference.courses", action="index", message="Listing"};
    $run_view_test();
  }

  public function test_courses_new() {
    //  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
    loc.params = {controller="conference.courses", action="new"};
    $run_view_test();
  }

  public function test_courses_select_person_to_select_cohorts() {
    //  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
    loc.params = {controller="conference.courses", action="selectPersonToSelectCohorts", type="cohort"};
    $run_view_test();
  }

  public function test_courses_select_person_to_show_cohorts() {
    //  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
    loc.params = {controller="conference.courses", action="selectPersonToShowCohorts", type="cohort"};
    $run_view_test();
  }

  public function test_courses_show_all_selected_cohorts() {
    //  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
    loc.params = {controller="conference.courses", action="showAllSelectedCohorts"};
    $run_view_test();
  }

  public function test_courses_View() {
    //  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
    loc.params = {controller="conference.courses", action="view", key=269};
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
 
  
}