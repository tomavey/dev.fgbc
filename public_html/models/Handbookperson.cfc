<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset table("handbookpeople")>
		<!---Associations--->
		<cfset belongsTo(name="Handbookstate", modelName="Handbookstate", foreignKey="stateid")>
		<cfset belongsTo(name="State", modelName="Handbookstate", foreignkey="stateid")>
		<cfset hasMany(name="Handbookpositions", modelName="Handbookposition", foreignKey="personid", dependent="delete", joinType="outer")>
		<cfset hasMany(name="Handbooktags", foreignKey="itemid", dependent="delete")>
		<cfset hasMany(name="Handbookgroup", foreignKey="personid", joinType="outer", dependent="delete")>
		<cfset hasMany(name="Handbookagbminfo", foreignKey="personid", dependent="delete")>
		<cfset hasMany(name="Handbookpictures", foreignKey="personid", dependent="delete")>
		<cfset hasMany(name="Handbooknotes", foreignKey="personid", dependent="delete")>
		<cfset hasOne(name="Handbookprofile", foreignKey="personid", dependent="delete")>

		<!---Nested Properties--->
		<cfset nestedProperties(
            associations="Handbookpositions",
            allowDelete=true
        )>
		<cfset nestedProperties(
            associations="Handbookprofile",
            allowDelete=true
        )>


		<!---Call backs--->
		<cfset afterCreate("logCreates")>
		<cfset beforeUpdate("logUpdates")>
		<cfset afterDelete("logDeletes")>
<!---
		<cfset beforeSave("htmlEdit")>
--->
		<!---Properties--->
		<cfset property(name="alpha", sql="left(lname,1)")>
		<cfset property(
			name="state_mail_abbrev",
			sql="SELECT state_mail_abbrev FROM handbookstates where handbookstates.id = handbookpeople.stateid"
			)>
		<cfset property(
			name="state",
			sql="SELECT state FROM handbookstates where handbookstates.id = handbookpeople.stateid"
			)>
		<cfset property(
			name="selectName",
			sql="CONCAT_WS(', ',lname,fname,city,state_mail_abbrev)"
			)>
		<cfset property(
			name="selectNameID",
			sql="CONCAT_WS(', ',lname,fname,city,state_mail_abbrev,handbookpeople.ID)"
			)>
		<cfset property(
			name="fullname",
			sql="TRIM(CONCAT_WS(' ',fname,lname,suffix))"
			)>
		<cfset property(
			name="spousefullname",
			sql="TRIM(CONCAT_WS(' ',spouse,lname,suffix))"
			)>
		<cfset property(
			name="file",
			sql="SELECT file FROM handbookpictures where personid = handbookpeople.id AND usefor = 'default' LIMIT 1"
			)>

	</cffunction>

<!---CallBack Functions--->

	<cffunction name="logUpdates">
	<cfargument name="modelName" default="Handbookperson">
	<cfargument name="createdBy" default="na">
	<cfif isDefined("session.auth.email")>
		<cfset arguments.createdBy = session.auth.email>
	</cfif>

		<cfset old = model("#arguments.modelName#").findByKey(key=this.id, include="Handbookstate")>
		<cfset new = this>
		<cfset changes= new.changedProperties()>
		<cfoutput>
		<cfloop list="#changes#" index="i">
			<cfif not i is "updatedAt" AND not i is "sendhandbook">
				<cfset newupdate.modelName = arguments.modelName>
				<cfset newupdate.recordId = this.id>
				<cfset newupdate.columnName = i>
				<cfset newupdate.datatype = "update">
				<cfset newupdate.olddata = old[i]>
				<cfset newupdate.newData = new[i]>
				<cfset newupdate.createdBy = "#arguments.createdBy#">
				<cfset update = model("Handbookupdate").create(newupdate)>
			</cfif>
		</cfloop>
		</cfoutput>
		<cfreturn true>
	</cffunction>

	<cffunction name="XlogCreates">
	<cfargument name="modelName" default="Handbookperson">
	<cfargument name="createdBy" default="#session.auth.email#">

		<cfset newSave.modelName = arguments.modelName>
		<cfset newSave.recordId = this.id>
		<cfset newSave.datatype = "new">
		<cfset newSave.createdBy = "#arguments.createdBy#">
		<cfset update = model("Handbookupdate").create(newSave)>

		<cfreturn true>

	</cffunction>

	<cffunction name="logCreates">
		<cfset person = model("HandbookPerson").findByKey(key=this.id, include="handbookState")>
		<cfif isObject(person)>
			  <cfset superLogCreates('HandbookPerson',person.selectName)>
		</cfif>
	</cffunction>


	<cffunction name="logDeletes">
		<cfset person = model("HandbookPerson").findByKey(key=this.id, include="handbookState")>
		<cfif isObject(person)>
			  <cfset superLogDeletes('HandbookPerson',person.selectName)>
		</cfif>
	</cffunction>

