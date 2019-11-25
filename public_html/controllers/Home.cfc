<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
		<!--- <cfset filters(through="getbasicinfo,logview")>--->
		<cfset filters(through="setReturn", only="index")>
		<cfset filters(through="logview", type="after")>
	</cffunction>

<!---Filters--->
	<cffunction name="getBasicInfo">
		<!--- <cfset user=model('auth_users').new()>
		<cfset dropdownlinks = model('Ministry').findall()>
		<cfset feedcount=3> --->
	</cffunction>

<!---Views--->
	<cffunction name="index">
		<cfset session.auth.nomobile = true>
		<cfif isDefined("session.auth.login") and session.auth.login>
			<cfset isCategoryMenu = true>
		<cfelse>
			<cfset isCategoryMenu = false>
		</cfif>
		<cfset announcements = model("Mainannouncement").findall(where="startAt <= now() AND endAt >= now() AND onhold = 'N' AND (type LIKE '%Both%' OR type LIKE '%Announcement%' OR type IS NULL)", order="startAt DESC", maxRows=5)>
		<cfif announcements.recordcount>
			<cfset showannouncements = true>
			<cfset announcementsspan = "span6">
			<cfset spotlightspan = "span3">
			<cfset feedspan = "span3">
		<cfelse>
			<cfset showannouncements = false>
			<cfset spotlightspan = "span4">
			<cfset feedspan = "span8">
		</cfif>
		<cfset menu = Model("Mainmenu").findall(order="category,name")>
	</cffunction>

	<cffunction name="subscribe">
		<!--- Find the record --->
    	<cfset content = model("Maincontent").findByKey(32)>
	</cffunction>

	<cffunction name="office">
		<cfset menu = Model("Mainmenu").findall(order="category,name")>
		<cfset renderPage(template="categoryMenu")>
	</cffunction>

	<cffunction name="testFindAllGotRightsTo">
		<cfset test = model("Mainmenu").FindAllGotRightsTo()>
		<cfdump var="#test#"><cfabort>
	</cffunction>

	<cffunction name="agbm">
		<cfset redirectTo(controller="admin.contents", action="show", key=60)>
	</cffunction>

	<cffunction name="clearsession">
		<cfset structClear(session)>
		<cfset renderText("Session cleared")>
	</cffunction>

	<cffunction name="reloadTrue">
		<cfhttp url="https://charisfellowship.us?reload=true&password=mack">
		<cfset redirectTo(controller="home", action="index")>
	</cffunction>

</cfcomponent>