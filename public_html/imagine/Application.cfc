<!---
	You can place ".cfm" files in this folder and run them independently from Wheels.
	This empty "Application.cfc" file makes sure that Wheels does not interfer with the request. 
--->
<cfcomponent>
	<cfset this.name="miscellaneous">
	<cfset THIS.ApplicationTimeout = CreateTimeSpan( 0, 1, 0, 0 ) />
	<cfset THIS.SessionManagement = true />
	<cfset THIS.SessionTimeout = CreateTimeSpan( 0, 0, 60, 0 )  />


</cfcomponent>