<!---Finders--->
	<cffunction name="findAgbm">
	<cfargument name="params" required="true" type="struct">
	<cfset var loc=structNew()>
	<cfset loc.return = structNew()>

		<cfparam name="session.params.key" default="members">
		<cfparam name="params.page" default="1">
		<cfparam name="params.maxpage" default="1000000">
		<cfparam name="params.maxrows" default="-1">

			<!---Set up query strings for model call--->
		<cfset loc.includeString = "Handbookgroup(Handbookgrouptype),Handbookstate,Handbookpositions(Handbookorganization(Handbookdistrict)),Handbookagbminfo,Handbookprofile">

		<cfset loc.orderString = "Lname,Fname,positionTypeId DESC">

		<!---If no search, use a grouptypeid--->
		<cfif not isDefined("params.search")>
			<cfswitch expression="#session.params.key#">
				<cfcase value="members">
					<cfset loc.whereString = "membershipfeeyear = #currentMembershipYear(params)#">
				</cfcase>
				<cfcase value="mail">
					<cfset loc.whereString = "membershipfeeyear < #currentMembershipYear(params)# OR groupTypeId = 16">
				</cfcase>
				<cfcase value="handbook">
					<cfset loc.whereString = "p_sortorder < 500">
				</cfcase>
				<cfcase value="all">
					<cfset loc.whereString = "p_sortorder < 1000">
				</cfcase>
				<cfdefaultcase>
					<cfset loc.whereString = "0=0">
				</cfdefaultcase>
			</cfswitch>

			<!---For Handbook Membership Report--->
			<cfif isDefined("params.category")>
				  <cfset loc.wherestring = "membershipfeeyear = #currentMembershipYear(params)# AND category = #params.category#">
			</cfif>

			<cfif isDefined("params.ordained") and params.ordained>
				  <cfset loc.wherestring = loc.wherestring & " AND ordained = 1">
			</cfif>

			<cfif isDefined("params.licensed") and params.licensed>
				  <cfset loc.wherestring = loc.wherestring & " AND licensed = 1">
			</cfif>

			<cfif isDefined("params.mentored") and params.mentored>
				  <cfset loc.wherestring = loc.wherestring & " AND mentored = 1">
			</cfif>

			<!---For district grouping--->
			<cfif isDefined("params.groupby") and params.groupby is "District">
				  <cfset loc.orderString = "District," & loc.orderString>
			<cfelseif isDefined("params.groupby") and params.groupby is "category">
				  <cfset loc.orderString = "Category," & loc.orderString>
			<cfelseif isDefined("params.groupby") and params.groupby is "age">
				  <cfset loc.orderString = "birthdayasstring">
			</cfif>

			<cfif isDefined("params.district")>
				<cfset params.groupby = "District">
				<cfset loc.whereString = "districtid=#params.district#">
			 	<cfset loc.orderString = "District," & loc.orderString>
			</cfif>

		<cfelse>
		<!---If a search string is provided--->
			<cfset loc.whereString ="lname like '#params.search#%' OR
							fname like '#params.search#%' OR
							city like '#params.search#%' OR
							state_mail_abbrev like '#params.search#%' OR
							district like '#params.search#%'">
			<cfset loc.orderString="lname,fname,positionTypeId DESC">

		</cfif>
		<!---Run the model method using where, order, include and pagination data--->
		<cfset loc.return.people = findAll(
				   		where=loc.whereString,
						order=loc.orderstring,
						include=loc.includeString,
						page=params.page,
						perPage=params.maxpage,
						distinct = true,
						maxrows=params.maxrows
						)>

		<cfset loc.return.params = params>
		<cfreturn loc.return>

	</cffunction>

	<cffunction name="findAllAgbmCat1Ordained">
	<cfargument name="params" required="true" type="struct">
	<cfset var loc=structNew()>
		<cfset params.category = 1>
		<cfset params.ordained = 1>
		<cfset params.licensed = 0>
		<cfset params.mentored = 0>
		<cfset loc.people = findAGBM(params)>
		<cfreturn loc.people>
	</cffunction>

	<cffunction name="findAllAgbmCat1Licensed">
	<cfargument name="params" required="true" type="struct">
	<cfset var loc=structNew()>
		<cfset params.category = 1>
		<cfset params.ordained = 0>
		<cfset params.licensed = 1>
		<cfset params.mentored = 0>
		<cfset loc.peopleAndParams = findAGBM(params)>
		<cfreturn loc.peopleAndParams>
	</cffunction>

	<cffunction name="findAllAgbmCat2Ordained">
	<cfargument name="params" required="true" type="struct">
	<cfset var loc=structNew()>
		<cfset params.category = 2>
		<cfset params.ordained = 1>
		<cfset params.licensed = 0>
		<cfset params.mentored = 0>
		<cfset loc.peopleAndParams = findAGBM(params)>
		<cfreturn loc.peopleAndParams>
	</cffunction>

	<cffunction name="findAllAgbmCat2Licensed">
	<cfargument name="params" required="true" type="struct">
	<cfset var loc=structNew()>
		<cfset params.category = 2>
		<cfset params.ordained = 0>
		<cfset params.licensed = 1>
		<cfset params.mentored = 0>
		<cfset loc.peopleAndParams = findAGBM(params)>
		<cfreturn loc.peopleAndParams>
	</cffunction>

	<cffunction name="findAllAgbmCat1Mentored">
	<cfargument name="params" required="true" type="struct">
	<cfset var loc=structNew()>
		<cfset params.category = 1>
		<cfset params.ordained = 0>
		<cfset params.licensed = 0>
		<cfset params.mentored = 1>
		<cfset loc.peopleAndParams = findAGBM(params)>
		<cfreturn loc.peopleAndParams>
	</cffunction>

	<cffunction name="findAllAgbmCat2Mentored">
	<cfargument name="params" required="true" type="struct">
	<cfset var loc=structNew()>
		<cfset params.category = 2>
		<cfset params.ordained = 0>
		<cfset params.licensed = 0>
		<cfset params.mentored = 1>
		<cfset loc.peopleAndParams = findAGBM(params)>
		<cfreturn loc.peopleAndParams>
	</cffunction>

	<cffunction name="findAllAgbmCat3">
	<cfargument name="params" required="true" type="struct">
	<cfset var loc=structNew()>
		<cfset params.category = 3>
		<cfset params.ordained = 0>
		<cfset params.licensed = 0>
		<cfset params.mentored = 0>
		<cfset loc.peopleAndParams = findAGBM(params)>
		<cfreturn loc.peopleAndParams>
	</cffunction>

	<cffunction name="findAGBMInAgeOrder">
	<cfargument name="params" required="true" type="struct">
	<cfset var loc=structNew()>
		<cfset params.groupby = "age">
		<cfset loc.peopleAndParams = findAGBM(params)>
		<cfreturn loc.peopleAndParams>
	</cffunction>

	<cffunction name="isAGBMMember">
	<cfargument name="personid" required="true" type="numeric">
	<cfargument name="params" required="true" type="struct">
	<cfset var loc = structNew()>
	<cfset loc.check = model("Handbookagbminfo").findOne(where="personid=#arguments.personid# AND membershipfeeyear = #currentMembershipYear(params)#")>
	<cfif isObject(loc.check)>
		<cfset loc.return = true>
	<cfelse>
		<cfset loc.return = false>
	</cfif>
	<cfreturn loc.return>
	</cffunction>

	<cffunction name="findHandbookPeople">
	<cfargument name="params" required="true" type="struct">
	<cfset var loc = structNew()>

		<cfparam name="arguments.params.page" default="1">
		<cfparam name="arguments.params.maxrows" default="100000">
		<cfparam name="arguments.params.perpage" default="100000">

			<cfset whereString = "p_sortorder <= #getNonStaffSortOrder()#">
		<cfif isdefined("arguments.params.alpha")>
			<cfset whereString = whereString & " AND alpha = '#arguments.params.alpha#'">
			<cfset orderString = "lname,fname,state">
			<cfset includeString = "Handbookstate,Handbookpositions">
		<cfelseif isDefined("arguments.params.position")>
			<cfset orderString = "Handbookpositiontypeposition,lname,fname,state">
			<cfset includeString = "Handbookstate,Handbookpositions(Handbookpositiontype)">
		<cfelseif isDefined("arguments.params.all")>
			<cfset orderString = "lname,fname,state">
			<cfset includeString = "Handbookstate,Handbookpositions">
		<cfelse>
			<cfset orderString = "lname,fname,state">
			<cfset includeString = "Handbookstate,Handbookpositions">
			<cfset params.perpage = 30>
		</cfif>
			<cfset handbookpeople = model("Handbookperson").findAll(
				   where=whereString,
				   order=orderString,
				   include=includeString,
				   maxRows=arguments.params.maxrows,
				   page=arguments.params.page,
				   perPage=arguments.params.perpage
				   )>
		<cfreturn handbookpeople>
	</cffunction>

	<cffunction name="getDashboardInfo">
	<cfargument name="params" required="true" type="struct">
	<cfset var loc=structNew()>
		<cfset loc.return.totalFees = 0>
		<cfset loc.return.membersCount = 0>
		<cfset loc.members = model("Handbookperson").findAGBM(params).people>
		<cfoutput query="loc.members" group="id">
			<cfset loc.return.totalFees = loc.return.totalFees + membershipfee>
			<cfset loc.return.membersCount = loc.return.membersCount +1>
		</cfoutput>
		<cfreturn loc.return>
	</cffunction>

