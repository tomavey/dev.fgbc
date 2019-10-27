<cfcomponent extends="Controller" output="false">

	<cfobject name="authorize" component="models.handbookauthorize" >
	<cfobject name="authenticate" component="models.handbookauthenticate" >

	<cffunction name="init">
		<cfset usesLayout("/handbook/layout_handbook2")>
		<cfset filters(through="logview")>
		<cfset filters(through="setReturn", only="index")>
	</cffunction>

	<!--- <cffunction name="location">
		<cflocation url="http://www.fgbc.org/handbook/" addtoken="true">
	</cffunction> --->

	<cffunction name="welcome">
		<cfif isDefined("params.id")>
			<cfset redirectTo(action="index", params="unlockcode=#params.id#")>
		<cfelseif isDefined("params.key")>
			<cfset redirectTo(action="index", params="unlockcode=#params.key#")>
		<cfelse>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>

	<cffunction name="myhandbook">
		<cfif isDefined("params.id")>
			<cfset redirectTo(action="index", params="unlockcode=#params.id#")>
		<cfelse>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>

	<cffunction name="index">
		<!--- <cfset var auth = {}>
		<cfset auth.handbook = structNew()>
		<cfset auth.handbook.basic = false>
		<cfset auth.handbook.people = "">
		<cfset auth.handbook.organizations = "">
		<cfset session.auth = auth> --->

	<!-------------------->
	<!---AUTHENTICATION--->	
	<!-------------------->

		<!---Conditions to authorize this user--->
		<cftry>

			<!---If params.unlockcode is an encrypted use email that is already in the handbook - give basic rights only--->
			<cfif isdefined("params.unlockcode") and len(params.unlockcode) GT 5>
				<cfset session.auth = authenticate.unLockCode(params)>

			<!--- if this session is already authorized, other conditions don't apply--->
			<cfelseif isDefined("session.auth.handbook.basic") and session.auth.handbook.basic>
				<cfset session.auth.passedString = authenticate.isAlreadyAuthorized()>

			<!---If this person is already logged into fgbc.org with handbook rights - all rights maintained--->
			<cfelseif isDefined("session.auth") && structKeyExists(session.auth,"rightslist") and NOT isdefined("params.logoutfirst") and NOT isDefined("params.reviewer") and NOT isDefined("params.handbookUpdate")>
				<cfset session.auth = authenticate.isAlreadyLoggedInToMainSiteWithHandbookRights(params)>

			<!---If authorization cookies are set - give basic rights only--->
			<cfelseif isDefined("cookie.authhandbookbasic") && cookie.authhandbookbasic && getSetting('allowHandbookAuthByCookie')>
				<cfset session.auth = authenticate.cookiesSet()>

			<!---If this is a reviewer (using a reviewed link) - give basic rights only - reviewed email must--->
			<cfelseif isDefined("params.reviewer") && len(params.reviewer) && isDefined("params.orgid") && val(params.orgid) && allowHandbookOrgUpdate()>
				<cfset session.auth = authenticate.reviewer(params)>
				<cfset redirectTo(controller="handbook.organization", action="show", key=params.orgid)>

			<!---If this is a handbook updater send to handbook review checkin--->
			<!---Need to check this out more--->
			<cfelseif isDefined("params.handbookUpdate") and val(params.handbookupdate)>
				<cfset session.auth.passedString = authenticate.isHandbookUpdater()>
				<cfset redirectTo(action="handbookReviewCheckin", key=params.handbookupdate)>
   		</cfif>

 		<cfcatch>#sendWelcomeErrorNotice("Handbook welcome error in authentication section")#"</cfcatch>
 		</cftry>


	<!-------------------->
	<!---AUTHORIZATION_--->	
	<!-------------------->

		<!---Set up session variables that connect this person with the people and organizations he or she can edit--->

		<cftry>

		<cfif isdefined("session.auth.email")>

			<!---Search handbookPerson for this email address and set id's into a string and save as session.auth.handbook.people--->
			<cfset people = model("Handbookperson").findall(where="email = '#session.auth.email#' OR email2='#session.auth.email#'", include="Handbookpositions,handbookstate")>
			<cfset session.auth.handbook.people = valuelist(people.id,",")>

			<cfif listLen(session.auth.handbook.people)>
				<cfset session.auth.handbook.people = removeDuplicates(session.auth.handbook.people)>
			</cfif>

			<!---Search handbookPeople with positions for this email address and set id's into a string and save as session.auth.handbook.organizations--->
			<cfset organizations = model("Handbookperson").findall(where="(email = '#session.auth.email#' OR email2 = '#session.auth.email#') AND p_sortorder < #getSetting('nonStaffSortOrder')#", include="Handbookpositions,Handbookstate")>
			<cfset session.auth.handbook.organizations = valuelist(organizations.organizationid,",")>

			<cfif listLen(session.auth.handbook.organizations)>
				<cfset session.auth.handbook.organizations = removeDuplicates(session.auth.handbook.organizations)>
			</cfif>

		</cfif>

		<cfcatch>#sendWelcomeErrorNotice("Handbook welcome error in the authorization section")#"</cfcatch>
		</cftry>

 		<cftry>

