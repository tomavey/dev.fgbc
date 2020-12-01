<cfcomponent extends="Model" output="false">
	
	
	<cffunction name="config">
		<cfset table("fgbc_menus")>
	</cffunction>

	<cffunction name="FindAllGotRightsTo">
	<cfset var loc = structNew()>
		<cfset loc.menu = Model("Mainmenu").findall(order="category,name")>
		<cfset loc.menuGotRightsTo = queryNew(loc.menu.columnlist)>
		<cfset loc.includethis = false>
		<cfoutput query="loc.menu">
			<cfset listAppend(rightsrequired,"superadmin")>
			<cfloop list="#rightsrequired#,superadmin" index="loc.ii">
	            <cfif isdefined("session.auth.rightslist") and listfind(session.auth.rightslist,loc.ii)>
	            	<cfset loc.includethis = true>
	            	<cfbreak>
	            </cfif>	
			</cfloop>
			<cfif loc.includethis>
				<cfset queryAddRow(loc.menuGotRightsTo)>
				<cfloop list="#loc.menu.columnlist#" index="i">
					<cfset querySetCell(loc.menuGotRightsTo, i, evaluate(i))>
				</cfloop>
			</cfif>
			<cfset loc.includethis = false>
		</cfoutput>
		<cfreturn loc.menuGotRightsTo>
	</cffunction>
	


</cfcomponent>