<!---Getter--->
	<cffunction name="currentMembershipYear">
	<cfargument name="params" required="false" type="struct">
	<cfset var loc = structNew()>
	  <cfset loc.return = year(now())>

	   	<cfif isDefined("params.currentMembershipyear")>
	   		<cfset loc.return = params.currentMembershipYear>
	   	<cfelseif isDefined("session.agbm.currentmembershipyear")>
	   		<cfset loc.return = session.agbm.currentmembershipyear>
		<cfelse>
			<cfif dateCompare(createODBCDate(now()),createODBCDate(application.wheels.agbmDeadlineDate)) EQ -1>
		 		  <cfset loc.return = loc.return-1>
			</cfif>
		</cfif>
		<cfreturn loc.return>
	</cffunction>

<!---Misc Actions--->
	<cffunction name="swapSortOrder">
	<cfargument name="thisSortorder" required="true" type="numeric">
	<cfargument name="thisId" required="true" type="numeric">
	<cfargument name="otherSortorder" required="true" type="numeric">
	<cfargument name="otherId" required="true" type="numeric">
	<cfargument name="dsn" default="#application.wheels.dataSourceName#">

		<cfquery datasource="#arguments.dsn#">
    		UPDATE handbookpositions
    		SET p_sortorder = #arguments.otherSortorder#
    		WHERE id = #arguments.thisid#
		</cfquery>

		<cfquery datasource="#arguments.dsn#">
    		UPDATE handbookpositions
    		SET p_sortorder = #arguments.thisSortorder#
    		WHERE id = #arguments.otherid#
		</cfquery>

		<cfreturn true>

	</cffunction>

	<cffunction name="findDatesByType">
	<cfargument name="datetype" required="true" type="string">

	<cfset var loc=structNew()>

	<cfif arguments.datetype contains "birthday">
		  <cfset loc.orderstring = "birthdayMonthNumber,birthdayDayNumber">
	<cfelseif arguments.datetype contains "anniversary">
		  <cfset loc.orderstring = "anniversaryMonthNumber,anniversaryDayNumber">
	</cfif>

