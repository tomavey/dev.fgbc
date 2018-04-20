where=""
<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
		<cfset provides("json,xml,xls")>
		<cfset filters(through="paramsEmailRequired", only="getInvoices")>
		<cfset usesLayout(template="/conference/layout2018")>
	</cffunction>

	<cfscript>
		public function paramsEmailRequired(){
			if (!isDefined("params.email") || !isValid("email", params.email))
				{
					renderText("This page cannot display - please enter a valid email address");
				}
		}
	</cfscript>

	<cffunction name="index">
		<cfset users = model("Conferenceuser").findall(include="Auth_users", order="createdAt DESC")>
		<cfset setreturn()>
		<cfset renderPage(layout="/conference/adminlayout")>
	</cffunction>

	<cffunction name="new">
		<cfset user = model("Conferenceuser").new()>
		<cfset auth_users = model("Authuser").findAll(maxRows="10", order="selectname")>
		<cfset families = model("Conferencefamily").findAll(where="fullNameLastFirst IS NOT NULL", include="person", maxRows="100", order="fullNameLastFirst")>
	</cffunction>

	<cffunction name="create">
		<cfset user = model("Conferenceuser").new(params.user)>
		<cfif user.save()>
			<cfset returnBack()>
		<cfelse>
			<cfset renderText("Oops")>
		</cfif>
	</cffunction>

	<cffunction name="myRegs">
	<cfset var loc=structNew()>
		<cfif isDefined("params.FBid") OR isDefined("params.userId")>
			<cfif isDefined("params.FBid")>
				<cfset loc.FBid = params.FBid>
			</cfif>
			<cfif isDefined("params.Userid")>
				<cfset loc.Userid = params.Userid>
			</cfif>
		<cfelse>
			<cfif isDefined("session.auth.FBid")>
				<cfset loc.FBid = session.auth.FBid>
			</cfif>
			<cfif isDefined("session.auth.Userid")>
				<cfset loc.Userid = session.auth.Userid>
			</cfif>
		</cfif>

		<cfset regs = model("Conferenceregistration").RegsByUseridAndFBid(loc)>
		<cfset renderWith(data = regs, layout = "/conference/layout2017")>
	</cffunction>

	<cffunction name="connectFamilyToUser">
	<cfargument name="familyid" default="#params.familyid#">
		<cfset var loc = structNew()>
		<cfset loc = arguments>
		<cfif isDefined("params.userid")>
			<cfset loc.userid = params.userid>
		<cfelseif isDefined("session.auth.userid")>
			<cfset loc.userid = session.auth.userid>
		</cfif>
		<cfif isDefined("params.fbid")>
			<cfset loc.fbid = params.fbid>
		<cfelseif isDefined("session.auth.fbid")>
			<cfset loc.fbid = session.auth.fbid>
		</cfif>
		<cfset user = model("Conferenceuser").create(loc)>

		<cfset returnBack()>

	</cffunction>

	<cffunction name="loginAsUser">
	<cfargument name="userid" default="#params.key#">
	<cfset user = model("Conferenceuser").findOne(where="userid=#arguments.userid#")>
	<cfset session.auth.userid = user.userid>
	<cfif isDefined("userifbid")>
		<cfset session.auth.fbid = user.fbid>
	</cfif>
	<cfset redirectTo(route="conferenceRegister")>
	</cffunction>

	<cffunction name="listFamiliesToConnect">
	<cfargument name="userid" default="#params.key#">
		<cfset families = model("Conferencefamily").getfamilies()>
		<cfset renderText("This page cannot display")>
		<!---
		<cfset renderPage(layout="/conference/adminlayout")>
		--->
	</cffunction>

	<cffunction name="getInvoices">
		<cfset redirectTo(route="showInvoiceByEmail", params="email=#params.email#")>
	</cffunction>

</cfcomponent>
