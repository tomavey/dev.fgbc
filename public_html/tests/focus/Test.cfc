<cfcomponent extends="wheelsMapping.Test">

  <cffunction name="setup">
    <cfset session.authback = duplicate(session.auth)>
    <!---login a test user--->
    <cfset session.auth.login = true>
    <cfset session.auth.username = "Tester">
    <cfset session.auth.email = "tester@fgbc.org">
    <cfset session.auth.userid = 7>
  <cfset session.auth.rightslist = "basic,handbook,office">

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
  
  <cffunction name="$run_controller_test">
    <!--- create an instance of the controller --->
    <cfset loc.controller = controller(loc.params.controller, loc.params)>

    <!--- process the create action of the controller --->
    <cfset loc.controller.$processAction()>
 
    <!--- get the information about the redirect that should have happened --->
    <cfset loc.redirect = loc.controller.$getRedirect()>

    <!--- make sure that the redirect happened --->
    <cfset assert('StructKeyExists(loc.redirect, "$args")')>
    <cfset assert('loc.redirect.$args.action eq loc.redirectToaction')>
   
  </cffunction>

  <cffunction name="test_index">
    
    <!--- setup some default params for the tests plus the text we are looking for. Defaults to "</body>"---> 
    <cfset loc.params = {controller="focus.Retreats", action="index"}>
    
    <cfset $run_view_test()>
    
  </cffunction> 
  
  <cffunction name="test_about">
    
    <!--- setup some default params for the tests plus the text we are looking for. Defaults to "</body>"---> 
    <cfset loc.params = {controller="focus.Main", action="about"}>
    
    <cfset $run_view_test()>
    
  </cffunction> 

  <cffunction name="test_testimonies">
    
    <!--- setup some default params for the tests plus the text we are looking for. Defaults to "</body>"---> 
    <cfset loc.params = {controller="focus.Testimonies", action="list"}>
    
    <cfset $run_view_test()>
    
  </cffunction> 

  <cffunction name="test_retreat">
    
    <!--- setup some default params for the tests plus the text we are looking for. Defaults to "</body>"---> 
    <cfset loc.params = {controller="focus.Main", action="retreat", key=18}>
    
    <cfset $run_view_test()>
    
  </cffunction> 

  <cffunction name="test_admin">
    
    <!--- setup some default params for the tests plus the text we are looking for. Defaults to "</body>"---> 
    <cfset loc.params = {controller="focus.Registrations", action="index", params="unlock=charis"}>
    
    <cfset $run_view_test()>
    
  </cffunction> 

  <cffunction name="test_newshoppingcart">

    <cfset loc.params = {controller="focus.Shoppingcarts", action="new", retreatid=18}>

    <cfset $run_view_test()>
    
  </cffunction>

  <cffunction name="test_createshoppingcart">

    <cfset loc.shoppingcart = {email="tomavey@fgbc.org", fname="Tom", lname="Avey", items="95", phone="574-527-6061", retreat="18", roommate="Sandi"}>

    <cfset loc.params = {controller="focus.Shoppingcarts", action="create",   shoppingcart=loc.shoppingcart}>

    <cfset loc.redirectToaction = "show">

  </cffunction>

</cfcomponent>
