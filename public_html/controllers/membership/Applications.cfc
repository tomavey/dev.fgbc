<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
		<cfset usesLayout(template="/membership/layout", except="about")>

		<cfset filters(through="getstates")>
		<cfset filters(through="isCheckedInOrAuthorized", except="index,checkin,update,create,resources,about,clear,show,edit")>
		<cfset filters(through="getApplication", only="step1,step2,step3,step4,step5,step6,step7")>
		<cfset filters(through="reloadLanguage,setReturn", only="checkin,step1,step2,step3,step4,step5,step6,step7,edit,show")>
		<cfset filters(through="provideChurches", only="new,edit,step7")>
	</cffunction>

	<cffunction name="getCurrentApplicationYearStart">
	<cfset var loc=structNew()>
		<cfif month(now()) LTE 7>
			<cfset loc.year = year(now())-1>
		<cfelse>
			<cfset loc.year = year(now())>
		</cfif>
		<cfset loc.return = createDate(loc.year,6,1)>
		<cfreturn loc.return>
	</cffunction>

<!---Filters--->

	<cffunction name="getStates">
		<cfset states = model("Handbookstate").findAll(order="state_mail_abbrev")>
	</cffunction>

	<cffunction name="getApplication">
		<!--- Find the record --->
    	<cfset membershipapplication = model("Membershipapplication").findByKey(session.membershipapplication.id)>
	</cffunction>

	<cffunction name="provideChurches">
		<cfset churches = model("Handbookorganization").findall(where="statusId IN (1,4,2,8,9)", include="State", order="selectNameCity")>
	</cffunction>

	<cffunction name="isCheckedInOrAuthorized">

		<cfif isDefined("session.membershipapplication.id") OR
			isFellowshipCouncil()>
		<cfelse>
			<cfset redirectTo(action="checkin")>
		</cfif>

	</cffunction>

	<cffunction name="reloadLanguage">
		<cfif isDefined("params.language")>
			<cfset session.membershipapplication.language = params.language>
		<cfelseif NOT isDefined("session.membershipapplication.language")>
			<cfset session.membershipapplication.language = "English">
		</cfif>
	</cffunction>

