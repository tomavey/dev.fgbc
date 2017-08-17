<cfcomponent extends="controllers.Controller">

<cffunction name="getNavbarItemClass">
<cfargument name="menuitem" required="true" type="string">
<cfset var loc=structnew()>
<cfset loc.return = "inactive">
	<cfif arguments.menuitem is "home" AND params.controller is "forums.posts" AND params.action is "list">
		<cfset loc.return = "active">
	</cfif>	
	<cfif arguments.menuitem is "about" AND params.controller is "forums.forums" AND params.action is "about">
		<cfset loc.return = "active">
	</cfif>	
	<cfif arguments.menuitem is "upload" AND params.controller is "forums.resources" AND params.action is "new">
		<cfset loc.return = "active">
	</cfif>	
	<cfif arguments.menuitem is "log" AND params.controller is "forums.forums" AND params.action is "forumlog">
		<cfset loc.return = "active">
	</cfif>	

<cfreturn loc.return>
</cffunction>

<cffunction name="forumCheckin">
	<cftry>
	<cfif not session.auth.forum OR not len(session.auth.forumid) OR not len(session.auth.email)>
		<cfset authorize()>
	</cfif>	
	<cfcatch>
		<cfset authorize()>
	</cfcatch>
	</cftry>
</cffunction>

<cffunction name="authorize">

	<cfif isdefined("params.email") AND isdefined("params.groupcode")>
		<cfset redirectTo(controller="forums.posts", action="logmein", params="email=#params.email#&groupcode=#params.groupcode#")>		
	<cfelseif isdefined("params.key") and params.key is "constitution">
		<cfset redirectTo(controller="forums.posts", action="login", params="groupcode=constitution")>		
	<cfelseif not isdefined("session.auth.email") or len(session.auth.email) is 0>
		<cfset redirectTo(controller="forums.posts", action="login")>		
	<cfelseif not isdefined("session.auth.forumid") or len(session.auth.forumid) is 0>
		<cfset redirectTo(controller="forums.posts", action="login")>		
	<cfelse>	
		<cfset session.auth.forum = 1>		
	</cfif>	

</cffunction>	
	


</cfcomponent>