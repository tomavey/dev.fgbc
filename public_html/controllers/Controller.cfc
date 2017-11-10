<cfcomponent extends="Wheels">

		<!--- <cfset user=model('auth_users').new()>
		<cfset dropdownlinks = model('fgbc_ministries').findall()>
		<cfset menus= model('menu').findall(order="category,name")>
		--->
		<cfset user = model("Authuser").new()>
		<cfset myself=cgi.SCRIPT_NAME>
		<cfset feedcount=3>


	<cffunction name="getCaptcha" output="no">
	<cfset var arrValidChars = "">
	<cfset var strCaptcha = arraynew(1)>
	<cfset var captchaForm = "">
		<!---
			Create the array of valid characters. Leave out the
			numbers 0 (zero) and 1 (one) as they can be easily
			confused with the characters o and l (respectively).
		--->
		<cfset arrValidChars = ListToArray(
			"A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z," &
			"2,3,4,5,6,7,8,9"
			) />

		<!--- Now, shuffle the array. --->
		<cfset CreateObject(
			"java",
			"java.util.Collections"
			).Shuffle(
				arrValidChars
				)
			/>

		<!---
			Now that we have a shuffled array, let's grab the
			first 4 characters as our CAPTCHA text string.
		--->
		<cfset strCaptcha = (
			arrValidChars[ 1 ] &
			arrValidChars[ 2 ] &
			arrValidChars[ 3 ] &
			arrValidChars[ 4 ] &
			arrValidChars[ 5 ]
			) />


	<cfreturn strCaptcha>

</cffunction>

	<cffunction name="checkCaptcha">

		<cfif len(params.captcha) AND params.captcha is decrypt(params.captcha_check,application.wheels.passwordkey,"CFMX_COMPAT","HEX")>
			<cfset flashInsert(message="Type one adult (ie: 'John''), couple (ie:'John and Jane') or child (ie:'Johnny') on the left then select the appropriate registration options below before click 'Add To Cart'")>
			<cfset redirectTo(action="selectoptions")>
		<cfelse>
			<cfset flashInsert(error="Please try again.")>
			<cfset redirectTo(action="new")>
		</cfif>
	</cffunction>

	<cffunction name="getKey" output="no">
	<cfargument name="email" required="yes" type="string">
	<cfset var key="">
		<cfset key = encrypt(arguments.email,application.wheels.PasswordKey,"CFMX_COMPAT","Hex")>
	    <cfreturn key>
	</cffunction>

<!-------------------------->
<!---Authoriztion methods--->
<!-------------------------->

	<cffunction name="isSuperadmin">
		<cftry>
			<cfif not listFind(session.auth.rightslist,"superadmin")>
				<cfset redirectto(controller="home", action="loggedOut")>
				<cfabort>
			</cfif>
		<cfcatch>
				<cfset redirectto(controller="home", action="loggedOut")>
		</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="isOffice">
		<cftry>
			<cfif not gotRights("superadmin,office,handbookedit")>
				<cfset redirectto(controller="home", action="loggedOut")>
				<cfabort>
			</cfif>
		<cfcatch>
				<cfset redirectto(controller="home", action="loggedOut")>
		</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="gotAgbmRights">
			<cfif not gotRights("superadmin,agbmadmin,agbm")>
				<cfset renderText("You do not have permission to access the AGBM Membership List")>
			</cfif>
	</cffunction>

	<cffunction name="gotBasicHandbookRights">
		<cfif isDefined("params.action") and params.action is "sendHandbook">
			<cfreturn true>
		</cfif>
		<cfif gotrights("superadmin,office,handbook,agbmadmin")>
			<cfreturn true>
		</cfif>
 		<cfif isdefined("session.auth.email") and userInHandbook()>
			<cfreturn true>
		</cfif>
 		<cfif isdefined("params.email") and userInHandbook(params.email)>
			<cfreturn true>
		</cfif>
		<cfif isDefined("session.auth.handbook.basic") and session.auth.handbook.basic>
			<cfreturn true>
		</cfif>
		<cftry>
			<cfif session.auth.handbook.basic OR gotrights("superadmin,office,handbook")>
				<cfreturn true>
			<cfelse>
				<cfset redirectTo(controller="handbook.welcome", action="checkin")>
			</cfif>
		<cfcatch>
			<cfif isDefined("params.route") && params.route is "handbookPerson">
				<cfset redirectTo(route="handbookviewperson", key=params.key)>
			</cfif>
			<cfset redirectTo(controller="handbook.welcome", action="checkin")>
		</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="isPageEditor">
		<cfif gotRights("office,pageEditor")>
			<cfreturn true>
		<cfelse>
			<cfset renderText("You do have persmission to view this page")>
		</cfif>
	</cffunction>


