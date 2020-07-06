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

<cfreturn loc.return>
</cffunction>