<!---
	You can place ".cfm" files in this folder and run them independently from Wheels.
	This empty "Application.cfc" file makes sure that Wheels does not interfer with the request.
--->
<cfcomponent output="false">

<cfset this.name = "fgbc">
<cfset this.sessionManagement = true>

<cffunction name="onApplicationStart" output="false">
<cfset application.fbappid = "10152781512188290">
<cfset application.fbsecret = "5a85ea243d25e86cf6d1ca335bb5e202">
<cfset application.fbredirecturl = "http://localhost:8888/miscellaneous/test/redir.cfm">
</cffunction>

<cffunction name="onRequestStart" output="false">
<cfif isDefined("url.init")>
<cfset onApplicationStart()>
</cfif>
</cffunction>

</cfcomponent>
