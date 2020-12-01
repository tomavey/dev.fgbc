component extends="tests.Test" output="true" {

  function test_welcome() {
    //  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
    loc.params = {controller="handbook.Welcome", action="checkin", message="welcome"};
    $run_view_test();
  }
  
  function test_handbookChangeLog() {
    //  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
    loc.params = {controller="handbook.updates", action="index", message="updates"};
    $run_view_test();
  }
  
  function test_handbookSendYesterdaysUpdates() {
    //  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
    loc.params = {controller="handbook.subscribes", action="sendYesterdaysUpdates", message="updates"};
    $run_view_test();
  }
  
  function test_personIndex() {
    //  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
    loc.params = {controller="handbook.People", action="index"};
    $run_view_test();
  }
  
  function test_personShow() {
    //  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
    loc.params = {controller="handbook.People", action="show", key="233", message="Avey"};
    $run_view_test();
  }
  
  function test_personEdit() {
    //  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
    loc.params = {controller="handbook.People", action="edit", key="233", message="Avey"};
    $run_view_test();
  }

  function test_organizationindex() {
    //  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
    loc.params = {controller="handbook.Organizations", action="index"};
    $run_view_test();
  }
  
  function test_organizationshow() {
    //  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
    loc.params = {controller="handbook.Organizations", action="show", key=1, message="Lititz"};
    $run_view_test();
  }
  
  function test_tagsIndex() {
    //  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
    loc.params = {controller="handbook.Tags", action="index"};
    $run_view_test();
  }
  
  function test_tagsShow() {
    //  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
    loc.params = {controller="handbook.Tags", action="show", key="fc", message="fc"};
    $run_view_test();
  }
  
  function test_picturesIndex() {
    //  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
    loc.params = {controller="handbook.Pictures", action="index", message="Pictures"};
    $run_view_test();
  }
  
  function test_birthdaysIndex() {
    //  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
    loc.params = {controller="handbook.People", action="dates", key="birthday", message="Birthdays"};
    $run_view_test();
  }
  
  function test_anniversariesIndex() {
    //  setup some default params for the tests plus the text we are looking for. Defaults to "</body>"
    loc.params = {controller="handbook.People", action="dates", key="anniversary", message="Anniversaries"};
    $run_view_test();
  }
  
  public function test_handbookStatisticsIndex(){
    loc.params = {controller="handbook.statistics", action="index", message="Listing Statistics"};
    $run_view_test();
  }

  public function test_handbookStatisticsNew(){
    loc.params = {controller="handbook.statistics", action="new", message="Create new stat"};
    $run_view_test();
  }

  public function test_handbookStatisticsEdit(){
    loc.params = {controller="handbook.statistics", action="edit", key=4021, message="Editing"};
    $run_view_test();
  }

  // public function test_handbookChurchReviewArray(){
  //   test = model("Handbookorganization").findChurchesForEmailing(go="true");
  //   results = test[arrayLen(test)].email;
  //   expectedResults = "tomavey@fgbc.org";
  //   assert("results EQ expectedResults");
  // }

  // public function test_handbookChurchReviewOptions(){
  //   loc.params = {controller="handbook.organizations", action="handbookReviewOptions", message="Show Last Reviewed Before this Date"};
  //   $run_view_test();
  //   }

  // public function test_handbookChurchReviewEmailing(){
  //   loc.params = {controller="handbook.organizations", action="emailChurchesForHandbookReview", message="Charis Fellowship Handbook is in production"};
  //   $run_view_test();
  //   }

  // public function test_handbookPeopleReviewArray(){
  //   test = model("Handbookperson").getHandbookReviewStruct(go="true");
  //   results = test[arrayLen(test)].email;
  //   expectedResults = "tomavey@fgbc.org";
  //   assert("results EQ expectedResults");
  // }

  // public function test_handbookPeopleReviewOptions(){
  //   loc.params = {controller="handbook.people", action="handbookReviewOptions", message="Show Last Reviewed Before this Date"};
  //   $run_view_test();
  //   }

  }