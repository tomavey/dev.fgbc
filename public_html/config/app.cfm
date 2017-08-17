<!---
	Place settings that should go in the Application.cfc's "this" scope here.
--->
<cfset THIS.name = "fgbc">
<cfset THIS.ApplicationTimeout = CreateTimeSpan( 1, 0, 0, 0 ) />
<cfset THIS.SessionManagement = true />
<cfset THIS.SessionTimeout = CreateTimeSpan( 0, 3, 0, 0 )  />
