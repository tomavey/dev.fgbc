<cfcomponent extends="wheelsMapping.Test">

   <cffunction name="setup">
   		<cfset session.authback = duplicate(session.auth)>
  	<!---login a test user--->
		<cfset session.auth.login = true>
		<cfset session.auth.username = "Tester">
		<cfset session.auth.email = "tester@fgbc.org">
		<cfset session.auth.userid = 7>
		<cfset session.auth.rightslist = "superadmin,office,basic">
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

  <cffunction name="test_registrationIndex">
    
    <!--- setup some default params for the tests plus the text we are looking for. Defaults to "</body>"---> 
    <cfset loc.params = {controller="conference.Registrations", action="index", message="Registrations"}>
    
    <cfset $run_view_test()>
    
  </cffunction> 

  <cffunction name="test_EmailBeforePayment">
    <cfset loc.params = {controller="conference.Register", action="EmailBeforePayment", message="Invoice"}>
    
    <cfset $run_view_test()>
  </cffunction>

  <cffunction name="test_backuplist">
    <cfset loc.params = {controller="conference.Backups", action="list", message="Table Name"}>
    
    <cfset $run_view_test()>
  </cffunction>


</cfcomponent>
