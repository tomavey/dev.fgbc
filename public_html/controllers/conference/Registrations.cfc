<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
		<cfset usesLayout("/conference/adminlayout")>
		<cfset filters(through="officeOnly", except="list,summary")>
		<cfset filters(through="setReturn", only="index,show,list")>
	</cffunction>

	<!--- registrations/index --->
	<cffunction name="index">
		<cfset var orderString = "createdAT DESC">
		<cfif isDefined("params.status")>
			<cfset whereString = "event='#getEvent()#' AND ccstatus = '#params.status#'">
		<cfelse>
			<cfset whereString = "event='#getEvent()#'">
		</cfif>
		<cfif isDefined("params.sortby")>
			<cfset orderString = params.sortby>
		</cfif>
		<cfset registrations = model("Conferenceregistration").findAll(where=whereString, include="person(family),option,invoice", order=orderString)>
		<cfif isDefined("params.download")>
			  <cfset renderPage(layout="/conference/layoutdownload")>
		</cfif>
    </cffunction>

	<cffunction name="parentEmail">
			<cfloop query="registrations">
				<cfif registrations.email is "parent">
					<cfset registrations.email = registrations.familyemail>
				</cfif>
			</cfloop>
	</cffunction>

	<!--- registrations/list --->
	<cffunction name="list">
	<cfset var loc=structNew()>
	<cfset loc.whereString = "">
	<cfset loc.includeString = "person(family,age_ranges),option,invoice">
		<cfif isDefined("params.byage") AND params.byage is "true">
			<cfset loc.orderString = "age,lname">
		<cfelse>
			<cfset loc.orderString = "equip_optionsid,lname">
		</cfif>

		<cfif isdefined("params.key")>
			<cfset loc.whereString = "equip_optionsid = #params.key#">
		<cfelseif isdefined("params.type")>
			<cfset loc.whereString = "event = '#getEvent()#' AND equip_options.TYPE='#params.type#'">
			<cfif params.type is "Registration">
				<cfset loc.whereString = "event = '#getEvent()#' AND (equip_options.TYPE LIKE '%Registration%')">
			</cfif>
			<cfif params.type is "GraceKids">
				<cfset loc.whereString = "event = '#getEvent()#' AND (equip_options.TYPE LIKE '%GraceKids%')">
			</cfif>
			<cfif params.type is "workshop">
				<cfset loc.includeString = "Workshop,person(family,age_ranges),option,invoice">
				<cfset loc.orderString = "title,lname">
				<cfset groupBy = "title">
			</cfif>
		<cfelseif isDefined("params.search")>
			<cfset loc.whereString = "equip_options.buttonDescription like '%#params.search#%' AND event = '#getEvent()#'">
		<cfelse>
			<cfset loc.whereString = "event = '#getEvent()#'">
		</cfif>

		<cfif isDefined("params.agerange")>
			<cfset loc.whereString = loc.whereString & " AND equip_age_ranges.description like '#params.agerange#%'">
		</cfif>

		<cfif isDefined("params.sortorder")>
			<cfset loc.orderString = params.sortorder & " DESC">
		</cfif>

			<cfset registrations = model("Conferenceregistration").findAll(where=loc.whereString, include=loc.includeString, order=loc.orderString)>

			<cfloop query="registrations">
				<cfif registrations.email is "parent">
					<cfset registrations.email = registrations.conferencefamilyemail>
				</cfif>

				<cfif not len(registrations.email)>
					<cftry>
					<cfset registrations.email = model("Conferenceperson").findOne(where="equip_familiesid = #equip_familiesid# AND type = 'Adult'", include="family").email>
					<cfcatch></cfcatch></cftry>
				</cfif>
			</cfloop>

    </cffunction>

    <cffunction name="isRegMLL">
    <cfargument name="personid" required="true" type="numeric">
		<cfset registration = model("Conferenceregistration").findOne(where="equip_peopleid=#arguments.personid# AND equip_options.TYPE='MobileLearningLab' AND event = '#getEvent()#'", include="option,invoice", order="equip_optionsid,lname")>
		<cfif isObject(registration)>
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>
    </cffunction>

	<!--- registrations/show/key --->
	<cffunction name="show">
		<!--- Find the record --->
    	<cfset registration = model("Conferenceregistration").findAll(where="id=#params.key#", include="person(family),option,invoice")>
	</cffunction>

	<!--- registrations/new --->
	<cffunction name="new">
		<cfset registration = model("Conferenceregistration").new()>
		<cfset people2 = model("Conferenceperson").findAll(where="event='#getEvent()#'", include="family,registration(invoice)", order="lname,fname")>

		<cfquery dbtype="query" name="people">
			SELECT DISTINCT ID, FULLNAMELASTFIRSTID
			FROM people2
		</cfquery>

		<cfset options = model("Conferenceoption").findAll(where="event='#getEvent()#'", order="type,name")>
		<cfset invoices = model("Conferenceinvoice").findAll(where="event='#getEvent()#'", include="registrations(option)")>
		<cfif isdefined("params.iid")>
			<cfset registration.equip_invoicesid = params.iid>
		</cfif>
		<cfif isdefined("params.pid")>
			<cfset registration.equip_peopleid = params.pid>
		</cfif>
	</cffunction>

	<!--- registrations/new --->
	<cffunction name="addnew">
		<cfset registration = model("Conferenceregistration").new()>
		<cfset people2 = model("Conferenceperson").findAll(where="event='#getEvent()#'", include="family,registration(invoice)", order="lname,fname")>

		<cfquery dbtype="query" name="people">
			SELECT DISTINCT ID, FULLNAMELASTFIRSTID
			FROM people2
		</cfquery>

		<cfset options = model("Conferenceoption").findAll(where="event='#getEvent()#'", order="type,name")>
		<cfset invoices = model("Conferenceinvoice").findAll(where="event='#getEvent()#'", include="registrations(option)")>
		<cfif isdefined("params.iid")>
			<cfset registration.equip_invoicesid = params.iid>
		</cfif>
		<cfif isdefined("params.pid")>
			<cfset registration.equip_peopleid = params.pid>
		</cfif>
		<cfset renderPage(action="new")>
	</cffunction>

	<!--- registrations/edit/key --->
	<cffunction name="edit">
	<cfset var thisyear = year(now())>
	<cfset var createdAtSince = createDate(thisyear-1,9,1)>
	<cfset formaction = "/index.cfm/conference.registrations/update/#params.key#">

		<!--- Find the record --->
	    	<cfset registration = model("Conferenceregistration").findByKey(params.key)>
		<cfset people = model("Conferenceperson").findAll(where="createdAt > '#createdAtSince#'", include="family", order="lname")>
		<cfset options = model("Conferenceoption").findAll(where="event='#getEvent()#'", order="type,name")>
		<cfset invoices = model("Conferenceinvoice").findAll(where="event='#getEvent()#'")>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(registration)>
	        <cfset flashInsert(error="registration #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

	<!--- registrations/create --->
	<cffunction name="create">
		<cfset registration = model("Conferenceregistration").new(params.registration)>

		<!--- Verify that the registration creates successfully --->
		<cfif registration.save()>
			<cfset flashInsert(success="The registration was created successfully.")>
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the registration.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>

	<!--- registrations/update --->
	<cffunction name="update">

		<cfset registration = model("Conferenceregistration").findByKey(params.key)>

		<!--- Verify that the registration updates successfully --->
		<cfif registration.update(params.registration)>
			<cfset flashInsert(success="The registration was updated successfully.")>

	            <cfset returnBack()>

		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the registration.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>

	<!--- registrations/delete/key --->
	<cffunction name="delete">
		<cfset registration = model("Conferenceregistration").findByKey(params.key)>

		<!--- Verify that the registration deletes successfully --->
		<cfif registration.delete()>
			<cfset flashInsert(success="The registration was deleted successfully.")>
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the registration.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>

	<cffunction name="deleteall">
		<cfquery datasource="fgbc_main_3">
			delete from equip_invoices
		</cfquery>
		<cfquery datasource="fgbc_main_3">
			delete from equip_people
		</cfquery>
		<cfquery datasource="fgbc_main_3">
			delete from equip_families
		</cfquery>
		<cfquery datasource="fgbc_main_3">
			delete from equip_registrations
		</cfquery>
	Done!<cfabort>
	</cffunction>

	<cffunction name="summary">
	<cfset var loc=structNew()>
	<cfset regs=structNew()>

		<cfif isdefined("params.key")>
			<cfset regs.todayDate = params.key>
		<cfelse>
			<cfset regs.todayDate= now()>
		</cfif>

		<cfif isDefined("params.includeAll")>
			<cfset showunpaid = true>
		</cfif>

		<cfset regs.oneYearAgo = dateAdd("yyyy",-1,regs.todayDate)>
		<cfset regs.twoYearsAgo = dateAdd("yyyy",-2,regs.todayDate)>
		<cfset regs.threeYearsAgo = dateAdd("yyyy",-3,regs.todayDate)>

		<cfset loc.includestring = "Person(Family,Age_ranges),Option,Invoice">

		<!--- 2011 in Wooster 
		<cfset regs.v2020couples = model("Conferenceregistration").countRegs(14,params)>
		<cfset regs.v2020singles = model("Conferenceregistration").countRegs(13,params)>
		<cfset regs.v2020daycouples = model("Conferenceregistration").countRegs(31,params)>
		<cfset regs.v2020daysingles = model("Conferenceregistration").countRegs(32,params)>
		<cfset regs.v2020eveningSingle = model("Conferenceregistration").countRegs(81,params)>
		<cfset regs.v2020eveningCouple = model("Conferenceregistration").countRegs(82,params)>
		<cfset regs.v2020avgage = model("Conferenceregistration").getAvgAgeToDate("celebrate2011",regs.todayDate)>
		--->

		<!--- 2012 in Palm Springs
		<cfset regs.v2020Wcouples = model("Conferenceregistration").countRegs(94,params)>
		<cfset regs.v2020Wsingles = model("Conferenceregistration").countRegs(93,params)>
		<cfset regs.v2020WdaySingle = model("Conferenceregistration").countRegs(95,params)>
		<cfset regs.v2020WdayCouple = model("Conferenceregistration").countRegs(96,params)>
		<cfset regs.v2020Wavgage = model("Conferenceregistration").getAvgAgeToDate("celebrate2012",regs.todayDate)>
		--->

		<!---2013 - Atlanta
		<cfset regs.v2020Scouples = model("Conferenceregistration").countRegs(174,params)>
		<cfset regs.v2020Ssingles = model("Conferenceregistration").countRegs(173,params)>
		<cfset regs.v2020SdaySingle = model("Conferenceregistration").countRegs(181,params)>
		<cfset regs.v2020SdayCouple = model("Conferenceregistration").countRegs(210,params)>
		<cfset regs.v2020Savgage = model("Conferenceregistration").getAvgAgeToDate("celebrate2013",regs.todayDate)>
		--->

		<!---Fellowshift2014 - Washington D.C.--->
		<cfset regs.vDC.couples = countRegs(220,params) + countRegs(238,params)>
		<cfset regs.vDC.singles = countRegs(221,params) + countRegs(237,params)>
		<cfset regs.vDC.daysingle = countRegs(255,params)>
		<cfset regs.vDC.prepaidDiscount = countRegs(263,params)*2 + countRegs(264,params)>
		<cfset regs.vDC.Free = countRegs(235,params) + countRegs(236,params) * 2>
		<cfset regs.vDC.avgage = model("Conferenceregistration").getAvgAgeToDate("visionconference2014",regs.todayDate)>

		<!---Flinch2015 - NYC --->
		<cfset regs.vNY.couples = countRegs(285,params) + countRegs(329,params)>
		<cfset regs.vNY.singles = countRegs(286,params) + countRegs(287,params)>
		<cfset regs.vNY.daysingle = countRegs(309,params)>
		<cfset regs.vNY.prepaidDiscount = countRegs(299,params)*2 + countRegs(298,params)>
		<cfset regs.vNY.Free = countRegs(289,params) + (countRegs(290,params) * 2)>
		<cfset regs.vNY.avgage = model("Conferenceregistration").getAvgAgeToDate("visionconference2015",regs.todayDate)>

		<!---Margins2016 - Toronto --->
		<cfset regs.vTOR.couples = countRegs(348,params) + countRegs(354,params)>
		<cfset regs.vTOR.singles = countRegs(349,params) + countRegs(351,params)>
		<cfset regs.vTOR.daysingle = countRegs(350,params)>
		<cfset regs.vTOR.prepaidDiscount = countRegs(360,params)*2 + countRegs(361,params)>
		<cfset regs.vTOR.FreeYoung = countRegs(352,params) + countRegs(355,params) * 2>
		<cfset regs.vTOR.FreeOld = countRegs(356,params) + countRegs(359,params) * 2>
		<cfset regs.vTOR.Free = regs.vTOR.FreeYoung + regs.vTOR.FreeOld>
		<cfset regs.vTOR.avgage = model("Conferenceregistration").getAvgAgeToDate("visionconference2016",regs.todayDate)>

		<!---Access2017 - Fremont --->
		<cfset regs.Access2017.couples = countRegs(409,params)>
		<cfset regs.Access2017.couples2 = countRegsByType(type="Registration-couple",includeFree="true")>
		<cfset regs.Access2017.singles = countRegs(408,params)>
		<cfset regs.Access2017.singles2 = countRegsByType(type="Registration-single",includeFree="true")>
		<cfset regs.Access2017.prepaid = countRegs(407,params)>
		<cfset regs.Access2017.group = countRegs(440,params)>
		<cfset regs.Access2017.group2 = countRegsByType(type="Registration-group",includeFree="true")>
		<cfset regs.Access2017.staff = countStaffRegs()>
		<cfset regs.Access2017.FreeYoung = countRegs(441,params) + (countRegs(443,params) * 2)>
		<cfset regs.Access2017.FreeOld = countRegs(442,params) + (countRegs(444,params) * 2)>
		<cfset regs.Access2017.Free = regs.Access2017.FreeYoung + regs.Access2017.FreeOld>
		<cfset regs.Access2017.avgage = model("Conferenceregistration").getAvgAgeToDate("visionconference2017",regs.todayDate)>
<!---
		<cfdump var="#params#">
		<cfdump var="#regs.Access2017#"><cfabort>
--->
	</cffunction>

	<cffunction name="countRegs">
	<cfargument name="optionid" required="true" type="numeric">
	<cfargument name="params" required="true" type="struct">
		<cfset var loc = arguments>
		<cfset loc.count = model("Conferenceregistration").countRegs(#loc.optionid#,loc.params)>
		<cfreturn loc.count>
	</cffunction>

	<cffunction name="countStaffRegs">
	<cfset var loc = structNew()>
		<cfset loc.count = model("Conferenceregistration").countStaffRegs()>
		<cfreturn loc.count>
	</cffunction>

	<cffunction name="showSearch">
		<cfset location = find("'",params.search)>
		<cfif location>
			  <cfset params.search = RemoveChars(params.search,1,location)>
		</cfif>
		<cfset registrations = model("Conferenceperson").findAll(where="event = '#getEvent()#' AND (lname like '%#params.search#%' OR fname like '%#params.search#%' OR city like '%#params.search#%' OR equip_invoicesid like '%#params.search#%')", include="registration(invoice,option),family", order="CCORDERID,EQUIP_PEOPLEID")>
	</cffunction>

	<cffunction name="listSingleRegs">
			<cfset registrations = model("Conferenceregistration").findAll(where="equip_optionsid = 13 AND ccstatus = 1", include="person(family,age_ranges),option,invoice", order="createdAt DESC,equip_optionsid,lname")>
			<cfset request.action = "addSingleConcertTicket">
	</cffunction>

	<cffunction name="listCoupleRegs">
			<cfset registrations = model("Conferenceregistration").findAll(where="equip_optionsid = 14 AND ccstatus = 1", include="person(family,age_ranges),option,invoice", order="createdAt DESC,equip_optionsid,lname")>
			<cfset request.action = "addCoupleConcertTicket">
			<cfset renderPage(action="listSingleRegs")>
	</cffunction>

	<cffunction name="connectToHandbook">

		<cfset setReturn()>

		<cfif NOT isDefined("params.key")>
			<cfset params.key = getEvent()>
		</cfif>

		<cfif not isDefined("params.page")>
			<cfset params.page = 1>
		</cfif>

		<cfset params.perpage = 100>

		<cfset registrations= model("ConferenceRegistration").findPeopleToConnect(params)>

		<cfset handbookpeople=model("ConferenceRegistration").connecthandbookpeople()>

	</cffunction>

	<cffunction name="connect">
		<cfloop list="#structKeyList(params)#" index="i">
			<cfif val(i) AND val(params[i])>
				<cfset model("ConferenceRegistration").setHandbookPersonId(regPersonId=#i#,handbookPersonId=#params[i]#)>
				<cfoutput>Reg Person: #i# was linked to handbookperson: #params[i]#<br/></cfoutput>
			</cfif>
		</cfloop>

		<cfif isDefined("params.key")>
			<cfset redirectTo(action="connectToHandbook", key=params.key, params="page=#params.page+1#")>
		<cfelse>
			<cfset redirectTo(action="connectToHandbook", params="page=#params.page+1#")>
		</cfif>

	</cffunction>

	<cffunction name="testfindPersonsRegs">
		<cfset regs = model("ConferenceRegistration").findPersonsRegs(233)>
		<cfdump var="#regs#"><cfabort>
	</cffunction>

	<cffunction name="testgetAvgAgeToDate">
		<cfset test = model("Conferenceregistration").getAvgAgeToDate()>
		<cfdump var="#test#"><cfabort>
	</cffunction>

	<cffunction name="testgetOptionsDateYearsAgo">
		<cfset test = model("Conferenceregistration").getOptionsDateYearsAgo()>
	</cffunction>

<cfscript>
	public function consolidateRegsGo(targetpersonid,temppersonid){
		var regs = "";
		var reg = "";
		var index = 0;
		regs = model("Conferenceregistration").findall(where="equip_peopleid = #temppersonid#");
		for (index=1; index LTE regs.recordcount; index=index+1){
			reg = model("Conferenceregistration").findOne(where="id=#regs.id[index]#");
			reg.equip_peopleid = targetpersonid;
			reg.save();
		};
		var regs2 = model("Conferenceregistration").findall(where="equip_peopleid = #targetpersonid#");

<!---
		returnBack();
--->
	};

	public function consolidateRegs(){
		var whereString = "event='#getevent()#'";
		if (isDefined("params.lname")) {
			whereString = whereString & " AND lname like '#params.lname#%'";
		}
		people = model("Conferenceperson").findAll(select="id, fullnamelastfirstID", where=whereString, include="family,registration(option)", order="fullnamelastfirstID");
		people = distinctsFromQuery(people);
		if (isDefined("params.targetpersonid")){
			targetperson = model("Conferenceperson").findOne(where="id=#params.targetpersonid#",include="family");
		};
		if (isDefined("params.temppersonid")){
			tempperson = model("Conferenceperson").findOne(where="id=#params.temppersonid#", include="family");
	<!---not working
			possibletargetpersonid = model("Conferenceperson").findOne(where="lname='#tempperson.family.lname#'", include="family").equip_familiesId;
	--->
		};
	}

	public function testCountStaffRegs(){
		var test = model("Conferenceregistration").countStaffRegs();
		writeDump(test);abort;
	}

	private function countRegsByType(required string type, string ccstatus="all", string includeFree="false"){
		var loc = arguments
		loc.return = model("Conferenceregistration").countRegsByType(type=loc.type,ccstatus=loc.ccstatus, includeFree=loc.includeFree);
		return loc.return;
	}

</cfscript>

	<cffunction name="testCountRegsByType">
		<cfset var return = "">
		<cfset return = model("Conferenceregistration").countRegsByType(type="Couple",ccstatus="all")>
		<cfdump var='#return#'><cfabort>
	</cffunction>

</cfcomponent>
