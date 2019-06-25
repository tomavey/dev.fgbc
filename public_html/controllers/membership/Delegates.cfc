<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
		<cfset usesLayout("layout")>
		<cfset filters(through="getChurch", only="show,create,new,email")>
		<cfset filters(through="getChurches", only="getChurchId,delinquent")>
		<cfset filters(through="setReturn", only="show")>
		<cfset filters(through="setDelegateYear")>
		<cfset filters(through="officeOnly", only="index")>
	</cffunction>

<!---Filters--->

<cfscript>

	private function setDelegateYear () {
		delegateYear = getDelegateYear();
	}

	private function officeOnly() {
		if (!gotRights("office")) { renderText('You do not have permission to access this page!') }
	}

</cfscript>

	<cffunction name="getChurch" access="private">

		<cfif isDefined("params.churchid")>
			<cfset params.key = params.churchid>
		</cfif>

		<cfif isDefined("params.key")>
			<cfset session.delegate.churchid = params.key>
		</cfif>


		<cfset church = model("Handbookorganization").findOne(where='id=#val(session.delegate.churchid)#', include='Handbookstate')>

		<cfset church.delegatecount = getDelegatesStatus(val(session.delegate.churchid)).delegates>
		<cfset church.wereStatSubmitted = getDelegatesStatus(val(session.delegate.churchid)).statsReturned>


		<cfif NOT church.delegatecount>
			<cfset redirectTo(action="needStats", key=val(session.delegate.churchid))>
		</cfif>
	</cffunction>

	<cffunction name="getChurches" access="private">
		<cfset churches = model("Handbookorganization").findAll(where="statusid = 1", include="Handbookstate", order="org_city,state_mail_abbrev")>
	</cffunction>

	<cffunction name="getLeaderEmail">
	<cfargument name="churchid" required="true" type="numeric">
		<cfset leader = model("Handbookposition").findAll(where="organizationid = #arguments.churchid# AND p_sortorder = 1", include="Handbookperson(Handbookstate)")>
		<cfif leader.recordcount and len(leader.email)>
		    <cfreturn leader.email>
		<cfelse>
     		<cfreturn false>
		</cfif>
	</cffunction>

	<cffunction name="getGtdEmail">
	<cfargument name="churchid" required="true" type="numeric">
		<cfset leader = model("Handbookposition").findAll(where="organizationid = #arguments.churchid# AND gtd = 'Yes'", include="Handbookperson(Handbookstate)")>
		<cfif leader.recordcount and len(leader.email)>
		    <cfreturn leader.email>
		<cfelse>
     		<cfreturn false>
		</cfif>
	</cffunction>

	<cffunction name="getDelegateYear">
		<cfreturn getSetting("delegateYear")>
	</cffunction>

	<cffunction name="churchHasSubmittedDelegates">
	<cfargument name="churchid" required="true" type="numeric">

    	<cfset church = model("Fgbcdelegate").findOne(where="churchid=#arguments.churchid# AND year ='#delegateYear#'")>

    	<cfif isObject(church)>
    	    <cfreturn true>
    	<cfelse>
    		<cfreturn false>
    	</cfif>

	</cffunction>

	<!---fgbcdelegates/getChurchId--->
	<cffunction name="getChurchid">
		<cftry>
			<cfset structDelete(session,"delegate")>
		<cfcatch></cfcatch></cftry>
	</cffunction>

	<!--- fgbcdelegates/index --->
	<cffunction name="index">
		<cfset setReturn()>
		<cfset structDelete(session,"delegate")>
		<cfif isDefined("params.year")>
			<cfset whereString = "year = '#params.year#'">
		<cfelse>
			<cfset whereString = "year = '#delegateYear#'">
		</cfif>
		<cfset fgbcdelegates = model("Fgbcdelegate").findAll(where=whereString, include="Handbookorganization(Handbookstate)", order="selectnamecity")>
	</cffunction>

	<cffunction name="downloadDelegates">
		<cfset fgbcdelegates = model("Fgbcdelegate").findAll(where="year = '#delegateYear#'", include="Handbookorganization(Handbookstate)", order="name")>
		<cfset renderPage(layout="/layout_download")>
	</cffunction>

	<!--- fgbcdelegates/show/key --->
	<cffunction name="show">

		<!--- Find the record --->
    	<cfset delegates = model("Fgbcdelegate").findAll(where="churchId=#val(session.delegate.churchid)# AND year = '#delegateYear#'")>

    	<!--- Check if the record exists --->
	    <cfif NOT delegates.recordcount>
	        <cfset flashInsert(error="No delegates have been set yet.")>
	        <cfset redirectTo(action="submit", key=params.key)>
	    </cfif>

	</cffunction>

	<!--- fgbcdelegates/email/key --->
	<cffunction name="email">

		<!--- Find the record --->
    	<cfset delegates = model("Fgbcdelegate").findAll(where="churchId=#val(session.delegate.churchid)# AND year = '#delegateYear#'")>

    	<!--- Check if the record exists --->
	    <cfif NOT delegates.recordcount>
	        <cfset flashInsert(error="No delegates have been set yet.")>
	        <cfset redirectTo(action="show")>
	    </cfif>

	    <cfif isDefined("delegates.submitteremail")>
		    <cfset sendEmail(template="email", to=delegates.submitteremail, from="tomavey@fgbc.org", cc="tomavey@fgbc.org", subject="Your FGBC Delegates")>
	    <cfelse>
		    <cfset sendEmail(template="email", to="tomavey@fgbc.org", from="tomavey@fgbc.org", subject=" FGBC Delegates")>
	    </cfif>

		<cfset renderPage(controller="membership.delegates", action="thankyou")>

	</cffunction>

	<cffunction name="closed">
		<cfset renderPage(layout="closed")>
	</cffunction>

	<!--- fgbcdelegates/new --->
	<cffunction name="submit">

		<cfset var deadline = getSetting('delegatesSubmitDeadline') & '-' & year(now())>

		<cfif !isBefore(deadline)>
			<cfset redirectTo(action="closed")>
			<cfabort>
		</cfif>

		<cfif isDefined("params.captcha") && params.captcha NEQ "5">
			  <cfset flashInsert(error='Please input the number of characters in the word "Grace"')>
			  <cfset redirectTo(action="getChurchid")>
		</cfif>

		<cfif isDefined("params.churchid")>
			<cfset params.key = params.churchid>
		</cfif>	

		<cfif not isDefined("params.key") or params.key is "0">
			  <cfset flashInsert(error="Please select your church from the drop-down list")>
			  <cfset redirectTo(action="getChurchid")>
		</cfif>

		<cfset church = model("Handbookorganization").findOne(where="id=#params.key#", include="Handbookstate")>
		<cfset church.delegatecount = getDelegatesAllowed(params.key)>
		<cfset church.wereStatSubmitted = getDelegatesStatus(params.key).statsReturned>
		<cfset fgbcdelegate = model("Fgbcdelegate").new()>
		<cfset fgbcdelegate.status = "active">
		<cfset fgbcdelegate.year = delegateYear>

		<cfloop from="1" to="#church.delegatecount#" index="i">
			<cfset fgbcdelegate.name[i] = "">
			<cfset fgbcdelegate.email[i] = "">
		</cfloop>
		<cfif isdefined("params.key") and val(params.key)>
			<cfset session.delegate.churchid = params.key>
		</cfif>
		<cfset fgbcdelegate.churchid = val(session.delegate.churchid)>

	</cffunction>

	<!--- fgbcdelegates/edit/key --->
	<cffunction name="edit">

		<!--- Find the record --->
    	<cfset fgbcdelegate = model("Fgbcdelegate").findByKey(params.key)>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(fgbcdelegate)>
	        <cfset flashInsert(error="Fgbcdelegate #params.key# was not found")>
			<cfset redirectTo(action="show")>
	    </cfif>

	</cffunction>

	<!--- fgbcdelegates/new/key --->
	<cffunction name="new">

		<!--- Find the record --->
    	<cfset fgbcdelegate = model("Fgbcdelegate").new()>
		<cfset fgbcdelegate.churchid = val(session.delegate.churchid)>
		<cfset fgbcdelegate.status = "active">
		<cfset fgbcdelegate.year = delegateYear>

		<cfset submitter = model("Fgbcdelegate").findOne(where="churchid=#val(session.delegate.churchid)#")>
		<cfif isObject(submitter)>
			<cfset fgbcdelegate.submitter = submitter.submitter>
			<cfset fgbcdelegate.submitteremail = submitter.submitteremail>
		<cfelse>
			<cfset redirectTo(action="submit")>
		</cfif>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(fgbcdelegate)>
	        <cfset flashInsert(error="Fgbcdelegate #params.key# was not found")>
			<cfset redirectTo(action="show")>
	    </cfif>

	</cffunction>

	<!--- fgbcdelegates/new/key --->
	<cffunction name="addnewdelegate">

		<!--- Find the record --->
    	<cfset fgbcdelegate = model("Fgbcdelegate").new()>
		<cfset fgbcdelegate.churchid = val(session.delegate.churchid)>
		<cfset fgbcdelegate.status = "active">
		<cfset fgbcdelegate.year = delegateYear>

		<cfset submitter = model("Fgbcdelegate").findOne(where="churchid=#val(session.delegate.churchid)#")>
		<cfif isObject(submitter)>
			<cfset fgbcdelegate.submitter = submitter.submitter>
			<cfset fgbcdelegate.submitteremail = submitter.submitteremail>
		<cfelse>
			<cfset redirectTo(action="submit")>
		</cfif>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(fgbcdelegate)>
	        <cfset flashInsert(error="Fgbcdelegate #params.key# was not found")>
			<cfset redirectTo(action="show")>
	    </cfif>

	</cffunction>

	<!--- fgbcdelegates/updateSubmitter --->
	<cffunction name="updateSubmitter">
		<cfset submitter = model("Fgbcdelegate").findAll(where="churchid=#val(session.delegate.churchid)# AND status = 'Active'")>
		<cfloop query="submitter">
			<cfset thissubmitter = model("Fgbcdelegate").findOne(where="id=#id#")>
			<cfset thissubmitter.update(params)>
		</cfloop>
		<cfset returnBack()>
	</cffunction>


	<!--- fgbcdelegates/create --->
	<cffunction name="create">
	<cfset var atLeastOneDelegate = 0>

		<cfif not len(params.fgbcdelegate.submitter) or not len(params.fgbcdelegate.submitteremail)>
			<cfset flashInsert(success="Please provide your name and email.")>
	            <cfset redirectTo(action="submit", params="key=#params.fgbcdelegate.churchid#")>
		</cfif>

		<cfif isDefined("params.nodelegates") AND params.nodelegates>
			<cfset params.fgbcdelegatename[1] = "No delegates this year!">
		</cfif>

		<!---loop through the total number of delegates allowed--->
		<cfloop from="1" to="#params.delegatecount#" index="i">
			<!---check and make sure the name field has been filled--->
			<cfif len(params.fgbcdelegatename[i])>
				<cfset atLeastOneDelegate = 1>
				<!---Set up properties to be saved--->
				<cfset params.fgbcdelegate.name = params.fgbcdelegatename[i]>
				<cfset params.fgbcdelegate.email = params.fgbcdelegateemail[i]>
				<cfset fgbcdelegate = model("Fgbcdelegate").new(params.fgbcdelegate)>

				<!--- Verify that the fgbcdelegate creates successfully --->
				<cfif NOT fgbcdelegate.save()>
					<cfset flashInsert(error="There was an error creating the fgbcdelegate.")>
					<cfset renderPage(action="submit", key=params.key)>
				</cfif>
			</cfif>
		</cfloop>

		<cfif atLeastOneDelegate>
			<cfset flashInsert(success="The FGBC delegate form was created successfully.")>
            <cfset redirectTo(action="show", key=params.key)>
		<cfelse>
			<cfset flashInsert(success="Please Provide at least one delegate name.")>
            <cfset redirectTo(action="submit")>
		</cfif>

	</cffunction>

	<!--- fgbcdelegates/createOne --->
	<cffunction name="createOne">
		<cfset delegate = model("Fgbcdelegate").new(params.fgbcdelegate)>

		<cfif delegate.save()>
			<cfset flashInsert(success="The new delegate was created successfully.")>
			<cfset returnBack()>
		<cfelse>
			<cfset flashInsert(success="The delegate was NOT created successfully.")>
			<cfset redirectTo(action="show")>
		</cfif>

	</cffunction>


	<!--- fgbcdelegates/update --->
	<cffunction name="update">
		<cfset fgbcdelegate = model("Fgbcdelegate").findByKey(params.key)>

		<!--- Verify that the fgbcdelegate updates successfully --->
		<cfif fgbcdelegate.update(params.fgbcdelegate)>
			<cfset flashInsert(success="The fgbcdelegate was updated successfully.")>
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the fgbcdelegate.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>

	<!--- fgbcdelegates/delete/key --->
	<cffunction name="delete">
		<cfset fgbcdelegate = model("Fgbcdelegate").findByKey(params.key)>

		<!--- Verify that the fgbcdelegate deletes successfully --->
		<cfif fgbcdelegate.delete()>
			<cfset flashInsert(success="The delegate was deleted successfully.")>
            <cfset redirectTo(back=true)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the fgbcdelegate.")>
			<cfset redirectTo(back=true)>
		</cfif>
	</cffunction>

	<!--- fgbcdelegates/getDelegatesAllowed --->
	<cffunction name="getDelegatesStatus">
	<cfargument name="churchid" required="true" type="numeric">
	<cfset var thisyear = val(getDelegateYear())-1>
	<cfset var loc = structNew()>
	<cfset loc.delegates = 0>
	<cfset loc.statsReturned = "False">
		<cfset var church = model("Handbookstatistic").findOne(where="organizationid = #arguments.churchid# AND year = '#thisyear#'")>
		<cfif isObject(church)>
			<cfset loc.statsReturned = "true">
			<cfset church.att = val(church.att)>
			<cfset loc.delegates = 2>
			<cfif church.att GT 50>
				<cfset loc.delegates = 3>
			</cfif>
			<cfif church.att GT 100>
				<cfset loc.delegates = 5>
			</cfif>
			<cfif church.att GT 200>
				<cfset loc.delegates = 10>
			</cfif>
			<cfif church.att GT 300>
				<cfset loc.delegates = 20>
			</cfif>
			<cfif church.att GT 500>
				<cfset loc.delegates = 25>
			</cfif>
			<cfif church.att GT 1000>
				<cfset delegates = 30>
			</cfif>
			<cfif church.att GT 2000>
				<cfset delegates = 35>
			</cfif>

		<cfelse>
			<cfset loc.statsReturned = "false">
			<cfset loc.delegates=0>
		</cfif>

		<cfreturn loc>
	</cffunction>

	<cffunction name="getDelegatesAllowed">
	<cfargument name="churchid" required="true" type="numeric">
		<cfset var return = getDelegatesStatus(arguments.churchid).delegates>
	<cfreturn return>
	</cffunction>

	<cffunction name="testGetDelegatesAllowed">
	<cfargument name="churchid" default="#params.key#">
	<cfset test = GetDelegatesAllowed(arguments.churchid)>
	<cfdump var="#test#"><cfabort>
	</cffunction>

	<cffunction name="welcome">
		<cfset renderPage(layout="layout_naked")>
	</cffunction>

	<cffunction name="checkChurchAndEmail">
	<cfargument name="churchid" required="true" type="numeric">
	<cfargument name="email" required="true" type="numeric">
	</cffunction>

	<!--- fgbcdelegates/testGetDelegatesAllowed --->
	<cffunction name="testGetDelegatesAllowed">
		<cfset test = getDelegatesAllowed(params.key)>
		<cfdump var="#test#"><cfabort>
	</cffunction>

	<!--- fgbcdelegates/deleteAll --->
	<cffunction name="deleteAll">
		<cfset model("Fgbcdelegate").deleteAll(where="churchid=#params.key# AND status='active'")>
		<cfset redirectTo(action="submit", key=params.key)>
	</cffunction>

	<!--- fgbcdelegates/clearChurchId --->
	<cffunction name="clearChurchId">
		<cfset structDelete(session,"delegate")>
		<cfset rendertext("session cleared")>
	</cffunction>

	<!--- fgbcdelegates/needStats --->
	<cffunction name="needStats">
		<cfset church = model("Handbookorganization").findOne(where="id=#params.key#", include="Handbookstate")>
	</cffunction>

	<cffunction name="delinquent">
		<cfif isDefined("params.download")>
		  <cfset renderPage(layout="/layout_download")>
		</cfif>
	</cffunction>

	<cffunction name="getEmails">
		<cfset delegates = model("Fgbcdelegate").findAll(where="name does not contain 'delegates'", include="Handbookorganization")>
		<cfdump var="#delegates#"><cfabort>
	</cffunction>

	<cffunction name="markchurchpickedup">
	<cfargument name="churchid" default="#params.key#">
	<cfset delegates = model("Fgbcdelegate").findAll(where="churchid = #arguments.churchid#")>
	<cfloop query="delegates">
		<cfset thisdelegate = model("Fgbcdelegate").findOne(where="id=#id#")>
		<cfif thisdelegate.status is "active">
			<cfset thisdelegate.status = "picked up">
		<cfelse>
			<cfset thisdelegate.status = "active">
		</cfif>
		<cfset thisdelegate.update()>
	</cfloop>
	<cfset redirectTo(back=true)>
	</cffunction>

	<cffunction name="markpickedup">
	<cfargument name="id" default="#params.key#">
		<cfset thisdelegate = model("Fgbcdelegate").findOne(where="id=#arguments.id#")>
		<cfif thisdelegate.status is "active">
			<cfset thisdelegate.status = "picked up">
		<cfelse>
			<cfset thisdelegate.status = "active">
		</cfif>
		<cfset thisdelegate.update()>
	<cfset redirectTo(back=true)>
	</cffunction>

</cfcomponent>
