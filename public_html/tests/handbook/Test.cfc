<cfcomponent extends="wheelsMapping.Test">

   <cffunction name="setup">
   		<cfset session.authback = duplicate(session.auth)>
  	<!---login a test user--->
		<cfset session.auth.login = true>
		<cfset session.auth.username = "Tester">
		<cfset session.auth.email = "tester@fgbc.org">
		<cfset session.auth.userid = 7>
		<cfset session.auth.rightslist = "basic">
   </cffunction>

   <cffunction name="teardown">
   		<cfset structDelete(session,"auth")>
   		<cfset session.auth = duplicate(session.authback)>
   		<cfset structDelete(session,"authback")>
   </cffunction>

  <cffunction name="$run_view_test">
    <!--- create an instance of the controller --->
    <cfset loc.controller = controller(loc.params.controller, loc.params)>

    <!--- process the create action of the controller --->
    <cfset loc.controller.$processAction()>

    <!--- get copy of the code the view generated --->
    <cfset loc.response = loc.controller.response()>

	<!---Set the text we are looking for defaulting to </body>--->
    <cfif isDefined("loc.params.message")>
       <cfset loc.message = loc.params.message>
    <cfelse>
       <cfset loc.message = "</body>">
    </cfif>

    <!--- make sure the message was displayed somewhere on the page--->
    <cfset assert('loc.response contains loc.message')>

  </cffunction>

  <cffunction name="test_welcome">

    <!--- setup some default params for the tests plus the text we are looking for. Defaults to "</body>"--->
    <cfset loc.params = {controller="handbook.Welcome", action="checkin", message="welcome"}>

    <cfset $run_view_test()>

  </cffunction>

  <cffunction name="test_handbookChangeLog">

    <!--- setup some default params for the tests plus the text we are looking for. Defaults to "</body>"--->
    <cfset loc.params = {controller="handbook.updates", action="index", message="updates"}>

    <cfset $run_view_test()>

  </cffunction>

  <cffunction name="test_handbookSendYesterdaysUpdates">

    <!--- setup some default params for the tests plus the text we are looking for. Defaults to "</body>"--->
    <cfset loc.params = {controller="handbook.subscribes", action="sendYesterdaysUpdates", message="updates"}>

    <cfset $run_view_test()>

  </cffunction>

  <cffunction name="test_personIndex">

    <!--- setup some default params for the tests plus the text we are looking for. Defaults to "</body>"--->
    <cfset loc.params = {controller="handbook.People", action="index"}>

    <cfset $run_view_test()>

  </cffunction>

  <cffunction name="test_personShow">

    <!--- setup some default params for the tests plus the text we are looking for. Defaults to "</body>"--->
    <cfset loc.params = {controller="handbook.People", action="show", key="233", message="Avey"}>

    <cfset $run_view_test()>

  </cffunction>

  <cffunction name="test_organizationindex">

    <!--- setup some default params for the tests plus the text we are looking for. Defaults to "</body>"--->
    <cfset loc.params = {controller="handbook.Organizations", action="index"}>

    <cfset $run_view_test()>

  </cffunction>

  <cffunction name="test_organizationshow">

    <!--- setup some default params for the tests plus the text we are looking for. Defaults to "</body>"--->
    <cfset loc.params = {controller="handbook.Organizations", action="show", key=1, message="Lititz"}>

    <cfset $run_view_test()>

  </cffunction>

  <cffunction name="test_tagsIndex">

    <!--- setup some default params for the tests plus the text we are looking for. Defaults to "</body>"--->
    <cfset loc.params = {controller="handbook.Tags", action="index"}>

    <cfset $run_view_test()>

  </cffunction>

  <cffunction name="test_tagsShow">

    <!--- setup some default params for the tests plus the text we are looking for. Defaults to "</body>"--->
    <cfset loc.params = {controller="handbook.Tags", action="show", key="fc", message="fc"}>

    <cfset $run_view_test()>

  </cffunction>

  <cffunction name="test_picturesIndex">

    <!--- setup some default params for the tests plus the text we are looking for. Defaults to "</body>"--->
    <cfset loc.params = {controller="handbook.Pictures", action="index", message="Pictures"}>

    <cfset $run_view_test()>

  </cffunction>

  <cffunction name="test_birthdaysIndex">

    <!--- setup some default params for the tests plus the text we are looking for. Defaults to "</body>"--->
    <cfset loc.params = {controller="handbook.People", action="dates", key="birthday", message="Birthdays"}>

    <cfset $run_view_test()>

  </cffunction>

  <cffunction name="test_anniversariesIndex">

    <!--- setup some default params for the tests plus the text we are looking for. Defaults to "</body>"--->
    <cfset loc.params = {controller="handbook.People", action="dates", key="anniversary", message="Anniversaries"}>

    <cfset $run_view_test()>

  </cffunction>

<cfscript>

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
  //   loc.params = {controller="handbook.organizations", action="emailChurchesForHandbookReview", message="FGBC Handbook is in production"};
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

</cfscript>  

</cfcomponent>
