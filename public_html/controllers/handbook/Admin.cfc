<cfcomponent extends="Controller" output="false">

<!---this controller is only used for the main admin page
and for downloading a basic list of member churches.
Most related actions are in handbook-statictis--->

	<cffunction name="init">
		<cfset usesLayout(template="/handbook/layout_admin")>
		<cfset filters(through="isoffice")>
	</cffunction>

	<cffunction name="downloadMemberChurches">
	<cfif isDefined("params.key") and params.key is "includecampuses">
		<cfset wherestring = "statusid = 1 OR statusid = 8 OR statusid = 9">
	<cfelseif isDefined("params.key") and params.key is "includecampusesandnewchurches">
		<cfset wherestring = "statusid = 1 OR statusid = 8 OR statusid = 2 OR statusid = 9">
	<cfelse>
		<cfset wherestring = "statusid = 1">
	</cfif>
		<cfset churches = model("Handbookorganization").findAll(where=wherestring, include="Handbookstate,Handbookstatus", order="state_mail_abbrev,org_city,name")>
		<cfif isdefined("params.download")>
			<cfset renderPage(layout="/layout_download")>
		</cfif>
	</cffunction>

	<cffunction name="getSeniorPastorEmail">
	<cfargument name="churchid" required="true" type="numeric">
	<cfset var loc=structNew()>
	<cfset loc.return = "">
		<cfset pastor = model("Handbookposition").findAll(where="organizationid=#arguments.churchid# AND p_sortorder=1", include="Handbookperson,Handbookorganization(Handbookstate)")>
		<cfif pastor.recordcount and len(pastor.email)>
			<cfset loc.return = pastor.email>
		</cfif>
	<cfreturn loc.return>
	</cffunction>

	<cffunction name="getLastAtt">
	<cfargument name="churchid" required="true" type="numeric">
	<cfset var loc= structNew()>
		<cfset loc.lastAtt = model("Handbookstatistic").findLastAtt(arguments.churchid)>
		<cfreturn loc.lastatt>
	</cffunction>

</cfcomponent>