<!----End of authorization methods---->


	<cffunction name="setOrgId">
	<cfif isDefined("session.auth.email")>
		  <cfset org = model("Handbookorganization").findAll(where="Handbookpersonemail = '#session.auth.email#'", include="Handbookposition(Handbookorganization(Handbookstate))")>
		  <cfif org.recordcount>
		  		<cfset session.auth.orgid = org.id>
		  </cfif>
	</cfif>
	</cffunction>

	<cffunction name="userInHandbook">
	<cfargument name="email" default="#session.auth.email#">
		<cfset check = model("Handbookperson").findOne(where="email = '#arguments.email#' OR email2='#arguments.email#'", include="Handbookstate")>
		<cfif isObject(check)>
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>
	</cffunction> --->

	<cffunction name="setReturn">

		<cfif not isDefined("params.ajax")>
		 <cfif params.action is "index" or params.action is "list">
			 <cfset session.listingURL = $GetCurrentURL()>
		 </cfif>
		 <cfset session.originalURL = $GetCurrentURL()>
		</cfif>

	</cffunction>

	<cffunction name="returnBack">
		<cftry>
		 <cfset var backURL = session.originalURL>
		 <cfset session.originalURL = "">

		 <cfif Len(backURL) GT 0>
			<cflocation url="#backURL#" addtoken="false">
		 <cfelse>
		 	<cfset redirectTo(argumentCollection=arguments)>
		 </cfif>
		 <cfcatch>
			 <cfset redirectTo(argumentCollection=arguments)>
		 </cfcatch>
		</cftry>

	</cffunction>

	<cffunction name="$GetCurrentURL" output="No" access="public">
	   <cfset var theURL = getPageContext().getRequest().GetRequestUrl()>
	   <cfif len( CGI.query_string )><cfset theURL = theURL & "?" & CGI.query_string></cfif>

	<cfif cgi.http_host is "localhost:8080" OR cgi.http_host is "localhost:8888">
	<cfelse>
	   <cftry>
	   	<cfset theURL = replace(theUrl,"/rewrite.cfm","","one")>
	   <cfcatch></cfcatch>
	   </cftry>
	</cfif>

	   <cfreturn theURL>
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

	<cffunction name="getActive">
		<cfargument name="category" required="true">
		<cfset var loc = structNew()>
		<cfset loc.return = "inactive">

			<cfif NOT structKeyExists(params,"key") AND category is "home">
				<cfset loc.return = "active">
			<cfelseif structKeyExists(params,"key") AND params.key is arguments.category>
				<cfset loc.return = "active">
			<cfelseif structKeyExists(params,"action") AND params.action is arguments.category>
				<cfset loc.return = "active">
			<cfelseif structKeyExists(params,"controller") AND params.controller is arguments.category>
				<cfset loc.return = "active">
			</cfif>

		<cfreturn loc.return>
	</cffunction>

	<cffunction name="logview">

		<cfreturn true>

		<cfif isDefined("params.email") and len(params.email)>
		<cfelseif isDefined("session.auth.email")>
			<cfset params.email = session.auth.email>
		<cfelse>
			<cfset params.email = "not logged in">
		</cfif>

		<cfif isDefined("params.key")>
			<cfset params.paramskey = params.key>
		</cfif>



		<cfset params.browser = cgi.http_user_agent>


		<cfif isdefined("params.key")>
			<cfset params.paramskey = params.key>
			<cfset check = model('Userview').findOne(where="email = '#params.email#' AND controller = '#params.controller#' AND action = '#params.action#' AND paramskey = '#params.key#'")>
		<cfelse>
			<cfset check = model('Userview').findOne(where="email = '#params.email#' AND controller = '#params.controller#' AND action = '#params.action#' AND paramskey IS NULL")>
		</cfif>
		<cfif not isObject(check)>

			<cfset thisview = model('Userview').create(params)>
		<cfelse>
			<cfset params.updatedAt = now()>
			<cfset test = check.update(params)>
		</cfif>
	</cffunction>

	<cffunction name="stripTags" returntype="string" access="public" output="false">
	  <cfargument name="html" type="string" required="true">
	  <cfargument name="BBCode" type="boolean" required="false" default="false">
	  <cfscript>
	    var loc = {};
	    loc.BBCode = arguments.BBCode;
	    StructDelete(arguments, "BBCode");
	    loc.returnValue = super.stripTags(argumentCollection=arguments);
	    if (loc.BBCode)
	    {
	      loc.returnValue = REReplaceNoCase(loc.returnValue, "\[img\].*\[\/img\]", "", "all");
	      loc.returnValue = REReplaceNoCase(loc.returnValue, "\[\ *[a-z].*?\]", "", "all");
	      loc.returnValue = REReplaceNoCase(loc.returnValue, "\[\ */\ *[a-z].*?\]", "", "all");
	    }
	  </cfscript>
  		<cfreturn loc.returnValue>
	</cffunction>

	<cffunction name="setDownloadLayout">
			<cfif (isdefined("params.key") && params.key is "excel") || (isdefined("params.format") && params.format is "excel")>
				<cfset renderPage(layout='/layout_download', showDebugOutput="No")>
			<cfelse>
				<cfset renderPage(layout='/layout_naked', showDebugOutput="No")>
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

	<cffunction name="logout">
		<cfset structDelete(session,"auth")>
		<cfset structDelete(session,"params")>
		<cfset redirectTo(action="index")>
	</cffunction>

	<cffunction name="BirthDayAnniversary">
	<cfargument name="personid" required="true" type="numeric">
	<cfset var loc = structNew()>
		<cfset loc.profile = model("Handbookprofile").findOne(where="personid = #arguments.personid#")>
		<cfif isObject(loc.profile)>
    		<cfset loc.return.birthday = dateformat(loc.profile.birthday,"medium")>
    		<cfset loc.return.anniversary = dateformat(loc.profile.anniversary,"medium")>
		<cfelse>
    		<cfset loc.return.birthday = "?">
    		<cfset loc.return.anniversary = "?">
		</cfif>
		<cfreturn loc.return>
	</cffunction>

	<cffunction name="isFellowshipCouncil" access="private">
		<cfif isDefined("session.auth.fellowshipcouncil") AND session.auth.fellowshipcouncil>
			<cfreturn true>
		<cfelseif gotRights("superadmin,office,fellowshipcouncil")>
			<cfreturn true>
		<cfelseif isDefined("params.fc") and params.fc>
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>
	</cffunction>

	<cffunction name="isMembershipApp">
		<cfif isDefined("session.membershipapplication.id") and session.membershipapplication.id>
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>
	</cffunction>

	<cffunction name="pauseLogin">
	<cfset var loc=	structnew()>
	<cfif isDefined("session.auth.failedLoginCount") AND session.auth.failedLoginCount GTE 7>
		<cfset loc.milliseconds = (session.auth.failedLoginCount - 7) * 1000>
		<cfset sleep(loc.milliseconds)>
	</cfif>
	</cffunction>

	<cffunction name="linkTo">
	<cfset var loc=structNew()>
	<cfset var i="">
	<cfloop list="#structKeylist(arguments)#" index="i">
		<cfset loc[replace(i,"_","-","all")] = arguments[i]>
	</cfloop>
	<cfreturn super.linkTo(argumentCollection=loc)>
	</cffunction>

	<cffunction name="linkToList">
	<cfargument name="text" default="Go Back">
	<cfset var loc=structNew()>
	<cfif isDefined("session.listingURL") and len(session.listingURL)>
		<cfset loc.text = arguments.text>
		<cfset loc.href = session.listingURL>
		<cfset session.listingURL = "">
	<cfelse>
		<cfset loc = arguments>
	</cfif>
		<cfreturn super.linkTo(argumentCollection=loc)>
	</cffunction>

	<cffunction name="startFormTag">
	<cfset var loc=structNew()>
	<cfloop list="#structKeylist(arguments)#" index="i">
		<cfset loc[replace(i,"_","-","all")] = arguments[i]>
	</cfloop>
	<cfreturn super.startFormTag(argumentCollection=loc)>
	</cffunction>

	<!---Used by Focus MVC --->

	<cffunction name="isOffice">
		<cfif gotRights("superadmin,office")>
				<cfreturn true>
		</cfif>
		<cfif isDefined("params.controller") AND params.controller contains "handbook">
			<cfreturn true>
		</cfif>
		<cftry>
			<cfif structkeyexists(session.auth,"office")>
				<cfreturn true>
			<cfelse>
				<cfreturn false>
			</cfif>

			<cfcatch>
				<cfreturn false>
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="checkOffice">
		<cfif not isoffice()>
			<cfset rendertext("You do not have permission to view this page")>
		</cfif>
	</cffunction>

	<cffunction name="getRegions">
		<cfset regions = model("Handbookdistrict").findall(order="region")>
	</cffunction>

	<cffunction name="getRetreats">
		<cfset retreats = model("Focusretreat").findAll(where="active='yes' and startAt > now()", order="startAt")>
	</cffunction>

	<cffunction name="getFocusContent">
	<cfargument name="id" required="true">
		<cfif isnumeric("arguments.id")>
			<cfset content = model("Focuscontent").findOne(where="id=#arguments.id#")>
		<cfelse>
			<cfset content = model("Focuscontent").findOne(where="name='#arguments.id#'")>
		</cfif>
		<cfif isObject(content)>
			<cfreturn content.content>
		<cfelse>
			<cfreturn "no Content">
		</cfif>
	</cffunction>

	<cffunction name="getStatus">
	<cfargument name="id" required="true">
	<cfset var status = val(arguments.id)>

		<cfif len(arguments.id) gte 2>
			<cfset status = arguments.id>
		<cfelseif status is 0>
			<cfset status = "Not Paid">
		<cfelseif status is 1>
			<cfset status = "Paid">
		<cfelseif status is 2>
			<cfset status = "Comp">
		<cfelse>
			<cfset status = "NA">
		</cfif>
		<cfreturn status>
	</cffunction>

	<cfset showRegsFor = model("Focusretreat").findAll(where="showregs = 'yes'", order="startAt DESC")>

	<cfset showOptionsFor = model("Focusretreat").findAll(where="active = 'yes'", order="startAt DESC")>

	<cffunction name="useDesktopLayout">
		<cfif isDefined("session.handbook.isMobile") and session.handbook.isMobile>
			<cfreturn false>
		<cfelseif isMobile()>
			<cfreturn false>
		<cfelse>
			<cfreturn true>
		</cfif>
	</cffunction>

	<cffunction name="isMobile">
		<cfif isDefined("session.auth.noMobile") AND session.auth.noMobile>
			<cfreturn false>
		<cfelseif isDefined("session.auth.noMobile") AND session.auth.noMobile is false>
			<cfreturn true>
		</cfif>
		<cfreturn super.isMobile()>
	</cffunction>

	<cffunction name="isLoggedIn">
	<cfset var loc = structNew()>
		<cfif isDefined("session.auth.login") AND session.auth.login>
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>
	</cffunction>

	<cffunction name="simpleEncode">
	<cfargument name="numbertoEncode" required="true" type="numeric">
	<cfargument name="factor" default=3>
	<cfset var loc=structNew()>
		<cfset loc = arguments>
		<cfset loc.return = (loc.numbertoencode * loc.factor) + loc.factor>
	<cfreturn loc.return>
	</cffunction>

	<cffunction name="simpleDecode">
	<cfargument name="numbertoDecode" required="true" type="numeric">
	<cfargument name="factor" default=3>
	<cfset var loc=structNew()>
		<cfset loc = arguments>
		<cfset loc.return = (loc.numbertoDecode-loc.factor)/loc.factor>
	<cfreturn loc.return>
	</cffunction>

	<cffunction name="isMinistryStaff">
	<cfargument name="userid" required="false">
		<cftry>
			<cfset checkForTag = model("Handbooktag").findOne(where="username IN (#application.wheels.canSetMinistryStaff#) AND itemId= #arguments.userid# AND tag='ministrystaff'")>
			<cfif isObject(checkForTag)>
				<cfreturn true>
			<cfelse>
				<cfreturn false>
			</cfif>
		<cfcatch>
			<cfreturn false>
		</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="facebookloginisopen">
		<cfif isDefined("session.auth.fblogin") AND !session.auth.fblogin>
			<cfreturn false>
		<cfelseif get("facebookloginisopen") OR isDefined("params.fblogin") or (isDefined("session.auth.fblogin") and session.auth.fblogin)>
			<cfset session.auth.fblogin = true>
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>
	</cffunction>

	<cffunction name="forcecfcatch">
		<cfif isDefined("params.forcecfcatch") OR isDefined("params.forceerror") OR isDefined("params.error")>
			<cfset test = nosuchvariable>
		</cfif>
	</cffunction>

	<cffunction name="paramsKeyRequired">
		<cfif !isDefined("params.key")>
			<cfset renderText("This page cannot display - wrong parameters")>
		</cfif>
	</cffunction>

<cfscript>

	public function isConferenceErrorEmailOn(){
		return application.wheels.sendConferenceEmailOnError;
	}

	public function isHandbookErrorEmailOn(){
		return application.wheels.sendHandbookEmailOnError;
	}

	public function paramsEmailRequired(){
		if (!isDefined("params.key")){
			renderText("This page cannot display - wrong parameters");
		}
	}

	public function removeDuplicatesFromList(list,delimiter,case=true){
		var i = 0;
		var listitem = "";
		var newlist = "";

		if(!isDefined("delimiter")){delimiter=","};
		for (i=1; i LTE listLen(list,delimiter); i=i+1){
			listItem = listGetAt(list,i,delimiter);
			if (case is true){
			if (!listFind(newlist,listitem,delimiter)){
				newlist = newlist & delimiter & listitem;
				}
			}
			else {
			if (!listFindNoCase(newlist,listitem,delimiter)){
				newlist = newlist & delimiter & listitem;
				}
			}	
		};
		return newlist;
	}

</cfscript>		

</cfcomponent>