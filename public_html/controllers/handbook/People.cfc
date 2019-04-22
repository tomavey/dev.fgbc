<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
		<cfset usesLayout("/handbook/layout_handbook")>
		<cfset filters(through="gotBasicHandbookRights,getStates,getPositionTypes,logview", except="focus,sendhandbook,view,inspire")>
		<cfset filters(through="getPositions", only="edit,show,view")>
		<cfset filters(through="getChurches", only="new,edit,create,update")>
		<cfset filters(through="setReturn", only="show,bluepages,distribution")>
		<cfset filters(through="setIsAgbmAdmin")>
	</cffunction>

<!---Filters--->
	<cffunction name="getStates">
		<cfset states = model("Handbookstate").findall(order="state")>
	</cffunction>

	<cffunction name="getPositions">
		<cfif gotrights("superadmin,agbmadmin")>
			<cfset positions = model("Handbookposition").findAll(where="personid=#params.key#", include="Handbookorganization(Handbookstate)", order="p_sortorder")>
		<cfelse>
			<cfset positions = model("Handbookposition").findAll(where="personid=#params.key# AND positionTypeId <> 32 AND position NOT LIKE '%Remove%'", include="Handbookorganization(Handbookstate)", order="p_sortorder")>
		</cfif>
	</cffunction>

	<cffunction name="getPositionTypes">
		<cfset positionTypes = model("Handbookpositiontype").findall(order="position")>
	</cffunction>

	<cffunction name="getChurches">
		<cfset churches = model("Handbookorganization").findall(where="show_in_handbook = 'yes'", include="Handbookstatus,Handbookstate", order="org_city,state,name")>
	</cffunction>

	<cffunction name="setIsAgbmAdmin">
		<cfif isDefined("params.agbm")>
			<cfset isAgbmAdmin = true>
			<cfset session.handbook.agbmnew = true>
		<cfelseif isDefined("session.handbook.agbmnew") and session.handbook.agbmnew>
			<cfset isAgbmAdmin = true>
		<cfelse>
			<cfset isAgbmAdmin = false>
		</cfif>
	</cffunction>

<!---End of Filters--->