<!---Remove personid after--->
	<cfset loc.whereString = "#arguments.datetype#AsString IS NOT NULL">

	<!---Remove spouse birthdays and anniversaries where spouse name is blank - probably deceased--->
	<cfif arguments.datetype is "wifesbirthday" OR arguments.datetype is "anniversary">
		<cfset loc.whereString = loc.wherestring & " AND spouse IS NOT NULL">
	</cfif>

	<cfset arguments.datetype = arguments.datetype & "asstring">

		<cfset loc.profiles = model("Handbookprofile").findAll(
			   include="Handbookperson(Handbookstate)",
			   where=loc.whereString,
			   order=loc.orderstring
			   )>

		<cfreturn loc.profiles>

	</cffunction>

	<cffunction name="findDatesSorted">
	<cfargument name="datetype" required="true" type="string">
	<cfargument name="orderby" default="birthdayMonthNumber,birthdayDayNumber,fullname">
	<cfset var loc=structNew()>
	<cfif arguments.datetype is "birthday">
		<cfset loc.person = findDatesByType(arguments.dateType)>
		<cfset loc.spouse = findDatesByType("wifesbirthday")>

		<cfloop query="loc.spouse">
			<cfset querySetCell(loc.spouse,"fullname",spousefullname,currentRow)>
			<cfset querySetCell(loc.spouse,"fname",spouse,currentRow)>
			<cfset querySetCell(loc.spouse,"birthdayDayNumber",wifesbirthdayDayNumber,currentRow)>
			<cfset querySetCell(loc.spouse,"birthdayMonthNumber",wifesbirthdayMonthNumber,currentRow)>
			<cfset querySetCell(loc.spouse,"birthdayWeekNumber",wifesbirthdayWeekNumber,currentRow)>
			<cfset querySetCell(loc.spouse,"birthdayDayOfYearNumber",wifesbirthdayDayOfYearNumber,currentRow)>
			<cfset querySetCell(loc.spouse,"birthdayAsString",wifesbirthdayAsString,currentRow)>
			<cfif len(spouse_email)>
				<cfset querySetCell(loc.spouse,"handbookpersonemail","#spouse_email#",currentRow)>
			</cfif>
		</cfloop>

		<cfquery dbtype="query" name="loc.profiles">
			SELECT *
			FROM loc.person
			UNION
			SELECT *
			FROM loc.spouse
		</cfquery>

		<cfquery dbtype="query" name="loc.profiles">
			SELECT *
			FROM loc.profiles
			ORDER BY #arguments.orderby#
		</cfquery>

	<cfelse>
		<cfset loc.profiles = findDatesByType(arguments.dateType)>
	</cfif>

	<cfreturn loc.profiles>
	</cffunction>

	<cffunction name="findDatesThisWeek" hint="I get findDatesSorted and then filter for this week">
	<cfargument name="type" required="true" type="string">
	<cfargument name="today" default="#dayOfYear(now())#">
	<cfargument name="until" default="#dayOfYear(now())+7#">

		<cfset datesSorted = findDatesSorted(arguments.type)>

		<cfset thisweek = week(now())>
		<cfquery dbtype="query" name="datesthisweek">
			SELECT *
			FROM datesSorted
			WHERE #arguments.type#DayOfYearNumber BETWEEN #arguments.today-1# AND #arguments.until#
			ORDER BY #arguments.type#MonthNumber,#arguments.type#daynumber
		</cfquery>

		<cfreturn datesThisWeek>

	</cffunction>

	<cffunction name="findDatesToday">
	<cfargument name="type" required="true" type="string">
	<cfargument name="now" required="true" type="string">
	<cfargument name="today" default="#dayOfYear(arguments.now)#">
	<cfargument name="monthnumber" default="#month(arguments.now)#">
	<cfargument name="daynumber" default="#day(arguments.now)#">

		<cfset datesSorted = findDatesSorted(arguments.type)>

		<cfquery dbtype="query" name="datestoday">
			SELECT *
			FROM datesSorted
			WHERE #arguments.type#MonthNumber = #arguments.monthnumber# AND #arguments.type#dayNumber = #arguments.daynumber#
			ORDER BY #arguments.type#daynumber
		</cfquery>

		<cfreturn datestoday>

	</cffunction>

	<cffunction name="findFocus">
	<cfargument name="region" required="true" type="string">
	<cfset var loc = structNew()>

		<cfset loc.handbookpeople = findAll(select="fname, lname, handbookpeople.email, region", where="p_sortorder < 500 AND region = '#arguments.region#' AND fnamegender = 'm'", include="Handbookstate,Handbookpositions(Handbookorganization(Handbookdistrict))", order="lname,fname,email")>

		<cfquery datasource="#application.wheels.datasourcename#" name="loc.focuspeople">
			SELECT fname, lname, p.email, menuname as region
			FROM focus_registrants p
			JOIN focus_registrations r
				ON r.registrantid = p.id
			JOIN focus_items i
				ON r.itemid = i.id
			JOIN focus_retreats s
				ON i.retreatid = s.id
			WHERE s.menuname = '#arguments.region#'
			ORDER BY lname,fname,email
		</cfquery>

		<cfquery dbtype="query" name="loc.allpeople">
			SELECT *
			FROM loc.handbookpeople
			UNION
			SELECT *
			FROM loc.focuspeople
		</cfquery>

		<cfquery dbtype="query" name="loc.people">
			SELECT DISTINCT email, fname, lname, region
			FROM loc.allpeople
			ORDER BY lname,fname,email
		</cfquery>

		<cfreturn loc.people>

	</cffunction>

	<cffunction name="findAllStaff">
		<cfset staff = findAll(select="id, selectname", where="p_sortorder <= 500 AND position <> 'Removed From Staff'", include="Handbookpositions,Handbookstate")>
		<cfset staff = queryToJson(staff)>
		<cfreturn staff>
	</cffunction>

	<cffunction name="findStaff">
	<cfargument name="staffid" required="true" type="numeric">
		<cfset staff = findAll(select="id,fname,lname,spouse,file,address1,address2,city,state,zip,phone,phone2,email,name,position,birthdayasstring,anniversaryasstring,organizationid",where="id=#arguments.staffid#", include="Handbookpositions(Handbookorganization),Handbookstate,Handbookprofile")>
		<cfset staff = queryToJson(staff)>
		<cfreturn staff>
	</cffunction>

	<cffunction name="clearSendHandbooks">
		<cfquery datasource="#application.wheels.dataSourceName#" name="cleared" result="whatever">
			UPDATE handbookpeople
			SET sendhandbook = ""
			WHERE id > 0
		</cfquery>
		<cfreturn true>
	</cffunction>

