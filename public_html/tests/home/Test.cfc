<cfcomponent extends="wheelsMapping.Test">

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
  
  <cffunction name="test_home">
    
    <!--- setup some default params for the tests plus the text we are looking for. Defaults to "</body>"---> 
    <cfset loc.params = {controller="Home", action="index"}>
    
    <cfset $run_view_test()>
    
  </cffunction> 
  
  <cffunction name="test_statementOfFaith">
    
    <!--- setup some default params for the tests plus the text we are looking for. Defaults to "</body>"---> 
    <cfset loc.params = {controller="About", action="statementoffaith", message="COVENANT"}> 
    
    <cfset $run_view_test> 
    
  </cffunction> 

  <cffunction name="test_ourStory">
    
    <!--- setup some default params for the tests plus the text we are looking for. Defaults to "</body>"---> 
    <cfset loc.params = {controller="About", action="ourstory", message="The FGBC Story"}> 
    
    <cfset $run_view_test> 
    
  </cffunction> 

  <cffunction name="test_constitution">
    
    <!--- setup some default params for the tests plus the text we are looking for. Defaults to "</body>"---> 
    <cfset loc.params = {controller="About", action="constitution", message="Constitution"}> 
    
    <cfset $run_view_test> 
    
  </cffunction> 

  <cffunction name="test_MOP">
    
    <!--- setup some default params for the tests plus the text we are looking for. Defaults to "</body>"---> 
    <cfset loc.params = {controller="About", action="manual-of-procedure", message="Manual of Procedure"}> 
    
    <cfset $run_view_test> 
    
  </cffunction> 

  <cffunction name="test_fellowshipcouncil">
    
    <!--- setup some default params for the tests plus the text we are looking for. Defaults to "</body>"---> 
    <cfset loc.params = {controller="Page", key="22", message="Fellowship Council"}> 
    
    <cfset $run_view_test> 
    
  </cffunction> 

  <cffunction name="test_contactus">
    
    <!--- setup some default params for the tests plus the text we are looking for. Defaults to "</body>"---> 
    <cfset loc.params = {controller="Contactus", message="message"}> 
    
    <cfset $run_view_test> 
    
  </cffunction> 

  <cffunction name="test_churches">
    
    <!--- setup some default params for the tests plus the text we are looking for. Defaults to "</body>"---> 
    <cfset loc.params = {controller="About", action="constitution", message="message"}> 
    
    <cfset $run_view_test> 
    
  </cffunction> 

  <cffunction name="test_events">
    
    <!--- setup some default params for the tests plus the text we are looking for. Defaults to "</body>"---> 
    <cfset loc.params = {controller="Events", action="index", message="Focus Retreat"}> 
    
    <cfset $run_view_test> 
    
  </cffunction> 

  <cffunction name="test_ministries">
    
    <!--- setup some default params for the tests plus the text we are looking for. Defaults to "</body>"---> 
    <cfset loc.params = {controller="Ministries", action="index", message="Camps"}> 
    
    <cfset $run_view_test> 
    
  </cffunction> 

  <cffunction name="test_jobs">
    
    <!--- setup some default params for the tests plus the text we are looking for. Defaults to "</body>"---> 
    <cfset loc.params = {controller="Jobs", action="index", message="ministry opportunities"}> 
    
    <cfset $run_view_test> 
    
  </cffunction> 

  <cffunction name="test_blogs">
    
    <!--- setup some default params for the tests plus the text we are looking for. Defaults to "</body>"---> 
    <cfset loc.params = {controller="Blogs", action="list", message="Blogs around the FGBC"}> 
    
    <cfset $run_view_test> 
    
  </cffunction> 

  <cffunction name="test_handbook">
    
    <!--- setup some default params for the tests plus the text we are looking for. Defaults to "</body>"---> 
    <cfset loc.params = {controller="Handbook", action="welcome"}> 
    
    <cfset $run_view_test> 
    
  </cffunction> 

</cfcomponent>