<!-------------------------->
<!-----view controllers----->
<!-------------------------->

	<!--- route="handbookPeople" pattern="handbook/people" --->
	<cffunction name="index">
		<cfset allHandbookPeople = model("Handbookperson").findAll(where="p_sortorder < #getNonStaffSortOrder()+1#", order="alpha", include="Handbookstate,Handbookpositions")>
		<cfset handbookPeople = model("Handbookperson").findHandbookPeople(params)>
	</cffunction>


	<!--- route="handbookPerson" pattern="handbook/person/[key]" handbookpeople/show/key --->
	<cffunction name="show">

	<cftry>

   	<cfset handbookperson = model("Handbookperson").findOne(where="id=#params.key#", include="Handbookstate,Handbookprofile,Handbookpictures,Handbooknotes")>
		<cfset tags=model("Handbooktag").findMyTagsForId(params.key,"person")>

	<cfif gotrights("agbm,office,superadmin,agbmadmin")>
		<!---Set up new form for groups within the show report--->
			<cfset handbookGroup = model("Handbookgroup").new()>
			<cfset handbookGroup.personId = params.key>
			<cfset allgroups = model("Handbookgrouptype").findAll(order="title")>
			<cfset groups = model("Handbookgroup").findAll(where="personid=#params.key#", include="handbookGroupType")>
	</cfif>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(handbookperson)>
	        <cfset flashInsert(error="Handbookperson #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>

		<cfif isdefined("params.ajax")>
			<cfset renderPartial("show")>
		</cfif>

	<cfcatch>
		<cfset #sendPersonPageErrorNotice()#>
	        	<cfset redirectTo(action="index", error="Oops! Something went wrong try to access this person.  We are working on a solution. You should be able to continue from this page.")>
	</cfcatch>
	</cftry>

	</cffunction>

	<!---route="handbookViewperson", pattern="/handbook/people/[key]"---->
	<cffunction name="view">
		<cfset handbookperson = model("Handbookperson").findOne(where="id=#params.key#", include="State,Handbookpositions,Handbookpictures")>
		<cfif handbookperson.private is "yes">
			<cfset redirectTo(action="index")>
		</cfif>
		<cfset renderPage(layout="/handbook/layout_handbook2")>
	</cffunction>

	<cffunction name="inspire">
		<cfset renderPage(layout="/handbook/layout_handbook_vue")>
	</cffunction>

	<!---route="handbookVcard", pattern=pattern="/people/vcard/[key]"--->
	<cffunction name="vcard">
    	<cfset handbookperson = model("Handbookperson").findByKey(key=params.key, include="Handbookstate,Handbookprofile,Handbookpictures,Handbooknotes")>
		<cfsavecontent variable="vcard">
			<cfoutput>
			<cfcontent type="text/x-vCard">
			<cfheader name="Content-Disposition" value="inline; filename=newPerson.vcf">
			BEGIN:VCARD
			VERSION:3.0
			N;charset=iso-8859-1:#handbookperson.lname#;#handbookperson.fname#
			BDAY;value=date:#handbookperson.handbookprofile.birthdayasstring#
			EMAIL;type=HOME:#handbookperson.email#
			ADR;type=WORK;charset=iso-8859-1:;;#handbookperson.address1#;#handbookperson.address2#;#handbookperson.city#;#handbookperson.state_mail_abbrev#;#handbookperson.zip#
			TEL;type=HOME:#handbookperson.phone#
			END:VCARD
			</cfoutput>
		</cfsavecontent>
		<cfset renderText(vcard)>
	</cffunction>

	<!--- "newHandbookPerson" /handbook/people/new --->
	<cffunction name="new">
	<cfset var loc = structNew()>
		<cfset loc.newposition = [ model("Handbookposition").new() ]>
		<cfset loc.newprofile = model("Handbookprofile").new()>

		<cfset handbookperson = model("Handbookperson").new(handbookpositions = loc.newposition, handbookprofile=loc.newprofile)>

		<!---Set up organizationid if provided in key--->
		<cfif isDefined("params.key")>
			  <cfset handbookperson.handbookpositions[1].organizationid = params.key>
		</cfif>

		<!---Set the default sortorder or use sortorder provided in params is exists--->
		<cfif isDefined("params.sortorder")>
			  <cfset handbookperson.handbookpositions[1].p_sortorder = params.sortorder>
		<cfelse>
			  <cfset handbookperson.handbookpositions[1].p_sortorder = #getNonStaffSortOrder()#>
		</cfif>

		<cfif isAgbmAdmin>
			  <cfset handbookperson.handbookpositions[1].p_sortorder = #getNonStaffSortOrder()#>
			  <cfset handbookperson.handbookpositions[1].position = "AGBM Only">
			  <cfset handbookperson.handbookpositions[1].positiontypeid = 32>
		</cfif>

		<cfif isDefined("params.organizationid")>
				<cfset handbookperson.handbookpositions[1].organizationid = params.organizationid>	
		</cfif>

		<cfset renderPage(layout="/handbook/layout_handbook1.cfm")>

	</cffunction>

	<!---"editHandbookPerson" /handbook/people/[key]/edit --->
	<cffunction name="edit">
	<cfset var profile = "">

		<!--- Find the record --->
    	<cfset handbookperson = model("Handbookperson").findByKey(key=params.key, include="Handbookstate,Handbookpositions,Handbookprofile")>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(handbookperson)>
	        <cfset flashInsert(error="HandbookPerson #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>

		<cfset renderPage(layout="/handbook/layout_handbook2.cfm")>

	</cffunction>

<!--------------------------->
<!-----model controllers----->
<!--------------------------->

	<!--- handbookPeople	POST	/handbook/people --->
	<cffunction name="create">

		<cfset handbookperson = model("Handbookperson").new(params.handbookperson)>

		<cfif !len(handbookperson.stateid)>
			<cfset handbookperson.stateid = 60>
		</cfif>	

		<!--- Verify that the handbookperson creates successfully --->

		<cfif handbookperson.save()>
			<cfset flashInsert(success="The handbookperson was created successfully.")>
			<cfif isAgbmAdmin>
				<cfset redirectTo(route="handbookAddAGBMPayment", key=handbookperson.id)>
			<cfelse>
				<cfset returnBack("show")>
			</cfif>

		<!--- Otherwise --->
		<cfelse>
			<cfset errors=handbookperson.handbookpositions[1].allerrors()>
			<cfset flashInsert(error="There was an error creating this staff person. Check to make sure you selected the correct church or ministry and that you selected a state.")>
			<cfset renderPage(action="new", layout="/handbook/layout_handbook2.cfm")>
		</cfif>


	</cffunction>

	<!--- handbookPerson	PUT	/handbook/people/[key] --->
	<cffunction name="update">

		<!---Check to see if there is a profile record for this person and create one if not--->
		<cfset handbookprofile = model("Handbookprofile").findOne(where='personid = #params.key#')>

		<cfif NOT isObject(handbookprofile)>
			  <cfset handbookprofile = model("Handbookprofile").new(params.handbookperson.handbookprofile)>

			  <cfset handbookprofile.personid = params.key>

			  <cfif handbookprofile.save()>
			  		<cfset flashInsert(success="The profile was created successfully.")>
			  <cfelse>
			  		<cfset flashInsert(success="The profile was NOT created.")>
			  </cfif>
		</cfif>

		<cfset handbookperson = model("Handbookperson").findByKey(key=params.key, include="Handbookstate,Handbookprofile,Handbookpositions")>

		<!--- Verify that the handbookperson updates successfully --->
		<cfif handbookperson.update(params.handbookperson)>
			<cfset errors = handbookperson.handbookprofile.allerrors()>
			<cfset flashInsert(success="This person was updated successfully.")>
			<cftry>
				<cfif $SendImmediatePersonUpdates()>
					<cfset sendEmail(
						to=application.wheels.HandbookProfileSecretary,
						from="tomavey@fgbc.org",
						subject="Person Update",
						layout="/layout_naked",
						template="/handbook/updates/notices"
						)>
				</cfif>		
					<cfset flashInsert(success="This person was updated successfully!")>
				<cfcatch></cfcatch>
			</cftry>
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset errors = handbookperson.handbookprofile.allerrors()>
			<cfset flashInsert(error="There was an error updating this person.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>

	<!--- handbookPerson	DELETE	/handbook/people/[key] --->
	<cffunction name="delete">
		<cfset handbookperson = model("Handbookperson").findByKey(key=params.key, include="HandbookState,Handbookpositions")>
		<cfset profilesDeleted = model("Handbookprofile").deleteAll(where="personid=#params.key#")>
		<cfset picturesDeleted = model("Handbookpicture").deleteAll(where="personid=#params.key#")>
		<!--- Verify that the handbookperson deletes successfully --->
		<cfif handbookperson.delete()>
			<cfset flashInsert(success="The handbookperson was deleted successfully.")>
			<cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the handbookperson.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>

<!---End of Basic CRUD--->

<!---Special reports--->

	<cffunction name="downloadStaff">
		<cfset allHandbookPeople = model("Handbookperson").findAll(where="p_sortorder <= #getNonStaffSortOrder()#", include="Handbookstate,Handbookpositions(Handbookorganization(Handbookdistrict))", order="lname,fname")>
		<cfset setDownloadLayout()>
	</cffunction>

	<cffunction name="handbookInfo">
		<cfif isDefined("params.key")>
			<cfset people = model("Handbookperson").findall(where="organizationid='#params.key#' AND p_sortorder < #getNonStaffSortOrder()#", include="Handbookpositions,Handbookstate", order="lname,fname")>
		<cfelse>
			<cfset people = model("Handbookperson").findall(where="p_sortorder < #getNonStaffSortOrder()#", include="Handbookpositions,Handbookstate", order="lname,fname")>
		</cfif>
		<cfset renderPage(layout="/layout_naked")>
	</cffunction>

	<!---handbookBluepages	GET	/handbook/people/bluepages--->
	<cffunction name="bluepages">
		<cfset includeString = "Handbookstate,Handbookpositions(Handbookorganization(District))">
		<cfset orderString = "lname,fname,id">
		<cfset whereString = " AND statusid in (1,8,3,4,2,9,10,11)">

		<!---Build WhereString based on params--->
			<cfif NOT isDefined("params.showremoved")>
				<cfset whereString = whereString & " AND position NOT LIKE '%Removed%'">
			</cfif>
			<cfif isDefined("params.nonstaff")>
				<cfset whereString = "p_sortorder = #getNonStaffSortOrder()#" & whereString>
			<cfelseif isDefined("params.staffonly")>
				<cfset whereString = "p_sortorder < #getNonStaffSortOrder()#" & whereString>
			<cfelseif isDefined("params.pastoralstaffonly")>
				<cfset whereString = "p_sortorder < #getNonStaffSortOrder()# AND position LIKE '%pastor%'" & whereString>
			<cfelseif isDefined("params.showremovedstaffonly")>
				<cfset whereString = "position LIKE '%Removed%'" & whereString>	
			<cfelse>
				<cfset whereString = "p_sortorder <= #getNonStaffSortOrder()#" & whereString>
			</cfif>
			<cfif isDefined("params.districtid")>
				<cfset whereString = whereString & " AND districtid = #params.districtid#">
			</cfif>
			<cfif isDefined("params.gender")>
				<cfset whereString = whereString & " AND fnameGender = '#params.gender#'">
			</cfif>
			<cfif isDefined("params.lname")>
				<cfset whereString = whereString & " AND lname like '#params.lname#%'">
			</cfif>

		<!--- Run the query then filter out persons that should not be listed in the handbook --->
			<cfset bluepagesPeople = model("Handbookperson").findAll(where=whereString, order=orderString, include=includeString)>
			<cfset bluePagesPeople = queryFilter(bluepagesPeople, isInHandbookMap)>

		<!--- select layout and template based on params --->
			<cfif isDefined("params.layout") and params.layout is "naked">
				<cfset renderPage(layout="/layout_naked")>
			<cfelseif isDefined("params.download")>
				<cfset allhandbookpeople = bluepagesPeople>
				<cfset renderpage(template="downloadstaff", layout="/layout_download")>
			<cfelseif isDefined("params.preview")>
				<cfset allhandbookpeople = bluepagesPeople>
				<cfset renderpage(template="downloadstaff", layout="/layout_naked")>
			<cfelse>
				<cfset renderPage(layout="/handbook/layout_handbook1")>
			</cfif>
	</cffunction>

	<cffunction name="distribution">
	<cfset var loc = structNew()>
		<cfset loc.whereString = "p_sortorder = 500 AND state <> 'Non US' AND position <> 'Removed From Staff'">
		<cfset loc.whereString = loc.wherestring & " AND statusid in (1,8,3,4,2,9,10,11)">

		<cfif isDefined("params.sendHandbookOnly")>
			<cfset loc.whereString = loc.whereString & " AND sendhandbook = 'yes'">
		</cfif>
<!---
		<cfset people = model("Handbookperson").findall(where=loc.whereString, order="lname,fname", include="Handbookstate,Handbookpositions")>
--->
		<cfset people = model("Handbookperson").findAll(where=loc.whereString, order="lname,fname,id", include="Handbookstate,Handbookpositions(Handbookorganization)")>

		<cfif isDefined("params.download")>
			<cfset renderPage(layout="/layout_download")>
		<cfelse>
			<cfset renderPage(layout="/layout_naked")>
		</cfif>
	</cffunction>

	<!---Used for birthday and anniversary reports--->
	<cffunction name="dates">
	<cfif !isDefined("params.dateType")>
		<cfset params.dateType = "birthday">
	</cfif>

		<cfset datesSorted = model("Handbookperson").findDatesSorted(params.dateType)>
		<cfset datesThisWeek = model("Handbookperson").findDatesThisWeek(params.dateType)>
		<cfset subscribed = model("Handbooksubscribe").findOne(where="email = '#session.auth.email#' AND type='dates'")>
		<cfif isObject(subscribed)>
			  <cfset params.isSubscribed = true>
		</cfif>

	</cffunction>

	<cffunction name="datesByYear">
		<cfset datesSorted = model("Handbookperson").findDatesSorted(params.dateType,"birthdayyear DESC")>
	</cffunction>

	<cffunction name="currentministry">
    	<cfset handbookperson = model("Handbookperson").findByKey(key=params.key, include="Handbookstate,Handbookprofile")>
		<cfif isdefined("params.ajax")>
			<cfset renderPartial("currentMinistry")>
		</cfif>
	</cffunction>

	<cffunction name="focus">
		<cfif isDefined("params.keyy")>
			<cfset params.key = params.keyy>
		</cfif>
		<cfset people = model("Handbookperson").findFocus(params.key)>
		<cfif isDefined("params.download") and params.download is "excel">
			  <cfset renderPage(layout="/layout_download")>
		<cfelse>
			  <cfset renderPage(layout="/layout_naked")>
		</cfif>

	</cffunction>

<!---End of special reports--->

<!---Special Actions (not sure what to do with these--->

	<!--- used to set the review date on a record and then return back to the calling view page--->
	<cffunction name="setReview">
	<cfargument name="personId" default="#params.key#">
    	<cfset person = model("Handbookperson").findOne(where="id=#arguments.personid#", include="Handbookstate")>
    	<cfset person.reviewedAt = now()>
    	<cfset person.reviewedBy = session.auth.email>
    	<cfset test = person.update()>
		<cfset returnBack()>
	</cffunction>

	<!---Sends an email to every person and organization email address - edit email in _message.cfm - does not have a menu option--->
	<cffunction name="sendToHandbookPeople">
		<cfset emailall = "">
		<cfset count = 0>
		<cfset emailsubject = getEmailSubject()>
		<cfset maxsortorder = 500>
		<cfset maxrows = 100000>

		<cfif isDefined("params.test")>
			<cfset maxrows = 5>
		</cfif>

		<cfset peopleEmails1 = model("Handbookperson").findAll(select="handbookpeople.email as emailsend, fname as name", where="p_sortorder <= #maxsortorder# AND statusid IN (1,8,3,4,2,9,10,11)", maxrows=maxrows, include="Handbookstate,Handbookpositions(Handbookorganization)")>
		<cfset peopleEmails2 = model("Handbookperson").findAll(select="handbookpeople.email2 as emailsend, fname as name", where="p_sortorder <= #maxsortorder# AND statusid IN (1,8,3,4,2,9,10,11)", maxrows=maxrows, include="Handbookstate,Handbookpositions(Handbookorganization)")>
		<cfset churchEmails1 = model("Handbookorganization").findAll(where="statusid IN (1,8,3,4,2,9,10,11)", select="handbookorganizations.email as emailsend, name as name", maxrows=maxrows, include="Handbookstate")>

		<cfquery dbtype="query" name="allemails">
			SELECT *
			FROM peopleEmails1
			UNION
			SELECT *
			FROM peopleEmails2
			UNION
			SELECT *
			FROM churchEmails1
		</cfquery>
		<cfquery dbtype="query" name="distinctemail">
			SELECT DISTINCT emailsend, name
			FROM allemails
			ORDER BY emailsend,name
		</cfquery>

		<cfloop query = "distinctemail">
			<cfif isValid("email", emailsend)>
				<cfif emailsend is "tomavey@fgbc.org">
					<cfset emailsend = "tomavey@comcast.net">
				</cfif>

				<cfset emailall = emailall & "; " & emailsend>
				<cfset count = count +1 >

				<cfif isdefined("params.go") and params.go is "send">
					<cfset sendEmail(from="tomavey@fgbc.org", subject=emailsubject, bcc="tomavey9173@gmail.com", to=emailsend, template="message", layout="/layout_naked", name=name)>
				</cfif>

				<cfif isdefined("params.go") and params.go is "test">
					<cfset sendEmail(from="tomavey@fgbc.org", subject=emailsubject, bcc="tomavey9173@gmail.com", to="tomavey@fgbc.org", template="message", layout="/layout_naked", name=name)>
				</cfif>
			</cfif>
		</cfloop>

		<cfset emailall = replace(emailall,"; ","","one")>

		<cfset renderPage(layout="/layout_naked")>

	</cffunction>

	<cffunction name="addToAGBMMailList">
	<cfset var loc = structNew()>
	<cfset loc.return = false>
	<cfset loc.check = model("Handbookgroup").findOne(where="personid=#params.key# AND grouptypeid = 16")>
    	<cfif not isObject(loc.check)>
    		 <cfset loc.group = model("Handbookgroup").new()>
    		 <cfset loc.group.personid = params.key>
    		 <cfset loc.group.grouptypeid = 16>
    		 <cfif loc.group.save()>
    		 	   <cfset loc.return = true>
    		 </cfif>
    	</cfif>
	<cfset returnBack()>
	</cffunction>

<!---Maintenance Methods only- Not used in production--->

	<cffunction name="changeSortOrder">
	<cfargument name="newSortOrder" default="10" type="numeric">
    	<cfset person = model("Handbookperson").findOne(where="id=#params.key#", include="Handbookstate")>
    	<cfset person.sortOrder = arguments.newsortorder>
    	<cfset person.update()>
	<cfset returnBack()>
	</cffunction>

	<cffunction name="moveSortorderToPosition">
		<cfset positions = model("Handbookposition").findAll()>
		<cfloop query = "positions">
			<cfset thisPerson = model("Handbookperson").findByKey(key=personid, include="Handbookstate")>
			<cfset thisPosition = model("Handbookposition").findByKey(id)>
			<cftry>
			<cfset thisPosition.sortorder = thisPerson.sortorder>
			<cfcatch>
			<cfset thisPosition.sortorder = 0>
			</cfcatch>
			</cftry>
			<cfset thisposition.update()>
		</cfloop>
		<cfset positions = model("Handbookposition").findAll(include="Handbookperson(Handbookstate)")>
		<cfoutput query="positions">
		#sortorder# #handbookpersonsortorder#<br/>
		</cfoutput>
		<cfabort>

	</cffunction>

  <cffunction name="getEmailSubject">
  <cfset var loc=structNew()>
    <cfset loc.return="The online FGBC Handbook goes mobile!">
  <cfreturn loc.return>
  </cffunction>

  <cffunction name="deleteAll999">
  <cfset people = model("handbookperson").findAll(where="p_sortorder = 999", include="Handbookstate,Handbookpositions")>
  <cfloop query="people">
  	<cfset thisperson = model("handbookperson").findByKey(key=id, include="Handbookstate")>
	<cfset thisperson.delete()>
  </cfloop>
  <cfset people = model("handbookperson").findAll(where="p_sortorder = 999", include="Handbookstate,Handbookpositions", maxrows="50")>
  <cfdump var="#people#">
  <cfabort>
  </cffunction>

  <cffunction name="deleteAllWithdrawn">
  <cfset people = model("handbookperson").findAll(where="statusid IN (7,5,6)", include="Handbookstate,Handbookpositions(Handbookorganization)", maxrows="50")>
  <cfdump var="#people#">
  <cfabort>
  <cfloop query="people">
  	<cfset thisperson = model("handbookperson").findByKey(key=id, include="Handbookstate")>
	<cfset thisperson.delete()>
  </cfloop>
  <cfset people = model("handbookperson").findAll(where="p_sortorder = 999", include="Handbookstate,Handbookpositions", maxrows="50")>
  </cffunction>

  <cffunction name="downloadAGBM">
  <cfset var loc=structNew()>
	<cfset loc.orderString = "lname,fname">
	<cfif isDefined("params.byAge")>
		<cfset loc.orderString = "birthdayyear #params.byAge#,lname,fname">
	</cfif>
  	<cfset loc.currentmembershipyear = model("Handbookagbminfo").currentMembershipYear(params)>
  	<cfset agbmmembers = model("Handbookperson").findAll(where="membershipfeeyear = #loc.currentmembershipyear# AND p_sortorder <= 500", include="Handbookstate,Handbookagbminfo,Handbookpositions,Handbookprofile", order=loc.orderString)>

	<!---cfdump var="#agbmmembers.columnlist#"><cfabort--->  
	<cfset setDownloadLayout()>
  </cffunction>

  <cffunction name="wifesbirthday">
  	<cfset profiles = model("Handbookprofile").findAll(where="wifesbirthday IS NOT NULL")>
	<cfloop query="profiles">
		<cfset test = loadDateAsString(personid,dateformat(wifesbirthday,"yyyy-mm-dd"))>
		<cfdump var="#test#">
	</cfloop>
  	<cfset profiles = model("Handbookprofile").findAll(where="wifesbirthday IS NOT NULL")>
	<cfdump var="#profiles#"><cfabort>
  </cffunction>

  <cffunction name="loadDateAsString">
  <cfargument name="personid" required="true" type="numeric">
  <cfargument name="date" required="true" type="string">
  <cfargument name="key" default="wifesbirthdayasstring">
  <cfset var loc = structNew()>

  <cfset loc.person = model("Handbookprofile").findOne(where="personid = #arguments.personid#")>
  <cfset loc.person[arguments.key] = "#arguments.date#">
<!---<cfdump var="#loc.person#"><cfabort>
--->
  <cfset loc.test = loc.person.save()>
  <cfreturn loc.test>
  </cffunction>

  <cffunction name="sendProfileFormLink">
	<cfargument name="emailTo" required="false" type="string">
	<cfargument name="emailFrom" default="#session.auth.email#">
	<cfset var loc = structNew()>

    	<cfif not isDefined("arguments.emailto")>
    		  <cfset arguments.emailto = model("Handbookperson").findOne(where="id=#params.key#", include="Handbookstate").email>
    	</cfif>
    	<cfif arguments.emailto is "tomavey@fgbc.org">
    		  <cfset arguments.emailto = "tomavey@comcast.net">
    	</cfif>

		<cfset params.emailto=arguments.emailto>

     	<cfset sendEMail(to=arguments.emailto, from=arguments.emailfrom, subject="From the FGBC Online Handbook: Your person profile.", template="sendprofileform", layout="/layout_naked")>

   </cffunction>

<!---End of special actions--->

<!---356 lines--->

<!---To be deleted if not needed

	<cffunction name="logupdates">
		<cfdump var="#params#"><cfabort>
	</cffunction>

	<cffunction name="test">
		<cfset setHandbookRights()>
		<cfabort>
	</cffunction>


--->

<!---I don't think sendNoticeOfPersonUpdate is being used--->

<cffunction name="sendNoticeOfPersonUpdate">
<cfargument name="personid" required="true" type="numeric">

	<cfset sendEmail(
		to=application.wheels.HandbookProfileSecretary,
		from="tomavey@fgbc.org",
		subject="Person Update",
		layout="/layout_naked",
		template="/views/handbook_updates/notice"
		)>

<cfreturn true>
</cffunction>

<cffunction name="possibleConferenceRegs">
<cfargument name="personid" required="true" type="numeric">
<cfset var loc=structNew()>
<cfset loc.person = model("Handbookperson").findOne(where="id=#arguments.personid#", include="Handbookstate")>
<cfset loc.regs = model("equip_registration").findAll(where='lname like "#loc.person.lname#%"', include="equip_person(equip_family)")>
	<cfsavecontent variable="loc.return">
		<table class="table">
			<cfoutput query="loc.regs" group="equip_personid">
			<tr>
				<td>#lname#, #fname#</td>
				<td>#email#</td>
				<td>#dateFormat(createdAt,"yyyy")#</td>
				<td>
				<cfif handbookpersonid is arguments.personid>
					LINKED
				<cfelse>
					#linkto(text="link", action="connectRegToHandbook", params="regpersonid=#equip_personid#&handbookpersonid=#params.key#")#
				</cfif>
				</td>
			</tr>
			</cfoutput>
		</table>
	</cfsavecontent>
<cfreturn loc.return>
</cffunction>

<cffunction name="connectRegToHandbook">
<cfargument name="regPersonId" default="">
<cfargument name="handbookPersonId" default="">
	<cfif isDefined("params.regPersonId")>
		<cfset arguments.regpersonid = params.regpersonid>
	</cfif>
	<cfif isDefined("params.handbookPersonId")>
		<cfset arguments.handbookPersonId = params.handbookPersonId>
	</cfif>
	<cfset regPerson = model("Equip_person").findOne(where="id=#arguments.regPersonId#")>
	<cfset regPerson.handbookpersonid = arguments.handbookPersonid>
	<cfset regPerson.update()>
<cfset returnBack()>
</cffunction>

<cffunction name="findNextHandbookPerson">
<cfargument name="personid" required="true" type="numeric">
<cfset var loc=structNew()>
<cfset loc.nextid=0>
<cfset loc.nextrow = false>
<cfset var loc.return=0>
<cftry>
	<cfset HandbookPeople = model("Handbookperson").findAll(where="p_sortorder < #getNonStaffSortOrder()+1#", order="alpha", include="Handbookstate,Handbookpositions")>
	<cfloop query="handbookPeople">
		<cfif loc.nextrow>
			<cfreturn id>
		</cfif>
		<cfif handbookPeople.id is arguments.personid>
			<cfset loc.nextrow = true>
		</cfif>
	</cfloop>
<cfcatch></cfcatch></cftry>
	<cfreturn 0>
</cffunction>

<cffunction name="sendHandbook">
<cfargument name="send" default="No">
<cfset var loc=structNew()>
<cfset loc.return = "">
	<cfif isDefined("params.key")>
		<cfset person = model("Handbookperson").findOne(where="id=#simpleDecode(params.key)#", include="Handbookstate")>
		<cfset loc.return = person.update(sendHandbook="yes")>
	<cfelse>
		<cfset loc.return = "Key Not Defined">
	</cfif>
</cffunction>

<cffunction name="clearSendHandbooks">
	<cfset clear = model("Handbookperson").clearSendHandbooks()>
	<cfset returnBack()>
</cffunction>

<cffunction name="findAllStaff">
	<cfset staff = model("Handbookperson").findAllStaff()>
	<cfset renderPage(layout="/layout_json", template="json", hideDebugInformation=true)>
</cffunction>

<cffunction name="findStaff">
	<cfset staff = model("Handbookperson").findStaff(params.key)>
	<cfset renderPage(layout="/layout_json", template="json", hideDebugInformation=true)>
</cffunction>

<cffunction name="checkpics">
	<cfset pics = model("Handbookpicture").findAll()>
	<cfloop query = "pics">
		<cfset thispic = model("Handbookpicture").findAll(where="personid = #personid#")>
		<cfif thispic.recordCount is 1 AND thispic.usefor NEQ "default">
			<cfoutput>#id# - #personid# - #usefor#<br/></cfoutput>
			<cfquery datasource="fgbc_main_3" result="data">
				update handbookpictures
				set usefor = "default"
				where id = #id#
			</cfquery>
		</cfif>
	</cfloop>
	<cfabort>
</cffunction>

<cffunction name="sendPersonPageErrorNotice">
	<cfargument name="subject"  default="FGBC Handbook Person Page Error">
	<cfset sendEmail(from=application.wheels.errorEmailAddress, to=application.wheels.errorEmailAddress, template="personpageerroremail.cfm", subject=arguments.subject)>
</cffunction>

<cfscript>

private function $SendImmediatePersonUpdates(){
	return application.wheels.SendImmediatePersonUpdates;
}

private function $getThisUserName(){
	try {return session.auth.username;}
	catch (any e){return "none";};
}

public function handbookReviewOptions(
		string type='everyone',
		string lastReviewedBefore=dateformat(dateAdd('d',1,now())),
		string orderby='lname',
		string go='false',
		string refresh=true,
		string tag="",
		string username=$getThisUserName(),
		){
	var i = 0;		
	args = $$useParamsForDefaults(params,arguments);
	if (args.refresh){
		session.people = [];
		session.people = model("Handbookperson").getHandbookReviewStruct(
			lastReviewedBefore=lastReviewedBefore,
			orderby=orderby, 
			type=type, 
			tag=tag,
			username=username,
			go=true
			);	
	}
	people = session.people;
	testpeople = model("Handbookperson").getHandbookReviewStruct(
		lastReviewedBefore=lastReviewedBefore,
		orderby=orderby, 
		type=type, 
		tag=tag,
		go=false
		);	
	emailMessage = $getEmailMessageForPeopleReview();
	tags = model("Handbooktag").findAll(where="username='#$getThisUserName()#'", group="tag");
	renderPage(layout="/handbook/layout_handbook2")
}

public function emailPeopleForHandbookReview(
		string type='everyone',
		string lastReviewedBefore=dateformat(dateAdd('d',1,now())),
		string orderby='reviewedAt',
		string go='false'){
	var i = 0;		
	var args = $$useParamsForDefaults(params,arguments);
	allemails = "";
	emailMessage = $getEmailMessageForPeopleReview();
	if (!isDefined("session.people")){redirectTo(action="handbookReviewOptions")}
	if (isDefined("params.go") && params.go){
			people = session.people;
		}
		else
		{
			people = model("Handbookperson").getHandbookReviewStruct();
		}
	for (i=1; i LTE arrayLen(people); i=i+1){
		sendEmail(
			to=people[i].email, 
			from=getHandbookReviewSecretary(), 
			subject=getSetting('PersonHandbookReviewGreeting'), 
			template="emailPeopleForHandbookReview.cfm", 
			layout="/layout_for_email", 
			args=people[i]
			);
		allemails = allemails & "; " & people[i].email; 
		};
		allemails = replace(allemails,"; ","","one");
		structDelete(session,"people");

	renderPage(template="emailPeopleForHandbookReviewReport", layout="/handbook/layout_handbook2");
}

private function $getEmailMessageForPeopleReview(){
	var emailMessage = "<h3>We are updating our database for the #year(now())+1# Charis Fellowship Handbook!</h3><p>Churches have updated their staff. You can check your personal listing before October 15 using the link below.</p><p>Be sure to click the 'This information is correct' button when you are finished. </p>";
	return emailMessage; 
}

public function removePersonFromSessionArray(item){
	ArrayDeleteAt(session.people,item);
	redirectTo(action="handbookReviewOptions", params="refresh=false");
}

public function changeToAGBMOnly (positionId){
	if (isDefined("params.positionid")){arguments.positionid = params.positionid};
	var thisPosition = model("Handbookposition").findOne(where="id=#arguments.positionid#");
	thisPosition.position = "AGBM Only";
	thisPosition.positionTypeId = 32;
	thisPosition.save();
	returnback();
}

public function addstaff(organizationid,sortOrder){
	var loc = StructNew();
	if (isDefined('params.organizationid')){
		loc.organizationid = params.organizationid
	}
	else {
		loc.organizationid = arguments.organizationid
	}
	if (isDefined('params.sortorder')){
		loc.sortorder = params.sortorder
	}
	else {
		loc.sortorder = arguments.sortorder
	}
	allHandbookPeople = model("Handbookperson").findAll(where="p_sortorder < #getNonStaffSortOrder()+1#", order="alpha", include="Handbookstate,Handbookpositions");
}

public function newposition(){
	writeDump(form);abort;
}

public function isInHandbookMap(obj){
	if (
			(
				obj.lname NEQ "Pastor" && 
				obj.fname NEQ "No" && 
				!isFormerAGBMMember(obj.id)
			) || 
			isNatMinOrCoopMin(obj.id) || 
			(obj.p_sortorder < getNonStaffSortOrder())
		)
		{
		return true;
		}
	else {
		return false;
	}
}

public function hideFromPublic(personid) {
	var person = model("Handbookperson").findOne(where="id=#personid#", include="state");
	person.hideFromPublic = 1;
	person.update();
	returnBack();
}

public function unHideFromPublic(personid) {
	var person = model("Handbookperson").findOne(where="id=#personid#", include="state");
	person.hideFromPublic = 0;
	person.update();
	returnBack();
}

</cfscript>

</cfcomponent>