<cfscript>

public function getHandbookReviewStruct(
	type = "Everyone",
	lastReviewedBefore = dateFormat(now()+1),
	orderby = "lname",
	go = false,
	tag="",
	username="none",
	maxrows = 10000000
){
	var loc=arguments;
	var whereString = "id > 0 AND (reviewedAt < '#loc.lastReviewedBefore#' OR reviewedAt IS NULL) AND (updatedAt < '#loc.lastReviewedBefore#')";
	if (len(tag)){whereString = whereString & " AND tag='#tag#' AND username = '#username#'"};
	loc.people = {};
	loc.rowcount = 0;
	loc.previousid = 0;
	if (loc.go) {
		whereString = $buildWhereString(whereString,loc.type);
		selectString = "handbookpeople.id,lname,concat(lname,', ',fname,': ',city) as SelectName,email,email2,DATE_FORMAT(reviewedAt,'%d %b %y') as reviewedAt,reviewedBy,DATE_FORMAT(handbookpeople.updatedAt,'%d %b %y') as updatedAt";
		loc.peopleQ = findAll(select=selectString, where = whereString, include="State,Handbookpositions,Handbooktags", maxrows=maxrows, order=orderby);
		loc.people = $peopleQueryToArray(loc.peopleQ);
		loc.people = $removeInValidEmail(loc.people);
		loc.people = $addLastEmailToConfirm(loc.people);
		loc.people = $removeDuplicates(loc.people);
		return loc.people;		
	}
	else {
		return $testPeople();
	}
}

