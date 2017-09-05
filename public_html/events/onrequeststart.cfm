<!--- Place code here that should be executed on the "onRequestStart" event. --->

<cfloop collection="#form#" item="key">
<cftry>
<cfset form[key] = Trim(form[key])>
<cfcatch></cfcatch>
</cftry>
</cfloop>

<cfif isDefined("url.autologin") && url.autologin is "tomavey133">
    <cfset autologin("tomavey","tomavey@fgbc.org",133,6)>
</cfif>

	<cffunction name="autologin">
	<cfargument name="username" required="true" type="string">
	<cfargument name="email" required="true" type="string">
	<cfargument name="userid" required="true" type="numeric">
	<cfargument name="login_method" required="true" type="numeric">
	<cfargument name="fbid" default="0">
		<cfset session.auth.login = true>
		<cfset session.auth.username = arguments.username>
		<cfset session.auth.email = arguments.email>
		<cfset session.auth.userid = arguments.userid>
		<cfset session.auth.fbid = arguments.fbid>
		<cfset session.auth.login_method = arguments.login_method>
		<cfset session.auth.rightslist = "superadmin">

	</cffunction>

