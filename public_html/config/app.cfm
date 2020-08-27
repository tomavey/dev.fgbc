<!---
	Place settings that should go in the Application.cfc's "this" scope here.
--->
<cfscript>
	THIS.name = "fgbc"
	THIS.ApplicationTimeout = CreateTimeSpan( 1, 0, 0, 0 )
	THIS.SessionManagement = true
	THIS.SessionTimeout = CreateTimeSpan( 0, 3, 0, 0 )
	THIS.bufferOutput = true
</cfscript>
