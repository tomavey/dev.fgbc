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
	
<cffunction name="getcounts">
	<cfargument name="key" default="#params.key#">
	<cfargument name="action" default="#params.action#">
	<cfargument name="controller" default="#params.controller#">
	<cfargument name="email" default="#session.auth.email#">
	<cfargument name="show" default="all">
	<cfset var loc = structNew()>

		<cfset loc.votes = model("Forumvote").findAll(where="postid = #arguments.key#")>

		<cfset loc.views = model('Userview').findAll(where="controller = '#arguments.controller#' AND action = '#arguments.action#' AND paramskey = '#arguments.key#'")>

		<cfset loc.comments = model("Forumpost").findall(where="parentid = #arguments.key#")>

		<cfsavecontent variable="loc.showcount">
			<cfoutput>
				<cfif arguments.show is "all" or arguments.show is "views">
					Views:#loc.views.recordcount#
				</cfif>
				<cfif arguments.show is "all" or arguments.show is "comments">
					Comments:#loc.comments.recordcount#
				</cfif>
				<cfif arguments.show is "all" or arguments.show is "votes">
					Votes:#loc.votes.recordcount#
				</cfif>
			</cfoutput>
		</cfsavecontent>

		<cfreturn loc.showcount>

	</cffunction>

	<cffunction name="getThisForumName">
		<cftry>
		<cfset thisForumName = model("Forumforum").findOne(where="id=#session.auth.forumid#").forum>
		<cfreturn thisForumName>
		<cfcatch><cfreturn "Login to the Forum"></cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="getThisTeamName">
		<cftry>
		<cfset thisTeamName = model("Teamteam").findOne(where="id=#session.auth.teamid#").name>
		<cfreturn thisTeamName>
		<cfcatch><cfreturn "Check-in to the Team Site"></cfcatch>
		</cftry>
	</cffunction>



</cfcomponent>