<!---
	<cfdump var="#session.auth#" label="Params">
	<cfdump var="#params#" label="Auth"><cfabort>
--->

		<!---If this person is authorized, send them to their personal page or else send them to checkin--->

		<cfif session.auth.handbook.basic>

   		<!---If the params.handbookUpdate is set, go to the handbook update page for this persons organization--->
   		<cfif isDefined("params.handbookUpdate") and isDefined("session.auth.handbook.organizations")>
   			<cfset redirectTo(controller="handbook.organizations", action="handbookpages", key=val(session.auth.handbook.organizations))>

			 <!---OR else if this person is entering using only an email and organizationid--->
   		<cfelseif isDefined("request.auth.handbook.review") and request.auth.handbook.review>
    			<cfset redirectTo(controller="handbook.organizations", action="handbookpages", key=params.orgid)>

			<!---OR else if this person is connected with at least one person record, show that page--->
 			<cfelseif val(session.auth.handbook.people) and isDefined("params.simpleupdate")>
				<cfset redirectTo(route="editHandbookPerson", key=val(session.auth.handbook.people), params="simple=true")>

			<cfelseif val(session.auth.handbook.people)>
				<cfset redirectTo(route="handbookPerson", key=val(session.auth.handbook.people))>
			<!---Or else, go to the people index page--->
			<cfelse>
				<cfset redirectTo(route="handbookPeople")>
			</cfif>

		<cfelse>
			<cfset redirectTo(action="checkin")>
		</cfif>

		<cfcatch>#sendWelcomeErrorNotice("Handbook welcome error in the redirection section")#"</cfcatch>
		</cftry>

		<cfset redirectTo(action="checkin")>

	</cffunction>

<cfscript>
	function allowHandbookOrgUpdate(){
		if (
			getSetting('allowHandbookOrgUpdate')
			&& isBefore(getSetting('churchReviewDeadline'))
		) {
			return true
		} else {
			return false
		}
	}
