//
//Written by Tom Avey for the Charis Fellowship
//Refactored October 2019 to use cfscript
//Used by the online handbook application - people (church and ministry staff)
//
component extends="Model" output="false" {


	function init() {
		table("handbookpeople")
		// Associations
		belongsTo(name="Handbookstate", modelName="Handbookstate", foreignKey="stateid")
		belongsTo(name="State", modelName="Handbookstate", foreignkey="stateid")
		hasMany(name="Positions", modelName="Handbookposition", foreignKey="personid", dependent="delete", joinType="outer")
		hasMany(name="Handbookpositions", modelName="Handbookposition", foreignKey="personid", dependent="delete", joinType="outer")
		hasMany(name="Handbooktags", foreignKey="itemid", dependent="delete")
		hasMany(name="Handbookgroup", foreignKey="personid", joinType="outer", dependent="delete")
		hasMany(name="Handbookagbminfo", foreignKey="personid", dependent="delete")
		hasMany(name="Handbookpictures", foreignKey="personid", dependent="delete")
		hasMany(name="Handbooknotes", foreignKey="personid", dependent="delete")
		hasOne(name="Handbookprofile", foreignKey="personid", dependent="delete")
		// Nested Properties
		nestedProperties(
			associations="Handbookpositions",
			allowDelete=true
		)
		nestedProperties(
			associations="Handbookprofile",
			allowDelete=true
		)
		// Call backs
		afterCreate("logCreates")
		beforeUpdate("logUpdates")
		afterDelete("logDeletes")
		// Properties
		property(name="alpha", sql="left(lname,1)")
		property(
			name="state_mail_abbrev",
			sql="SELECT state_mail_abbrev FROM handbookstates where handbookstates.id = handbookpeople.stateid"
		)
		property(
			name="state",
			sql="SELECT state FROM handbookstates where handbookstates.id = handbookpeople.stateid"
		)
		property(
			name="selectName",
			sql="CONCAT_WS(', ',lname,fname,city,state_mail_abbrev)"
		)
		property(
			name="selectNameID",
			sql="CONCAT_WS(', ',lname,fname,city,state_mail_abbrev,handbookpeople.ID)"
		)
		property(
			name="fullname",
			sql="TRIM(CONCAT_WS(' ',fname,lname,suffix))"
		)
		property(
			name="spousefullname",
			sql="TRIM(CONCAT_WS(' ',spouse,lname,suffix))"
		)
		property(
			name="file",
			sql="SELECT file FROM handbookpictures where personid = handbookpeople.id AND usefor = 'default' LIMIT 1"
		)
	}






<!------------------------------------------>
<!---CALLBACKS FOR UPDATE AND CREATE LOGS--->
<!------------------------------------------>

	function logUpdates(modelName="Handbookperson"){
		superLogUpdates(arguments.modelName)
	}

	function logCreates(modelName="Handbookperson") {
			superLogCreates(arguments.modelName)
	}
	
	function logDeletes(modelName="Handbookperson") {
			superLogDeletes(arguments.modelName)
	}
<!------------------------------------------------->
<!---END OF CALLBACKS FOR UPDATE AND CREATE LOGS--->
<!------------------------------------------------->





<!----------------------->
<!------AGBM FINDERS----->
<!----------------------->
	
	function findAgbm(required struct params) {
		var loc=structNew()
		loc.return = structNew()
		cfparam( default="members", name="session.params.key" )
		cfparam( default=1, name="params.page" )
		cfparam( default=1000000, name="params.maxpage" )
		cfparam( default=-1, name="params.maxrows" )
		// Set up query strings for model call
		loc.includeString = "Handbookgroup(Handbookgrouptype),Handbookstate,Handbookpositions(Handbookorganization(Handbookdistrict)),Handbookagbminfo,Handbookprofile"
		loc.orderString = "Lname,Fname,positionTypeId DESC"
		// If no search, use a grouptypeid
		if ( !isDefined("params.search") ) {
			switch ( session.params.key ) {
				case  "members":
					loc.whereString = "membershipfeeyear = #currentMembershipYear(params)#"
					break
				case  "mail":
					loc.whereString = "membershipfeeyear < #currentMembershipYear(params)# OR groupTypeId = 16"
					break
				case  "handbook":
					loc.whereString = "p_sortorder < 500"
					break
				case  "all":
					loc.whereString = "p_sortorder < 1000"
					break
				default:
					loc.whereString = "id>0"
					break
			}
			// For Handbook Membership Report
			if ( isDefined("params.category") ) {
				loc.wherestring = "membershipfeeyear = #currentMembershipYear(params)# AND category = #params.category#"
			}
			if ( isDefined("params.ordained") && params.ordained ) {
				loc.wherestring = loc.wherestring & " AND ordained = 1"
			}
			if ( isDefined("params.licensed") && params.licensed ) {
				loc.wherestring = loc.wherestring & " AND licensed = 1"
			}
			if ( isDefined("params.commissioned") && params.commissioned ) {
				loc.wherestring = loc.wherestring & " AND commissioned = 1"
			}
			if ( isDefined("params.mentored") && params.mentored ) {
				loc.wherestring = loc.wherestring & " AND mentored = 1"
			}
			// For district grouping
			if ( isDefined("params.groupby") && params.groupby == "District" ) {
				loc.orderString = "District," & loc.orderString
			} else if ( isDefined("params.groupby") && params.groupby == "category" ) {
				loc.orderString = "Category," & loc.orderString
			} else if ( isDefined("params.groupby") && params.groupby == "age" ) {
				loc.orderString = "birthdayasstring"
			}
			if ( isDefined("params.district") ) {
				params.groupby = "District"
				loc.whereString = "districtid=#params.district#"
				loc.orderString = "District," & loc.orderString
			}
			// writeDump(loc.whereString);abort;
		} else {
			// If a search string is provided
			loc.whereString ="lname like '#params.search#%' OR
								fname like '#params.search#%' OR
								city like '#params.search#%' OR
								state_mail_abbrev like '#params.search#%' OR
								district like '#params.search#%'"
			loc.orderString="lname,fname,positionTypeId DESC"
		}
		// Run the model method using where, order, include and pagination data
		loc.return.people = findAll(
							where=loc.whereString,
							order=loc.orderstring,
							include=loc.includeString,
							page=params.page,
							perPage=params.maxpage,
							distinct = true,
							maxrows=params.maxrows
							)
		loc.return.params = params
		return loc.return
	}

	private function $getCatCodes(required string catCode){
		var codesStruct = {
			Cat1Ordained: { category: "1", ordained: "1", licensed: "0", mentored: "0" },
			Cat0Ordained: { category: "0", ordained: "1", licensed: "0", mentored: "0" },
			Cat1Licensed: { category: "1", ordained: "0", licensed: "1", mentored: "0" },
			Cat0Commissioned: { category: "0", ordained: "0", licensed: "0", mentored: "0" },
			Cat2Ordained: { category: "2", ordained: "1", licensed: "0", mentored: "0" },
			Cat2Licensed: { category: "2", ordained: "1", licensed: "1", mentored: "0" },
			Cat1Mentored: { category: "1", ordained: "0", licensed: "0", mentored: "1" },
			Cat2Mentored: { category: "2", ordained: "0", licensed: "0", mentored: "1" },
			Cat3: { category: "3", ordained: "0", licensed: "0", mentored: "0" }
		}
		return codesStruct[arguments.catCode]
	}

	private function $findAllAgbmByCat( required struct params, required struct catCodes ){
		structAppend( arguments.params,arguments.catCodes )
		return findAGBM( arguments.params )
	}

	function findAllAgbmByCat( required struct params, required string catCode){
		return $findAllAgbmByCat( params,$getCatCodes(arguments.catCode) )
	}

	function findAGBMInAgeOrder(required struct params) {
		var loc=structNew()
		params.groupby = "age"
		loc.peopleAndParams = findAGBM(params)
		return loc.peopleAndParams
	}

	function findPastorsWives(string titleIncludesList = 'pastor,chaplain', string onlyIfEmail = false){
		var titleIncludes = $buildMysqlLikeString(titleIncludesList)
		var selectString = "handbookpeople.id, spouse, lname, spouse_email, handbookpeople.address1, handbookpeople.address2, city, state_mail_abbrev, handbookpeople.zip, position AS hisPosition, (CONCAT_WS(', ',org_city,state_mail_abbrev,handbookorganizations.name)) AS churchNameCity"
		var whereString = "deletedAt IS NULL AND fnameGender = 'M' AND spouse IS NOT NULL AND (#titleIncludes#)"
		if ( onlyIfEmail ) {
			whereString = whereString & " AND spouse_email IS NOT NULL"
		}
		var includeString = "State,Handbookpositions(Handbookorganization)"
		var orderString = "lname, spouse"
		var maxRows = 1000000
		var pastorsWives = model("Handbookperson").findAll(
			select = selectString,
			where = whereString,
			maxRows = maxRows,
			include = includeString,
			order = orderString
		)
		return pastorsWives
	}

	function isAGBMMember(required numeric personid, required struct params) {
		var loc = structNew()
		loc.check = model("Handbookagbminfo").findOne(where="personid=#arguments.personid# AND ( membershipfeeyear = #currentMembershipYear(params)#)")
		loc.check2 = model("Handbookagbminfo").isAgbmMember(personid)
		if ( isObject(loc.check) || loc.check2 ) {
			loc.return = true
		} else {
			loc.return = false
		}
		return loc.return
	}
	
	function getAGBMDashboardInfo(required struct params) {
		var loc=structNew()
		loc.return.totalFees = 0
		loc.return.membersCount = 0
		loc.members = model("Handbookperson").findAGBM(params).people
		for ( var i in members ) {
			loc.return.totalFees = loc.return.totalFees + i.membershipfee
			loc.return.membersCount = loc.return.membersCount +1
		}
		return loc.return
	}
<!------------------------------>
<!------END OF AGBM FINDERS----->
<!------------------------------>






<!--------------------->
<!---GENERAL FINDERS--->
<!--------------------->

	function getAllEmails(required numeric maxsortorder, maxrows = 1000000){
		//Get all emails connected with active churches and staff
		var allemails
		var distinctemails
		var peopleEmails1 = findAll(select="handbookpeople.email as emailsend, fname as name", where="p_sortorder <= #maxsortorder# AND statusid IN (1,8,3,4,2,9,10,11)", maxrows=maxrows, include="Handbookstate,Handbookpositions(Handbookorganization)")
		var peopleEmails2 = findAll(select="handbookpeople.email2 as emailsend, fname as name", where="p_sortorder <= #maxsortorder# AND statusid IN (1,8,3,4,2,9,10,11)", maxrows=maxrows, include="Handbookstate,Handbookpositions(Handbookorganization)")
		var churchEmails1 = model("Handbookorganization").findAll(where='statusid IN (1,8,3,4,2,9,10,11)', select="handbookorganizations.email as emailsend, name as name", maxrows=maxrows, include="Handbookstate")
		cfquery( dbtype="query", name="allemails" ) {

			writeOutput("SELECT *
				FROM peopleEmails1
				UNION
				SELECT *
				FROM peopleEmails2
				UNION
				SELECT *
				FROM churchEmails1")
		}
		cfquery( dbtype="query", name="distinctemails" ) {

			writeOutput("SELECT DISTINCT emailsend, name
				FROM allemails
				ORDER BY emailsend,name")
		}
		return distinctemails
	}

	function findHandbookPeople(required struct params) {
		var loc = structNew()
		cfparam( default=1, name="arguments.params.page" )
		cfparam( default=100000, name="arguments.params.maxrows" )
		cfparam( default=100000, name="arguments.params.perpage" )
		whereString = "p_sortorder <= #getNonStaffSortOrder()#"
		if ( isdefined("arguments.params.alpha") ) {
			whereString = whereString & " AND alpha = '#arguments.params.alpha#'"
			orderString = "lname,fname,state"
			includeString = "Handbookstate,Handbookpositions"
		} else if ( isDefined("arguments.params.position") ) {
			orderString = "Handbookpositiontypeposition,lname,fname,state"
			includeString = "Handbookstate,Handbookpositions(Handbookpositiontype)"
		} else if ( isDefined("arguments.params.all") ) {
			orderString = "lname,fname,state"
			includeString = "Handbookstate,Handbookpositions"
		} else {
			orderString = "lname,fname,state"
			includeString = "Handbookstate,Handbookpositions"
			params.perpage = 30
		}
		handbookpeople = model("Handbookperson").findAll(
						 where=whereString,
						 order=orderString,
						 include=includeString,
						 maxRows=arguments.params.maxrows,
						 page=arguments.params.page,
						 perPage=arguments.params.perpage
						 )
		return handbookpeople
	}

	function findAllStaff() {
		staff = findAll(select="id, selectname", where="p_sortorder <= 500 AND position <> 'Removed From Staff' AND (private = 'NO' || private == NULL)", include="Handbookpositions,Handbookstate", order="selectname")
		cfquery( dbtype="query", name="staff" ) { //Note: queryExecute() is the preferred syntax but this syntax is easier to convert generically

			writeOutput("select DISTINCT *
				from staff
				order by selectname")
		}
		staff = queryToJson(staff)
		return staff
	}

	function findStaff(required numeric staffid) {
		staff = findAll(select="id,fname,lname,spouse,file,address1,address2,city,state,zip,phone,phone2,email,name,position,birthdayasstring,anniversaryasstring,organizationid",where="id=#arguments.staffid# AND (private = 'NO' || private == NULL)", include="Handbookpositions(Handbookorganization),Handbookstate,Handbookprofile")
		staff = queryToJson(staff)
		return staff
	}
<!---------------------------->
<!---END OF GENERAL FINDERS--->
<!---------------------------->
	




<!------------------------------------------------->
<!---MODELS FOR BIRTHDAY AND ANNIVERSARY REPORTS--->	
<!------------------------------------------------->
	
function findDatesSorted(required string datetype, orderby="birthdayMonthNumber,birthdayDayNumber,fullname") {
	var loc=structNew()
	if ( arguments.datetype == "birthday" ) {
		loc.person = $findDatesByType(arguments.dateType)
		loc.spouse = $findDatesByType("wifesbirthday")
		$moveSpouseInfoToPerson(spouse=loc.spouse)
		loc.profiles = $combineSpouseAndPersonAndSort(person = loc.person, spouse = loc.spouse)
	} else {
		loc.profiles = $findDatesByType(arguments.dateType)
	}
	return loc.profiles
	ddd(loc.profiles)
}

function findDatesThisWeek(required string type, today="#dayOfYear(now())#", until="#dayOfYear(now())+6#") {
		var loc = arguments		
		loc.datesSorted = findDatesSorted(loc.type)
		//filter dates for those within the next 7 days
		loc.datesThisWeek = queryFilter(datesSorted,function(item){
			return item['#loc.type#DayOfYearNumber'] >= loc.today && item['#loc.type#DayOfYearNumber'] <= loc.until
		})
		return loc.datesThisWeek
	}
	
	function findDatesToday(required string type, required string now, today="#dayOfYear(arguments.now)#", monthnumber="#month(arguments.now)#", daynumber="#day(arguments.now)#") {
		var datesSorted = findDatesSorted(arguments.type)

		cfquery( dbtype="query", name="datestoday" ) { //Note: queryExecute() is the preferred syntax but this syntax is easier to convert generically
			writeOutput("SELECT *
				FROM datesSorted
				WHERE #arguments.type#MonthNumber = #arguments.monthnumber# AND #arguments.type#dayNumber = #arguments.daynumber#
				ORDER BY #arguments.type#daynumber")
		}
		return datestoday
	}

	function $findDatesByType(required string datetype) {
		var loc=structNew()
		loc.selectString=$getSelectStringForDates()
		//Set the order based on date type
		if ( arguments.datetype contains "birthday" ) {
			loc.orderstring = "birthdayMonthNumber,birthdayDayNumber"
		} else if ( arguments.datetype contains "anniversary" ) {
			loc.orderstring = "anniversaryMonthNumber,anniversaryDayNumber"
		}
		//Set the whereString for datetype
		loc.whereString = "#arguments.datetype#AsString != NULL"
		//Remove spouse birthdays and anniversaries where spouse name is blank - probably deceased
		if ( arguments.datetype == "wifesbirthday" || arguments.datetype == "anniversary" ) {
			loc.whereString = loc.wherestring & " AND spouse != NULL"
		}
		//Get profiles
		loc.profiles = model("Handbookprofile").findAll(
					 include="Handbookperson(Handbookstate)",
					 select = loc.selectString,
					 where=loc.whereString,
					 order=loc.orderstring
					 )			 
		return loc.profiles
	}
<!-------------------------------------------------------->
<!---END OF MODELS FOR BIRTHDAY AND ANNIVERSARY REPORTS--->	
<!-------------------------------------------------------->






<!----------------------------------------->	
<!---USED FOR FOCUS RETREAT MAILING LIST--->
<!----------------------------------------->	
	function findFocus(required struct params) {
		var loc = structNew()
		loc.region = params.key
		loc.whereString = "p_sortorder < 500 AND focusretreat = '#loc.region#'"
		if ( params.includeWomen ) {
			loc.whereString = loc.whereString & "  AND fnamegender = 'm'"
		}
		//  Get names from handbook people with positions in organizations in districts in regions 
		loc.handbookpeople = findAll(select="fname, lname, handbookpeople.email, region, handbookpeople.phone2 as phone", where=loc.whereString, include="Handbookstate,Handbookpositions(Handbookorganization(Handbookdistrict))", order="lname,fname,email")
		loc.focuspeople = $findAllRegional(region=loc.region, yearsAgo=params.yearsAgo)
		//  Get names from past focus registrations in that region 
		//  Combine both queries 
		loc.allpeople = combineTwoQueries(loc.handbookpeople, loc.focuspeople)
		try {
			loc.addedpeople = $focusEmailAdds(loc.region)
			loc.allpeople = combineTwoQueries(loc.allpeople, loc.addedpeople)
		} catch (any cfcatch) {
		}
		//  remove duplicates 
		loc.people = distinctsFromQuery(loc.allpeople)
		return loc.people
	}

	function $findAllRegional(required string region, required numeric yearsago){
		var loc={}
		loc.date = dateFormat(dateAdd("yyyy",-arguments.yearsAgo, now()),"yyyy-mm-dd")
		cfquery( name="loc.focuspeople", datasource=application.wheels.datasourcename ) {
	
			writeOutput("SELECT fname, lname, p.email, phone, menuname as region
				FROM focus_registrants p
				JOIN focus_registrations r
					ON r.registrantid = p.id
				JOIN focus_items i
					ON r.itemid = i.id
				JOIN focus_retreats s
					ON i.retreatid = s.id
				WHERE s.menuname = '#arguments.region#'
					AND r.createdAt > '#loc.date#'
				ORDER BY lname,fname,email")
		}
		return loc.focuspeople
	}
	
	function $focusEmailAdds(retreat){
		var path =  CGI.http_host
		var file = '/files/focus/mailListAddOns/' & #retreat# & ".txt"
		var filePath = expandPath(file)
		cffile(action="read" file=filepath variable="list")
		return listToQuery(list, "email")
	}



<!------------------------------------------------>	
<!---END OF USED FOR FOCUS RETREAT MAILING LIST--->
<!------------------------------------------------>	





<!----------------------------->
<!---HANDBOOK REVIEW ACTIONS--->
<!----------------------------->

	public function getHandbookReviewStruct(
		type = "Everyone",
		lastReviewedBefore = dateFormat(now()+1),
		orderby = "lname",
		go = false,
		tag="",
		username="none",
		maxrows = -1
	){
		if ( isLocalMachine() ) { arguments.maxrows = 10 }
		var loc=arguments
		var whereString = "id > 0 AND (reviewedAt < '#loc.lastReviewedBefore#' OR reviewedAt IS NULL) AND (updatedAt < '#loc.lastReviewedBefore#')"
		loc.people = {}
		loc.rowcount = 0
		loc.previousid = 0
		if (loc.go) {
			whereString = $buildWhereString(whereString,loc.type)
			selectString = "handbookpeople.id,lname,concat(lname,', ',fname) AS SelectName,email,email2,DATE_FORMAT(reviewedAt,'%d %b %y') AS reviewedAt,reviewedBy,DATE_FORMAT(handbookpeople.updatedAt,'%d %b %y') AS updatedAt"

			loc.peopleQ = findAll(select=selectString, where = whereString, include="State,Handbookpositions,Handbooktags", maxRows=maxrows, order=orderby)

			loc.people = $peopleQueryToArray(loc.peopleQ)
			loc.people = $removeInValidEmail(loc.people)
			loc.people = $addLastEmailToConfirm(loc.people)
			loc.people = $removeDuplicates(loc.people)
			if ( len(tag) ){ loc.people = queryFilter(loc.people,function(el){ el.tag == tag } ) }
			return loc.people		
		}
		else {
			return $testPeople()
		}
	}

	private function $buildWhereString(required string whereString,required string type){
		var loc = arguments
		switch (loc.type) {
			case "Staff":
				loc.newWhereString = loc.whereString & " AND p_sortorder < 500"
				break;
			case "Non-Staff":
				loc.newWhereString = loc.wherestring & " AND p_sortorder => 500 AND p_sortorder < 900"
				break;
			case "Everyone":
				loc.newWhereString = loc.wherestring & " AND p_sortorder < 900"
				break;				
		}
		return loc.newWhereString
	}

	private function $peopleQueryToArray(peopleQuery){
		var loc = arguments
		loc.peopleArray = queryToArray(loc.peopleQuery)
		return loc.peopleArray
	}

	function $addLastEmailToConfirm(required thisArray) {
		var loc = arguments
		loc.newkey = arraylen(loc.thisArray) +1
		loc.thisarray[loc.newkey].email = "tomavey@fgbc.org"
		loc.thisarray[loc.newkey].email2 = "tomavey@fgbc.org"
		loc.thisarray[loc.newkey].id = 233
		loc.thisarray[loc.newkey].selectname = "Test Person - ###arrayLen(loc.thisarray)# at end of list"
		loc.thisarray[loc.newkey].lname = "Avey"
		loc.thisarray[loc.newkey].reviewedAt = "2016-09-01"
		loc.thisarray[loc.newkey].reviewedBy = "tomavey@fgbc.org"
		loc.thisarray[loc.newkey].updatedAt = "2016-09-01"
		return loc.thisarray
	}
	
	function $testPeople() {
		var emails = "tomavey@fgbc.org,tomavey@comcast.net"
		var testPeople = []
		thisPerson = {}
		var loc=structNew()
		for ( loc.i in emails ) {
			thisperson.selectName = "Tom Avey"
			thisperson.lname = "Avey"
			thisperson.id = 100
			thisperson.email = loc.i
			thisperson.email2 = loc.i
			thisperson.reviewedAt = "September 1, 2016"
			thisperson.updatedAt = "September 1, 2016"
			thisperson.reviewedBy = loc.i
			arrayAppend(testPeople,thisPerson)
			thisperson = {}
		}
		thisperson.selectName = "Tom Avey"
		thisperson.lname = "Avey"
		thisperson.id = 100
		thisperson.email = "tomavey@fgbc.orgtomavey@comcast.net"
		thisperson.email2 = loc.i
		thisperson.reviewedAt = "September 1, 2016"
		thisperson.updatedAt = "September 1, 2016"
		thisperson.reviewedBy = loc.i
		arrayAppend(testPeople,thisPerson)
		thisperson = {}
		return testPeople
	}
	
	function clearSendHandbooks() {
		cfquery( name="cleared", datasource=application.wheels.dataSourceName, result="whatever" ) {

			writeOutput("UPDATE handbookpeople
				SET sendhandbook = """"
				WHERE id > 0")
		}
		return true
	}

	function $removeInValidEmail(required array handbookReviewArray) {
		var loc = arguments
		loc.newArray = []
		for ( loc.i=1; loc.i<=arraylen(loc.handbookReviewArray); loc.i++ ) {
			if ( isvalid("email",loc.handbookReviewArray[loc.i].email) ) {
				arrayAppend(loc.newArray,loc.handbookReviewArray[loc.i])
			}
		}
		return loc.newarray
	}
	
	function reSort(required numeric orgId) {
		var staff = findAll(where="p_sortorder < #getNonStaffSortOrder()# AND organizationid = #arguments.orgid#", include="Handbookpositions,Handbookstate", cache=false, order="p_sortorder, updatedAt")
		for ( var i=1; i LTE staff.recordCount; i=i+1 ) {
			var row = queryGetRow(staff,i)
			var qry = new Query(
				datasource = getDataSource(),
				sql = "UPDATE handbookpositions
				SET p_sortorder = #i#
				WHERE personid = #row.id#
					AND organizationid = #row.organizationid#" 			
			)
			qry.execute()
		}
		return true
	}
<!------------------------------------>
<!---END OF HANDBOOK REVIEW ACTIONS--->
<!------------------------------------>






<!------------------>
<!---Misc Actions--->
<!------------------>

function swapSortOrder(required numeric thisSortorder, required numeric thisId, required numeric otherSortorder, required numeric otherId, dsn=getDatasource()) {
	cfquery( datasource=arguments.dsn ) { //Note: queryExecute() is the preferred syntax but this syntax is easier to convert generically

		writeOutput("UPDATE handbookpositions
				SET p_sortorder = #arguments.otherSortorder#
				WHERE id = #arguments.thisid#")
	}
	cfquery( datasource=arguments.dsn ) { //Note: queryExecute() is the preferred syntax but this syntax is easier to convert generically

		writeOutput("UPDATE handbookpositions
				SET p_sortorder = #arguments.thisSortorder#
				WHERE id = #arguments.otherid#")
	}
	return true
}

private function $moveSpouseInfoToPerson(query required spouse){
	var loc = arguments
	//Move spouse info into person info
	for ( loc.i=1; loc.i LTE loc.spouse.recordCount; loc.i=loc.i+1 ) {
		querySetCell(loc.spouse,"fullname",loc.spouse['spousefullname'][loc.i],loc.i)
		querySetCell(loc.spouse,"fname",loc.spouse['spouse'][loc.i],loc.i)
		querySetCell(loc.spouse,"birthdayDayNumber",loc.spouse['wifesbirthdayDayNumber'][loc.i],loc.i)
		querySetCell(loc.spouse,"birthdayMonthNumber",loc.spouse['wifesbirthdayMonthNumber'][loc.i],loc.i)
		querySetCell(loc.spouse,"birthdayWeekNumber",loc.spouse['wifesbirthdayWeekNumber'][loc.i],loc.i)
		querySetCell(loc.spouse,"birthdayDayOfYearNumber",loc.spouse['wifesbirthdayDayOfYearNumber'][loc.i],loc.i)
		querySetCell(loc.spouse,"birthdayAsString",loc.spouse['wifesbirthdayAsString'][loc.i],loc.i)
		querySetCell(loc.spouse,"handbookpersonemail",loc.spouse['spouse_email'][loc.i],loc.i)
	}
	return loc.spouse
}

private function $combineSpouseAndPersonAndSort(query required person, query required spouse,orderBy = "birthdayMonthNumber,birthdayDayNumber,fullname") {
	var loc = arguments
	//Union person and spouse queries and the sort them
	cfquery( dbtype="query", name="loc.profiles" ) { //Note: queryExecute() is the preferred syntax but this syntax is easier to convert generically

		writeOutput("SELECT *
		FROM loc.person
		UNION
		SELECT *
		FROM loc.spouse")
	}

	var columnsToDelete = ["spousefullname","spouse","wifesbirthdayDayNumber","wifesbirthdayMonthNumber","wifesbirthdayWeekNumber","wifesbirthdayDayOfYearNumber","wifesbirthdayAsString","spouse_email"]
	arrayEach(columnsToDelete,(col) => queryDeleteColumn(loc.profiles,col))

	cfquery( dbtype="query", name="loc.profiles" ) { //Note: queryExecute() is the preferred syntax but this syntax is easier to convert generically

		writeOutput("SELECT *
		FROM loc.profiles
		ORDER BY #arguments.orderby#")
	}
	return loc.profiles	
	ddd(loc.profiles)
}

private function $getSelectStringForDates(){
	return "(TRIM(CONCAT_WS(' ',fname,lname,suffix))) AS fullname,handbookpeople.fname,handbookpeople.lname,handbookprofiles.email,handbookprofiles.birthdayDayNumber,(week(birthdayasstring)) AS birthdayWeekNumber,handbookprofiles.birthdayMonthNumber,(dayofyear(birthdayasstring)) AS birthdayDayOfYearNumber,handbookprofiles.birthdayAsString,handbookpeople.spouse,handbookprofiles.wifesbirthdayDayNumber,(week(wifesbirthdayasstring)) AS wifesbirthdayWeekNumber,handbookprofiles.wifesbirthdayMonthNumber,(dayofyear(wifesbirthdayasstring)) AS wifesbirthdayDayOfYearNumber,handbookprofiles.wifesbirthdayAsString,handbookpeople.spouse_email,(TRIM(CONCAT_WS(' ',spouse,lname,suffix))) AS spousefullname, personid, handbookpeople.id, handbookpeople.email as handbookpersonemail, handbookpeople.phone as handbookpersonphone, handbookprofiles.anniversaryDayNumber,(week(anniversaryasstring)) AS anniversaryWeekNumber,handbookprofiles.anniversaryMonthNumber,(dayofyear(anniversaryasstring)) AS anniversaryDayOfYearNumber,handbookprofiles.anniversaryAsString"
}

}