private function $buildWhereString(required string whereString,required string type){
	var loc = arguments;
	switch (loc.type) {
		case "Staff":
			loc.newWhereString = loc.whereString & " AND p_sortorder < 500";
			break;
		case "Non-Staff":
			loc.newWhereString = loc.wherestring & " AND p_sortorder => 500 AND p_sortorder < 900";
			break;
		case "Everyone":
			loc.newWhereString = loc.wherestring & " AND p_sortorder < 900";
			break;				
	};
	return loc.newWhereString;
}

private function $peopleQueryToArray(peopleQuery){
	var loc = arguments;
	loc.peopleArray = queryToArray(loc.peopleQuery);
	return loc.peopleArray;
}

</cfscript>	

	<cffunction name="$addLastEmailToConfirm">
	<cfargument name="thisArray" required="true">
	<cfset var loc = arguments>
	<cfset loc.newkey = arraylen(loc.thisarray) +1>
			<cfset loc.thisarray[loc.newkey].email = "tomavey@fgbc.org">
			<cfset loc.thisarray[loc.newkey].email2 = "tomavey@fgbc.org">
			<cfset loc.thisarray[loc.newkey].id = 233>
			<cfset loc.thisarray[loc.newkey].selectname = "Test Person - ###arrayLen(loc.thisarray)# at end of list">
			<cfset loc.thisarray[loc.newkey].lname = "Avey">
			<cfset loc.thisarray[loc.newkey].reviewedAt = "2016-09-01">
			<cfset loc.thisarray[loc.newkey].reviewedBy = "tomavey@fgbc.org">
			<cfset loc.thisarray[loc.newkey].updatedAt = "2016-09-01">
	<cfreturn loc.thisarray>	
	</cffunction>

	<cffunction name="$testPeople">
	<cfset var emails = "tomavey@fgbc.org,tomavey@comcast.net">
	<cfset var testPeople = []>
	<cfset thisPerson = {}>
	<cfset var loc=structNew()>
	<cfloop list='#emails#' index="loc.i">
		<cfset thisperson.selectName = "Tom Avey">
		<cfset thisperson.lname = "Avey">
		<cfset thisperson.id = 100>
		<cfset thisperson.email = loc.i>
		<cfset thisperson.email2 = loc.i>
		<cfset thisperson.reviewedAt = "September 1, 2016">
		<cfset thisperson.updatedAt = "September 1, 2016">
		<cfset thisperson.reviewedBy = loc.i>
		<cfset arrayAppend(testPeople,thisPerson)>
		<cfset thisperson = {}>
	</cfloop>
		<cfset thisperson.selectName = "Tom Avey">
		<cfset thisperson.lname = "Avey">
		<cfset thisperson.id = 100>
		<cfset thisperson.email = "tomavey@fgbc.org;tomavey@comcast.net">
		<cfset thisperson.email2 = loc.i>
		<cfset thisperson.reviewedAt = "September 1, 2016">
		<cfset thisperson.updatedAt = "September 1, 2016">
		<cfset thisperson.reviewedBy = loc.i>
		<cfset arrayAppend(testPeople,thisPerson)>
		<cfset thisperson = {}>
	<cfreturn testPeople>
	</cffunction>

	<cffunction name="$removeDuplicates">
	<cfargument name="handbookReviewStruct" required='true' type="array">
	<cfset var loc = arguments>
	<cfset loc.newArray = []>
	<cfloop from="1" to="#arraylen(loc.handbookReviewStruct)#" index="loc.i">
		<cfif !arrayFind(loc.newArray,loc.handbookReviewStruct[loc.i])>
			<cfset arrayAppend(loc.newArray,loc.handbookReviewStruct[loc.i])>
		</cfif>	
	</cfloop>
	<cfreturn loc.newarray>
	</cffunction>

	<cffunction name="$removeInValidEmail">
	<cfargument name="handbookReviewArray" required='true' type="array">
	<cfset var loc = arguments>
	<cfset loc.newArray = []>
	<cfloop from="1" to="#arraylen(loc.handbookReviewArray)#" index="loc.i">
		<cfif isvalid("email",loc.handbookReviewArray[loc.i].email)>
			<cfset arrayAppend(loc.newArray,loc.handbookReviewArray[loc.i])>
		</cfif>	
	</cfloop>
	<cfreturn loc.newarray>
	</cffunction>

<!---Not sure where this is used--->
	<cffunction name="handbookReport">

	</cffunction>



</cfcomponent>