<!---Basic CRUD--->

	<!--- -membershipapplications/index --->
	<cffunction name="index">
	<cfif isDefined("params.showall")>
		<cfset whereString = "">
	<cfelse>
		<cfset whereString = "createdAt > '#getCurrentApplicationYearStart()#'">
	</cfif>
		<cfset membershipapplications = model("Membershipapplication").findAll(where=whereString, order="createdAt DESC")>
	</cffunction>

	<!--- -membershipapplications/show/key --->
	<cffunction name="show">

		<!--- Find the record --->
		<cfset membershipapplication = model("Membershipapplication").findApp(params.key)>
		<cfset membershipapplicationresources = model("Membershipappresource").findAll(where="applicationid = #membershipapplication.id#")>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(membershipapplication)>
	        <cfset flashInsert(error="Membership application #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>

		<cfif NOT isDefined("session.membershipapplication.id") AND NOT
			isFellowshipCouncil()>
			<cfset showButtons=false>
			<cfset renderPage(layout="/membership/layout_no_navbar")>
		<cfelse>
			<cfset showButtons=true>
		</cfif>

	</cffunction>

	<!--- -membershipapplications/new --->
	<cffunction name="new">
		<cfset membershipapplication = model("Membershipapplication").new()>
	</cffunction>

	<cffunction name="step1">
	</cffunction>
	<cffunction name="step2">
	</cffunction>
	<cffunction name="step3">
	</cffunction>
	<cffunction name="step4">
	</cffunction>
	<cffunction name="step5">
	</cffunction>
	<cffunction name="step6">
	</cffunction>
	<cffunction name="step7">
	</cffunction>

	<!--- -membershipapplications/edit/key --->
	<cffunction name="edit">

		<cfif not isDefined("params.key")>
			<cfset params.key = session.membershipapplication.id>
		</cfif>

		<!--- Find the record --->
		<cfset membershipapplication = model("Membershipapplication").findApp(params.key)>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(membershipapplication)>
	        <cfset flashInsert(error="Membershipapplication #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

	<!--- -membershipapplications/create --->
	<cffunction name="create">
		<cfif len(params.membershipapplication.captcha) AND
			params.membershipapplication.captcha is decrypt(params.membershipapplication.captcha_check,application.wheels.passwordkey,"CFMX_COMPAT","HEX")>

		<cfelse>
			<cfset flashInsert(error="Please enter the text from the image again.")>
			<cfset redirectTo(action="checkin")>
		</cfif>

		<cfset membershipapplication = model("Membershipapplication").new(params.membershipapplication)>

		<cfset membershipapplication.uuid = createuuid()>

		<!--- Verify that the membershipapplication creates successfully --->
		<cfif membershipapplication.save()>
			<cfset flashInsert(success="The empty membership application was created successfully.")>
			<cfset checkinApp(membershipapplication)>
			<cfset session.membershipapplication.step = 1>
			<cfset sendEmailAtStart("#session.membershipapplication.email#,tomavey@fgbc.org",session.membershipapplication.uuid)>
            <cfset redirectTo(action="step1")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the membershipapplication.")>
			<cfset renderPage(action="checkin")>
		</cfif>
	</cffunction>

	<!--- -membershipapplications/update --->
	<cffunction name="update">

		<cfset membershipapplication = model("Membershipapplication").findApp(params.key)>

		<!--- Verify that the membershipapplication updates successfully --->
		<cfif membershipapplication.update(params.membershipapplication)>
			<cfset session.membershipapplication.email = membershipapplication.useremail>

			<cfset flashInsert(success="Your membership application was updated successfully.")>
			<cfif isDefined("params.nextstep")>
    	        <cfset redirectTo(action=params.nextstep)>
    	    <cfelse>
    	        <cfset redirectTo(action="show", key='#params.key#')>
    	    </cfif>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the membershipapplication.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>

	<!--- -membershipapplications/delete/key --->
	<cffunction name="delete">

		<cfset membershipapplication = model("Membershipapplication").findApp(params.key)>

		<!--- Verify that the membershipapplication deletes successfully --->
		<cfif membershipapplication.delete()>
			<cfset flashInsert(success="The membershipapplication was deleted successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the membershipapplication.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>


<!---Specialized CRUD--->

	<cffunction name="checkin">
		<cfif isDefined("params.key")>
			<cfset membershipapplication = model("Membershipapplication").findApp(params.key)>
			<cfset checkinApp(membershipapplication)>
			<cfset redirectTo(controller="membership.applications", action="show", key=params.key)>
		<cfelse>
			<cfset membershipapplication = model("Membershipapplication").new()>
			<cfset membershipapplication.captcha = "">
			<cfset membershipapplication.strCaptcha = getStrCaptcha()>
			<cfset membershipapplication.captcha_check = encrypt(membershipapplication.strCaptcha,application.wheels.passwordkey,'CFMX_COMPAT','HEX')>
			<cfif isDefined("session.membershipapplication.language")>
				<cfset membershipapplication.language = session.membershipapplication.language>
			</cfif>
		</cfif>
	</cffunction>

	<cffunction name="search">
		<cfset membershipapplications = model("Membershipapplication").findApps(params.search)>
		<cfset renderPage(action="index")>
	</cffunction>
<!---Security functions--->

	<cffunction name="clear">
		<cfset structDelete(session,"membershipapplication")>
		<cfset structDelete(session,"auth")>
		<cfset redirectTo(action="index")>
	</cffunction>

	<cffunction name="checkinApp" access="private">
	<cfargument name="membershipapplication" required="true" type="object">
			<cfset session.membershipapplication.uuid = membershipapplication.uuid>
			<cfset session.membershipapplication.id = membershipapplication.id>
			<cfset session.membershipapplication.email = membershipapplication.useremail>
			<cfset session.membershipapplication.language = membershipapplication.language>
	<cfreturn true>
	</cffunction>

	<cffunction name="sendEmailAtStart" access="private">
	<cfargument name="emailaddresses" required="true" type="string">
	<cfargument name="applicationuuid" required="true" type="string">

	<cfloop list="#arguments.emailaddresses#" index="i">
		<cfset sendEmail(from="tomavey@fgbc.org", to=i, subject="FGBC Membership Application", template="sendEmailAtStart", layout="/membership/layout_naked", applicationuuid=arguments.applicationuuid)>
	</cfloop>

		<cfset sendEmail(from="tomavey@fgbc.org", to="tomavey9173@gmail.com", subject="A New FGBC Membership Application", template="sendEmailAtStart", layout="/membership/layout_naked", applicationuuid=arguments.applicationuuid)>

	</cffunction>

	<cffunction name="testSendEmailAtStart">
		<cfset sendEmailAtStart("tomavey9173@gmail.com","123")>
		<cfset renderPage(template="sendEmailAtStart")>
	</cffunction>

</cfcomponent>
