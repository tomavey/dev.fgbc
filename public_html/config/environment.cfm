<!---
	The environment setting can be set to "design", "development", "testing", "maintenance" or "production".
	For example, set it to "design" or "development" when you are building your application and to "production" when it's running live.
--->
<cfif cgi.http_host is "fgbc:8080" OR cgi.http_host is "fgbc:8888">
	<cfset set(environment="development")>
<cfelse>
	<cfset set(environment="design")>
</cfif>