</cfscript>

	<cffunction name="review">
		<cfset params.key = simpleDecode(params.orgid)>

		<cfif isDefined("params.reviewer") and isDefined("params.key") and allowHandbookOrgUpdate()>
			<cfset church = model("Handbookorganization").findOne(where="id=#params.key#", include="Handbookstate")>
		  	<cfif isObject(church)>
			     <cfset session.auth.email = params.reviewer>
   				 <cfset session.auth.username = params.reviewer>
   				 <cfset session.auth.rightslist = "basic">
   				 <cfset session.auth.handbook.basic = true>
   				 <cfset session.auth.handbook.review = true>
   				 <cfset request.auth.handbook.review = true>
				 <cfset reDirectTo(controller="handbook.organizations", action="handbookpages", key=params.key)>
			<cfelse>
				<cfset renderText("Oops!  Something went wrong.  Email tomavey@fgbc.org for assistance.")>
			</cfif>
		<cfelseif isDefined("params.key") and allowHandbookOrgUpdate()>
			<cfset church = model("Handbookorganization").findOne(where="id=#params.key#", include="Handbookstate")>
		  	<cfif isObject(church)>
				<cfset formaction = "review">
				<cfset renderPage(action="handbookReviewCheckin")>
			<cfelse>
				<cfset renderText("You do not have permission to view this page (2)")>
			</cfif>
		<cfelse>
				<cfset reDirectTo(action="welcome")>
		</cfif>
	</cffunction>

	<cffunction name="setAuthCookies">
		<cfcookie name="authemail" expires="never" value="#session.auth.email#">
		<cfcookie name="authusername" expires="never" value="#session.auth.username#">
		<cfcookie name="authhandbookbasic" expires="never" value="#session.auth.handbook.basic#">
	</cffunction>

	<cffunction name="removeDuplicates">
	<cfargument name="list" required="true" type="string">
	<cfset var newlist="">
		<cfloop list="#arguments.list#" index="i">
			<cfif not listfind(newlist,i)>
				<cfset newlist = newlist & "," & i  >
			</cfif>
		</cfloop>
		<cfset newlist = replace(newlist,",","","one")>
	<cfreturn newlist>
	</cffunction>

	<cffunction name="checkin">
		<cfset renderPage(layout="/handbook/layout_handbook2")>
	</cffunction>

	<cffunction name="sendLink">
	<cfset var loc = structNew()>
	<cfif !isDefined("params.email")>
		<cfset redirectTo(action="checkin")>
	</cfif>	
                <cfif isValid("email",params.email)>
		<cfset loc.check = model("Handbookperson").findAll(where="email='#params.email#' OR email2='#params.email#' OR spouse_email='#params.email#'", include="Handbookstate")>
		<cfif loc.check.recordcount>
			<cfset params.key = encrypt(params.email,getSetting("passwordkey"),"CFMX_COMPAT","HEX")>
			<cfif !isLocalMachine()>
				<cfset sendEmail(template="sendlink", layout="/layout_naked", from=getSetting('userAdminEmailAddress'), to=params.email, subject="Your FGBC Handbook Link")>	
			<cfelse>
				<cfset flashInsert(error="#linkTo(controller="handbook.welcome", action="welcome", onlyPath=false, params="id=#params.key#")#
				")>
			</cfif>
			<cfset renderPage(action="thankyou")>
		<cfelse>
			<cfset flashInsert(failure="The email address you provided is not in the current handbook. Please try another email address.")>
			<cfset redirectTo(action="checkin")>
		</cfif>
                <cfelse>
                     <cfset flashInsert(error="Please provide a valid email address.")>
                     <cfset redirectTo(action="checkin")>
                </cfif>
	</cffunction>

	<cffunction name="appClear">
		<cfdump var="#application.wheels#"><cfabort>
		<cfset structDelete(application,"wheels")>
		<cfset redirectTo(action="welcome")>
	</cffunction>

	<cffunction name="logout">
		<cfset structDelete(session,"auth")>
		<cfset structDelete(cookie,"auth")>
		<cfloop list="authemail,authhandbookbasic,authrightslist,authusername" index="i">
			<cfcookie name=i value="">
			<cfset structDelete(cookie,i)>
		</cfloop>
		<cfset redirectTo(controller="handbook", action="welcome")>
	</cffunction>

	<cffunction name="clearsession">
		<cfset structDelete(session,"auth")>
		<cfset renderText("Session.auth is gone")>
	</cffunction>

	<cffunction name="loginform">
		<cfset renderPage(controller="auth.users", action="loginform")>
	</cffunction>

	<cffunction name="sendWelcomeErrorNotice">
	<cfargument name="subject"  default="FGBC Handbook Welcome Error">
		<cfset sendEmail(from=getSetting('errorEmailAddress'), to=getSetting('errorEmailAddress'), template="welcomeerroremail.cfm", subject=arguments.subject)>
	</cffunction>

	<cffunction name="testSendWelcomeErrorNotice">
		<cfset sendWelcomeErrorNotice("Test Welcome Error Notice")>
		<cfset renderText("Message should have been sent")>
	</cffunction>


</cfcomponent>