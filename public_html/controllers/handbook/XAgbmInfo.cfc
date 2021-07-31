component extends="Controller" output="false"{

	function config() {
		usesLayout(template="/handbook/layout_agbm");
		filters(through="getCurrentMembershipYear");
		filters(through="gotAgbmRights", except="rss,publiclist,json,list,pastorsnotagbm");
		filters(through="setreturn", only="list,show,handbookMembershipReport")
	}



<!-------------->
<!----FILTERS--->
<!-------------->

function getCurrentMembershipYear() {
	if ( isDefined ("params.year") ) {
		currentmembershipyear = params.year;
	} else {
		currentmembershipyear = model("Handbookagbminfo").currentMembershipYear(params);
	}
}

function testGetCurrentMembershipYear() {
	params.agbmDeadlineDate = "06-02-2021"
	params.today = "07-06-2020"
	params.testing = true
	var temp = model("Handbookagbminfo").currentMembershipYear(params);
	ddd(temp);
}



<!----------------->	
<!-----CRUD-------->	
<!----------------->	

	<!--- -handbookagbminfos/list --->
	function list() {
		orderString = "lname,fname,p_sortorder";
		showAge=false;
		if ( isDefined("params.byage") ) {
			orderString = "birthdayyear #params.byage#,lname,fname";
			showAge = true;
		}
		districts=model("Handbookdistrict").findAll(where="district NOT IN ('Empty','National Ministry','Cooperating Ministry')");
		if ( isDefined("params.search") ) {
			people = model("Handbookagbminfo").findAllMembers(search=params.search,currentMembershipYear=currentmembershipyear);
		} else if ( isDefined("params.type") && params.type == "members" && isDefined("params.alpha") && len(params.alpha) ) {
			people = model("Handbookagbminfo").findAllMembers(alpha=params.alpha,currentMembershipYear=currentmembershipyear,orderby=orderstring);
		} else if ( isDefined("params.type") && params.type == "members" && isDefined("params.district") && len(params.district) ) {
			people = model("Handbookagbminfo").findAllMembers(district=params.district,currentMembershipYear=currentmembershipyear);
		} else if ( isDefined("params.type") && params.type == "members" ) {
			people = model("Handbookagbminfo").findAllMembers(currentMembershipYear=currentmembershipyear);
		} else if ( isDefined("params.type") && params.type == "lifeTimeMembers" ) {
			people = model("Handbookagbminfo").findAllMembers(currentMembershipYear=currentmembershipyear,lifeTimeMembers=true);
		} else if ( isDefined("params.type") && (params.type == "mailinglist" || params.type == "mail") ) {
			people = model("Handbookagbminfo").findAllMailingList(currentMembershipYear=currentmembershipyear);
		} else {
			people = model("Handbookagbminfo").findAllMembers(currentMembershipYear=currentmembershipyear,orderby=orderstring);
		}
	
		if ( isDefined("params.countMin") ) {
				people = people.filter( 
					function (el) {
					return countOfMembershipYearsPaid(personid = el.personid) >= params.countMin;
					} 
				)
			}
		if ( !gotRights("agbm,superadmin,agbmadmin") ) {
			people = model("Handbookagbminfo").findAllMembers(currentMembershipYear=currentmembershipyear, orderby="district", publicOnly=true);
			renderView(template="publicList");
		}
		// Set the layout for normal, download view, or download excel
		if ( isdefined("params.download") ) {
			renderView(template="download", layout="/layout_naked");
		} else if ( isDefined("params.excel") ) {
			renderView(template="download", layout="/layout_download");
		}
	}
	

// handbookagbminfos/show/key 

	function show() {
		payments = model("Handbookagbminfo").findAll(where="personid = #params.key#", include="Handbookperson(Handbookstate)", order="membershipfeeyear DESC");
	}

<!--- -handbookagbminfos/add --->

	function add() {
		handbookagbminfo = model("Handbookagbminfo").new();
		handbookagbminfo.membershipfeeyear = year(now());
		handbookagbminfo.membershipfee = getSetting("agbmMembershipfee");
		try {
			handbookagbminfo.agbmlifememberAt = model("Handbookprofile").findOne(where="personid = #params.key#").agbmlifememberAt;
		} catch (any cfcatch) {
			handbookagbminfo.agbmlifememberAt = "";
		}
		if ( month(now()) == 6 ) {
			defaultdate = "#year(now())#"&"-05-31";
			handbookagbminfo.paidAt = defaultdate;
		}
		people = model("Handbookperson").findAll(order="lname,fname", include="Handbookstate");
		organizations = model("Handbookorganization").findAll(include="Handbookstate", order="org_city,state_mail_abbrev,name");
		thisperson = model("Handbookperson").findOne(where="id=#params.key#", order="lname,fname", include="Handbookstate");
		thisPersonsLastPayment = model("Handbookagbminfo").findAll(where="personid=#params.key#", order="membershipfeeyear DESC");
		handbookagbminfo.category = thisPersonsLastPayment.category;
		handbookagbminfo.ordained = thisPersonsLastPayment.ordained;
		handbookagbminfo.licensed = thisPersonsLastPayment.licensed;
		handbookagbminfo.commissioned = thisPersonsLastPayment.commissioned;
		handbookagbminfo.commission = thisPersonsLastPayment.commission;
		formAction = "create"
		renderView(action="new");
	}

<!--- -handbookagbminfos/edit/key --->
	function edit() {
		//  Find the record 
		handbookagbminfo = model("Handbookagbminfo").findByKey(params.key);
		handbookagbminfo.agbmlifememberAt = model("Handbookprofile").findOne(where="personid = #handbookagbminfo.personid#").agbmlifememberAt;
		//  Check if the record exists 
		if ( !IsObject(handbookagbminfo) ) {
			flashInsert(error="Handbookagbminfo #params.key# was !found");
			redirectTo(action="index");
		}
		organizations = model("Handbookorganization").findAll(include="Handbookstate", order="org_city,state_mail_abbrev,name");
		formAction = "update"
	}

	<!--- -handbookagbminfos/create --->
	function create() {
		/*  <cfscript>
				throw(message=serialize(params.handbookagbminfo))
			</cfscript> */
		handbookagbminfo = model("Handbookagbminfo").new(params.handbookagbminfo);
		if ( len(handbookagbminfo.agbmlifememberat) ) {
			makeAgbmLifeMember(handbookAgbmInfo.personId,handbookagbminfo.agbmlifememberat);
			returnBack();
		}
		//  Verify that the handbookagbminfo creates successfully 
		if ( handbookagbminfo.save() ) {
			flashInsert(success="The handbookagbminfo was created successfully.");
			returnBack();
			//  Otherwise 
		} else {
			flashInsert(error="There was an error creating the handbookagbminfo.");
			renderView(action="new");
		}
	}

	
//  -handbookagbminfos/update 

function update() {
	handbookagbminfo = model("Handbookagbminfo").findByKey(params.key);
	handbookagbminfo.agbmlifememberAt = model("Handbookprofile").findOne(where="personid = #handbookagbminfo.personid#").agbmlifememberAt;
	if ( len(handbookagbminfo.agbmlifememberat) ) {
		makeAgbmLifeMember(handbookAgbmInfo.personId,handbookagbminfo.agbmlifememberat);
		returnBack();
	}
	/*  <cfscript>
			throw(message=serialize(handbookagbminfo.properties()))
		</cfscript> */
	//  Verify that the handbookagbminfo updates successfully 
	if ( handbookagbminfo.update(params.handbookagbminfo) ) {
		if ( len(handbookagbminfo.agbmlifememberat) ) {
			makeAgbmLifeMember(handbookAgbmInfo.personId,handbookagbminfo.agbmlifememberat);
		}
		flashInsert(success="The handbookagbminfo was updated successfully.");
		returnBack();
		//  Otherwise 
	} else {
		flashInsert(error="There was an error updating the handbookagbminfo.");
		renderView(action="edit");
	}
}
//  -handbookagbminfos/delete/key 

function delete() {
	handbookagbminfo = model("Handbookagbminfo").findByKey(params.key);
	//  Verify that the handbookagbminfo deletes successfully 
	if ( handbookagbminfo.delete() ) {
		flashInsert(success="The handbookagbminfo was deleted successfully.");
		returnBack();
		//  Otherwise 
	} else {
		flashInsert(error="There was an error deleting the handbookagbminfo.");
		redirectTo(action="index");
	}
}
<!------------------------>	
<!-----END OF CRUD-------->	
<!------------------------>	






<!------------------------>
<!-----SPECIAL REPORTS---->
<!------------------------>

	// For public lists - just name and location - no links
	function publicList() {
		ministerium = getAgbmMembers(currentMembershipYear=currentmembershipyear, orderby="district, lname");
	}

	// Use on home page for a simple list of everyone in the handbook with links
	function handbook() {
		params.all = true;
		handbookPeople = model("Handbookperson").findHandbookPeople(params);
	}

	//Report of members who have not paid yet
	function delinquent() {
		if ( isDefined("params.year") && val(params.year) ) {
			currentmembershipyear = params.year;
		}
		people = model("Handbookperson").findAll(order="lname, fname", include="Handbookstate,Handbookprofile");
		people = queryFilter(people, (el) => paidLastYearNotThisYear(el.id,currentmembershipyear) && !len(el.agbmlifememberAt));
		if ( isDefined("params.download") ) {
			renderView(layout="/layout_download");
		}
	}

	//Report of members paid countMin 0f 10 years
	function agbm10YearMembers(){
		var countMin = 9
		if ( isDefined("params.countMin") ) {
			countMin = params.countMin
		}
		showAge=false
		people = model("Handbookagbminfo").getAgbm10YearMembers(countmin)
		if ( isdefined("params.download") ) {
			renderView(template="download", layout="/layout_naked")
		}
		if ( isDefined("params.excel") ) {
			renderView(template="download", layout="/layout_download")
		}
		pageTitle= "Men who have been paid up members for 9 of the past 10 years:"
		showAlphaMenu = false
		showAgeButton = false
		showDownloadButton = false
		renderView(template="list")
	}

	//A report of pastors in the handbook who are not members of Inspire
	function pastorsNotAgbm() {
		if ( isDefined("params.type") && params.type == "seniorpastors" ) {
			wherestring = "p_sortorder = 1 AND position LIKE '%pastor%' AND ";
			headerHtml = '
			<h3>Seniors Pastors that are not members of the Inspire</h3>
			<p class="well">
				These are Senior pastors (listed first in the handbook under the church listing) that are not current members of the Inspire. If they have been members in the past, their past payment information is shown under their name. Click the name for the handbook listing or the payment info for a payment history.
			</p>
			'
		} else if ( isDefined("params.type") && params.type == "staffpastors" ) {
			wherestring = "p_sortorder > 1 AND position LIKE '%pastor%' AND ";
			headerHtml = '<h3>Staff Pastors that are not members of the Inspire</h3>
			<p class="well">
				These are Staff pastors (have the word "Pastor" in their title and are not senior pastors) that are not current members of the Inspire. If they have been members in the past, their past payment information is shown under their name. Click the name for the handbook listing or the payment info for a payment history.
			</p>'
		} else if ( isDefined("params.type") && params.type == "allpastors" ) {
			wherestring = "position LIKE '%pastor%' AND ";
			headerHtml = '<h3>All Pastors that are not members of the Inspire</h3>
			<p class="well">
				These are Staff and Senior pastors (have the word "Pastor" in their title and are not senior pastors) that are not current members of the Inspire. If they have been members in the past, their past payment information is shown under their name. Click the name for the handbook listing or the payment info for a payment history.
			</p>'
		} else {
			wherestring = "p_sortorder < 500 AND ";
			headerHtml = '<h3>Charis Fellowship Church Staff that are not members of the Inspire</h3>
			<p class="well">
				These are church staff that are not current members of the Inspire. If they have been members in the past, their past payment information is shown under their name. Click the name for the handbook listing or the payment info for a payment history.
			</p>'
		}
		wherestring = wherestring & "statusid in (1,8,3,4,2,9) AND fnamegender = 'M' AND id <> 1";
		pastors = model("Handbookperson").findAll(
				where=wherestring,
				include="Handbookstate,Handbookpositions(Handbookorganization)", order="lname,fname");
		pastors = pastors.filter( (el) => !isAgbmMember(el.id, params) )
		if ( isDefined("params.download") ) {
			renderView(layout="/layout_download");
		}
	}

	//Report of various metrics
	function dashboard() {
		var loc=structNew();
		loc.currentMembershipYear = model("Handbookperson").currentMembershipYear(params);
		params.currentmembershipyear = loc.currentMembershipYear;
		dataThisYear = model("Handbookperson").getAGBMDashboardInfo(params);
		dataThisYear.Year = params.currentMembershipYear;
		params.currentmembershipyear = loc.currentMembershipYear - 1;
		dataPreviousYear = model("Handbookperson").getAGBMDashboardInfo(params);
		dataPreviousYear.Year = params.currentMembershipYear;
		params.currentmembershipyear = loc.currentMembershipYear - 2;
		dataPreviousPreviousYear = model("Handbookperson").getAGBMDashboardInfo(params);
		dataPreviousPreviousYear.Year = params.currentMembershipYear;
	}

	function rss() {
		if ( application.wheels.environment != "production" ) {
			set(environment="production");
		}
		ministerium = model("Handbookagbminfo").findAllMembers(currentMembershipYear=currentmembershipyear, orderby="district,lname,fname");
		renderView(layout="rsslayout");
	}

	function json() {
		data = queryToJson(getPublicOnlyAgbmMembersWithAlias())
		renderView(layout="/layout_json", template="json", hideDebugInformation=true);
	}

	function handbookMembershipReport() {
		currentMembershipYear = model("Handbookperson").currentMembershipYear(params);
		ordained = getAgbmOrdained();
		commissioned = getAgbmCommissioned();
		if ( isDefined("params.plain") ) {
			renderView(layout="/layout_naked");
		}
	}

	private function paidLastYearNotThisYear(required numeric personid, required string currentMembershipyear) {
		var loc=structNew();
		loc.currentmembershipyear = arguments.currentMembershipyear;
		loc.return = false;
		loc.lastyear = loc.currentmembershipyear-1;
		loc.thisyear = loc.currentmembershipyear;
		loc.lastYearsPayment = model("Handbookagbminfo").findOne(where="personid = #arguments.personid# AND membershipfeeyear = '#loc.lastyear#'");
		if ( isObject(loc.lastYearsPayment) ) {
			loc.thisYearsPayment = model("Handbookagbminfo").findOne(where="personid = #arguments.personid# AND membershipfeeyear = '#loc.thisyear#'");
			if ( !isObject(loc.thisYearsPayment) ) {
				loc.return = true;
			}
		}
		return loc.return;
	}
<!---------------------------->
<!---END OF SPECIAL REPORTS--->
<!---------------------------->






<!------------->
<!---Getters--->	
<!------------->

	function countOfMembershipYearsPaid(required number personid) {
		return model("Handbookagbminfo").countOfMembershipYearsPaid(personid)
	}

	function countOfMembershipYearsPaid(personId){
		return countOfMembershipYearsPaid(personId)
	}

	function getStatus(ordained,commissioned,licensed){
		if ( ordained ) { return "Ordained" }
		if ( commissioned ) { return "Commissioned" }
		if ( licensed ) { return "Licensed" }
	}

	function getLastPayment(required numeric personid, formatted="true") {
		var loc=structNew();
		loc.currentMembershipYear = model("Handbookperson").currentMembershipYear(params);
		loc.fontcolor = "black";
		loc.lastPayment = model("Handbookagbminfo").findAll(where="personid = #arguments.personid#", order="membershipfeeyear DESC");
		if ( loc.lastPayment.recordcount ) {
			if ( loc.lastPayment.membershipfeeyear != loc.currentMembershipYear ) {
				loc.fontcolor = "red";
			}
			if ( loc.lastPayment.category == 1 ) {
				loc.check = loc.lastpayment.licensed + loc.lastpayment.ordained + loc.lastpayment.commissioned;
				if ( !loc.check ) {
					loc.fontcolor = "red";
				}
		};

		savecontent variable="loc.return" {
				if ( arguments.formatted ) {
					if ( len(agbmlifememberAt) ) {
						if ( loc.lastPayment.ordained ) {

							writeOutput("Lifetime ordained member since #agbmlifememberAt#");
						}
						if ( loc.lastPayment.licensed ) {

							writeOutput("Lifetime licensed member since #agbmlifememberAt#");
						}
						if ( loc.lastPayment.commissioned ) {

							writeOutput("Lifetime commissioned member since #agbmlifememberAt#");
						}
					} else {

						writeOutput("<p style=""color:#loc.fontcolor#"">
									#dollarFormat(loc.lastPayment.membershipfee)# for #loc.lastPayment.membershipfeeyear#<br/>");
						if ( loc.lastPayment.commissioned ) {

							writeOutput("Commissioned #loc.lastpayment.commission#");
						} else {
							if ( loc.lastPayment.category ) {

								writeOutput("Cat. #loc.lastPayment.category#;");
							}
							if ( loc.lastPayment.ordained ) {

								writeOutput("Ordained");
							} else if ( loc.lastpayment.licensed ) {

								writeOutput("; Licensed");
							}
						}

						writeOutput("</p>");
					}
				} else {

					writeOutput("#dollarFormat(loc.lastPayment.membershipfee)# for #loc.lastPayment.membershipfeeyear#");
					if ( loc.lastPayment.commissioned ) {

						writeOutput("Commissioned #loc.lastpayment.commission#");
					} else {

						writeOutput("Cat. #loc.lastPayment.category#");
						if ( loc.lastPayment.ordained ) {

							writeOutput("; Ordained");
						} else if ( loc.lastpayment.licensed ) {

							writeOutput("; Licensed");
						}
					}
				}
			
		};
		} else {
			loc.return = "na";
		}
		return loc.return;
	}


	function getPayments(required numeric personid, required string agbmlifememberAt) {
		var loc=structNew();
		var payments = model("Handbookagbminfo").findAll(where="personid = #arguments.personid#", order="membershipfeeyear DESC");
		if ( payments.recordcount ) {
			savecontent variable="loc.return" {
				for (payment in payments) {
					if ( len(agbmlifememberAt) ) {

						writeOutput("<p>Lifetime member since #agbmlifememberAt#</p>");
					}

					writeOutput("<p>#dollarFormat(payment.membershipfee)# for #payment.membershipfeeyear#<br/>
							Cat. #payment.category#");
					if ( payment.ordained ) {

						writeOutput("; Ordained");
					} else if ( payment.licensed ) {

						writeOutput("; Licensed");
					}

					writeOutput("</p>");
				}
			}
		} else {
			loc.return = "na";
		}
		return loc.return;
	}

	public function isAgbmLifeMember(personid) {
		return model("Handbookagbminfo").isAgbmLifeMember(personid)
	}

	private function countOfMembershipYearsPaidSince(){
		if ( !isDefined('params.year') ) { params.year = year(now()) }
		if ( !isDefined('params.span') ) { params.span = 10 }
		if ( !isDefined('params.personid') ) { throw(message="personid is required") }
		var args = {
			asOfMembershipFeeYear: params.year, 
			personid: params.personid, 
			yearSpan: params.span
		}
		var test = model("Handbookagbminfo").CountOfMembershipYearsPaid(argumentCollection = args)
		return test
		throw(message=test)
	}

	public function getDistrictName(id){
		var district = model("Handbookdistrict").findOne(where="districtid=#id#");
		if (isObject(district)) { 
			return district.district;
		}
		return "NA";
	}

	public function getAgbmMembers(){
		var people = model("Handbookagbminfo").getAgbm(orderby="lname, fname, i.createdAt DESC")
		var allMembers = people.filter( (el) => el.lastpayment == CurrentMembershipYear || len(el.agbmlifememberat) )
		return allMembers
		ddd(allMembers)
	}

	public function getPublicOnlyAgbmMembersWithAlias(){
		var allMembers = getAgbmMembers()
		var allPublic = allMembers.filter( (el) => el.private != "Yes" )
		var allPublicWithAlias = queryMap(allPublic, function(el) {
			el.fname = alias('fname', el.fname, el.personid)
			el.lname = alias('lname', el.lname, el.personid)
			return el
		})
		return allPublicWithAlias
		ddd(allPublicWithAlias)
	}

	public function getAgbmOrdained(){
		var allMembers = getAgbmMembers()
		var allOrdained = allMembers.filter( (el) => el.ordained )
		return allOrdained
		ddd(allOrdained)
	}

	public function getAgbmCommissioned(){
		var allMembers = getAgbmMembers()
		var allCommissioned = allMembers.filter( (el) => el.commissioned )
		return allCommissioned
		ddd(allCommissioned)
	}

	public function getAgbmNot(){
		var allMembers = getAgbmMembers()
		var allCommissioned = allMembers.filter( (el) => !el.commissioned && !el.ordained )
		return allCommissioned
		ddd(allCommissioned)
	}

	public function XlistNew(orderby="district"){
		var loc = arguments;
		if (isDefined("params.orderby")){loc.orderby = params.orderby};
		if (isDefined("params.refresh")){loc.refresh = params.refresh};
		agbmMembers = model("Handbookagbminfo").getAgbmMembers(argumentcollection=loc);
		districts=model("Handbookdistrict").findAll(where="district NOT IN ('Empty','National Ministry','Cooperating Ministry')");
	}

	function getAGBMMailList(orderby="lname,fname") {
		var loc=structNew();
		mailListAgbmPeople = model("Handbookperson").findAll(where="grouptypeid = 16", include="Handbookgroup,Handbookstate", order=arguments.orderby, maxrows="5");
		writeDump( var=mailListAgbmPeople );
		abort;
	}

	//Used by the handbook report view
	function getPositionForHandbookReport(required numeric personid) {
		var loc = arguments;
		loc.whereString = "id=#loc.personid#";
		loc.includeString = "Handbookpositions(Handbookpositiontype,Handbookorganization(State,Handbookstatus))";
		loc.selectString = "name,statusid,status,handbookpositions.position as position,org_city,handbookstates.state_abbrev as state";
		loc.whereString1 = loc.whereString & " AND status = 'AGBM Only'";
		loc.positions1 = model("Handbookperson").findAll(select=loc.selectString, where=loc.whereString1, include=loc.includeString);
		if ( loc.positions1.recordcount ) {
			loc.return = gbcit(trim(loc.positions1.name)) & "; " & unrepeatcity(loc.positions1.org_city,loc.positions1.name) & " " & loc.positions1.state;
			return loc.return;
		}
		loc.whereString2 = loc.whereString & " AND status = 'Member'";
		loc.positions2 = model("Handbookperson").findAll(select=loc.selectString, where=loc.whereString2, include=loc.includeString);
		if ( loc.positions2.recordcount ) {
			loc.return = gbcit(loc.positions2.name) & "; " & unrepeatcity(loc.positions2.org_city,loc.positions2.name) & " " & loc.positions2.state;
			return loc.return;
		}
		loc.whereString3 = loc.whereString & " AND status = 'Member (co-member)'";
		loc.positions3 = model("Handbookperson").findAll(select=loc.selectString, where=loc.whereString3, include=loc.includeString);
		if ( loc.positions3.recordcount ) {
			loc.return = gbcit(trim(loc.positions3.name)) & "; " & unrepeatcity(loc.positions3.org_city,loc.positions3.name) & " " & loc.positions3.state;
			return loc.return;
		}
		return "Inspire Member";
	}

	<!-------------------------->
<!---------END OF GETTERS--->
<!-------------------------->







<!-------------------------->
<!----SETTERS--------------->
<!-------------------------->

	function setyear() {
		session.agbm.currentmembershipyear = params.key;
		returnBack();
	}

	function gbcIt(required string churchname) {
		var loc=structNew();
		loc.return = replace(arguments.churchname,"Grace Brethren Church","GBC","all");
		return trim(loc.return);
	}

	function unRepeatCity(required string city, required string name) {
		var loc=structNew();
		loc.return = arguments.city & ",";
		if ( find(city,name) ) {
			loc.return = "";
		}
		return trim(loc.return);
	}


	public function makeAgbmLifeMember(personid, year) {
		var personProfile = model("Handbookprofiles").findOne(where="personid=#personid#")
		if ( isObject(personProfile) ) {
			personProfile.agbmlifememberAt = "#year#"
			personProfile.update()
		} else {
			personProfile = model("Handbookprofiles").new()
			personProfile.personid = personid
			personProfile.agbmlifememberAt = year
			personProfile.save()
			// throw(message = serialize(personProfile.properties()))
		}
	}

	private function $movePaymentsToNewMember ( required numeric oldPersonId, required numeric newPersonid ) {
		var personsIdString = ""
		var payments = model("Handbookagbminfo").findAll(where="personid = #arguments.oldPersonId#", order="membershipfeeyear DESC")
		for ( payment in payments ) {
			var newPayment = model("Handbookagbminfo").new(payment)
			newPayment.id = ""
			newPayment.personid = arguments.newPersonid
			newPayment.save()
			personsIdString = personsIdString & "; " & payment.personid
			model("Handbookagbminfo").deleteAll(where="id=#payment.id#")
		}	
		return newPersonid
	}

	function movePaymentsToNewMember(){
		//move payments from the oldPersonid to the newPersonId - enter numbers manually or in the url
		oldPersonId = ""
		newPersonId = ""
		if ( isDefined("params.oldPersonId") ) { oldPersonId = params.oldPersonId }
		if ( isDefined("params.newPersonid") ) { newPersonid = params.newPersonid }
		if ( !len(oldPersonID) || !len(newPersonId) ) { writeOutPut("Need OldPersonId and NewPersonid as URL params"); abort; }
		newPersonid = $movePaymentsToNewMember(oldPersonId, newPersonid)
		writeOutPut("payments for #oldPersonId# have been transfered to #newPersonid#"); abort;
	}


	
	<!--- I don't think index is being used - "list" is--->
	function index(){
		payments = model("Handbookagbminfo").findAll(include="Handbookperson(Handbookstate)")
	}


<!---------TRASH-------->
public function XgetBestPersonPositionAsStruct(orderby = "lname, fname, i.createdAt DESC"){
	var people = model("Handbookagbminfo").getAgbm(orderby=arguments.orderby)
	var allMembers = people.filter( (el) => el.lastpayment == CurrentMembershipYear || len(el.agbmlifememberat) )
	return allMembers
	ddd(allMembers)
}



}