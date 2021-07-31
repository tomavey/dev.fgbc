component extends="Controller" output="false" {

	public function config() {
		usesLayout("/conference/adminlayout");
		filters(through="officeOnly", except="showregs,show,badgesAsJson");
		filters(through="setReturn", only="index,show,list,envelopes");
	}
	//  families/index 

	public function index() {
		families = model("Conferencefamily").findAll(where="event = '#getEvent()#'", include="state,person(registration(option))", order="lname,id");
	}
	//  families/show/key 

	public function show() {
		//  Find the record 
		family = model("Conferencefamily").findAll(where="id=#params.key#", include="person,state");
		//  Check if the record exists 
		if ( !family.recordcount ) {
			flashInsert(error="family #params.key# was !found");
			redirectTo(action="index");
		}
		if ( !gotRights("office") ) {
			renderView(layout="/conference/layout2017");
		}
	}

	public function showregs() {
		usesLayout("/layout");
		family = model("Conferencefamily").findAll(where="id=#params.key#", include="person(registration(option)),state");
		/* 
		<cfdump var="#family#"><cfabort>
 */
	}
	//  families/new 

	public function new() {
		family = model("Conferencefamily").new();
		states = model("Handbookstate").findAll();
	}
	//  families/edit/key 

	public function edit() {
		//  Find the record 
		family = model("Conferencefamily").findByKey(key=params.key);
		handbook_states = model("Conferencestate").findAll();
		//  Check if the record exists 
		if ( !IsObject(family) ) {
			flashInsert(error="family #params.key# was !found");
			redirectTo(action="index");
		}
	}
	//  families/create 

	public function create() {
		family = model("Conferencefamily").new(params.family);
		//  Verify that the family creates successfully 
		if ( family.save() ) {
			flashInsert(success="The family was created successfully.");
			returnBack();
			//  Otherwise 
		} else {
			flashInsert(error="There was an error creating the family.");
			renderView(action="new");
		}
	}
	//  families/update 

	public function update() {
		family = model("Conferencefamily").findByKey(params.key);
		//  Verify that the family updates successfully 
		if ( family.update(params.family) ) {
			flashInsert(success="The family was updated successfully.");
			returnBack();
			//  Otherwise 
		} else {
			flashInsert(error="There was an error updating the family.");
			renderView(action="edit");
		}
	}
	//  families/delete/key 

	public function delete() {
		family = model("Conferencefamily").findByKey(params.key);
		Model("Conferenceperson").deletePeopleByFamilyId(params.key);
		//  Verify that the family deletes successfully 
		if ( family.delete() ) {
			flashInsert(success="The family was deleted successfully.");
			redirectTo(action="index");
			//  Otherwise 
		} else {
			flashInsert(error="There was an error deleting the family.");
			redirectTo(action="index");
		}
	}

	public function deleteAll() {
		families = model("Conferencefamily").findAll();
		//  Verify that the family deletes successfully 
		if ( families.delete() ) {
			flashInsert(success="All families were deleted successfully.");
			redirectTo(action="index");
			//  Otherwise 
		} else {
			flashInsert(error="There was an error deleting all families.");
			redirectTo(action="index");
		}
	}

	public function backup() {
		backupresults = Model("family").backup();
	}

	public function badges(maxrows="-1") {
		if ( isDefined("params.maxrows") ) {
			arguments.maxrows = params.maxrows;
		}
		if ( isDefined("params.key") ) {
			datestart = params.key;
		} else if ( isDefined("params.date") ) {
			datestart = params.date;
		} else {
			datestart = createDate(year(now())-1,09,01);
		}
		whereString = "(type = 'Adult' OR type = 'spouse') AND createdat > '#datestart#'";
		if ( isDefined("params.previousyear") ) {
			datestart = createDate(year(now())-2,10,01);
			dateend = createDate(year(now())-1,08,01);
			whereString = "(type = 'Adult' OR type = 'spouse') AND createdat > '#datestart#' AND createdAt < '#dateend#'";
		}
		selectString = "";
		if ( isDefined("params.json") ) {
			selectString = "id,fullname,fname,lname,fullnamelastfirst";
		}
		badges = model("Conferenceperson").findall(select=selectString, where=whereString, include="family", order="lname,fname", maxrows='#arguments.maxrows#');
		count = QueryAddColumn(badges,"registered");

		queryEach(badges,function(badge){
			if ( isRegistered(id) ) { badge.registered = 1 }
		})

		// <cfoutput query="badges">
		// 	<cfif isregistered(id)>
		// 		<cfset querySetCell(badges,"registered",1, currentRow)>
		// 	</cfif>
		// </cfoutput>

		cfquery( dbtype="query" ) { //Note: queryExecute() is the preferred syntax but this syntax is easier to convert generically
			writeOutput("SELECT *
			FROM badges
			WHERE registered = 1");
		}
		//  <cfdump var='#badges#'><cfabort> 
		if ( isdefined("params.download") ) {
			renderView(layout="/conference/layoutdownload");
		}
		if ( isdefined("params.json") ) {
			badges = getDistinctColumnValuesFromQuery(badges, 'fullnamelastfirst');
			data=queryToJson(badges);
			renderJson();
		}
		if ( isDefined("params.print") ) {
			renderView(template="badgesPrint", layout="/layout_naked");
		}
		if ( isDefined("params.asJson") ) {
			renderView(layout="/layout_json_simple", hideDebugInformation=true);
		}
	}

	public function badgesAsJson() {
		dateStart = createDate(year(now())-1,09,01);
		whereString = "(type = 'Adult' OR type = 'spouse') AND createdat > '#datestart#'";
		selectString = "id,fullname,fname,lname,fullnamelastfirst";
		badges = model("Conferenceperson").findall(select=selectString, where=whereString, include="family", order="lname,fname");
		badges = getDistinctColumnValuesFromQuery(badges, 'fullnamelastfirst');
		data=queryToJson(badges);
		renderJson();
	}

	public function badgesJson() {
		renderView(layout="/layout_json_simple", hideDebugInformation=true);
	}

	function thisPersonsMealTicketsAsJson() {
		var tickets = thisPersonsMealTickets(params.personid, params.familyid, params.type)
		tickets = ticketsToPipeList(tickets)
		tickets = "[{" & tickets & "}]"
		data = serializeJSON(tickets)
		renderJson()
	}

	public function testIsRegistered() {
		check = isRegistered(params.key);
		writeDump( var=check );
		abort;
	}

	public function isRegistered(required numeric personid) {
		var loc = structNew();
		loc.return = false;
		loc.reg = model("Conferenceregistration").findOne(where="equip_peopleid=#arguments.personid#");
		if ( isObject(loc.reg) ) {
			loc.return=true;
			return loc.return;
		}
		try {
			loc.familyid = model("Conferenceperson").findOne(where="id=#arguments.personid#", include="family").equip_familiesid;
		} catch (any cfcatch) {
			return false;
		}
		loc.spouse = model("Conferenceperson").findOne(where="equip_familiesid=#loc.familyid#", include="family");
		if ( isObject(loc.spouse) ) {
			loc.reg = model("Conferenceregistration").findOne(where="equip_peopleid=#loc.spouse.id#", include="invoice");
			if ( isObject(loc.reg) ) {
				loc.return = true;
			}
		}
		return loc.return;
	}

	public function testIsRegistered(personid="#params.key#") {
		test = isRegistered(arguments.personid);
		writeDump( var=test );
		abort;
	}

	public function envelopes(page="0", maxrows="-1") {
		if ( isDefined("params.page") ) {
			arguments.page = params.page;
		}
		if ( isDefined("params.maxrows") ) {
			arguments.maxrows = params.maxrows;
		}
		if ( !isDefined("params.date") ) {
			params.date = "#year(now())-1#/08/01";
		}
		whereString = "createdat > '#params.date#'";
		if ( isDefined("params.familyid") ) {
			whereString = whereString & " AND id=#params.familyid#";
		}
		if ( isDefined("params.alpha") ) {
			whereString = whereString & " AND alpha='#params.alpha#'";
		}
		envelopes = model("Conferencefamily").findAll(where=whereString, order="lname", maxrows='#arguments.maxrows#');
		options = model("Conferenceoption").findAll(where="event='#getEvent()#'", order="name");
		listcounts = QuotedValueList("options.name");
		listcounts = replace(listcounts,"'","","all");
		//  <cfdump var="#envelopes#"><cfabort> 
		if ( isdefined("params.download") ) {
			renderView(layout="/conference/layoutdownload");
		}
	}

	public function showThisEnvelope(required struct info, string previousinvoice) {
		var loc=structNew();
		loc = arguments;
		loc.showThisEnvelope = true;
		if ( loc.info.name == "NA" && loc.info.invoice == loc.previousinvoice ) {
			loc.showThisEnvelope = false;
		}
		if ( !len(loc.info.items) ) {
			loc.showThisEnvelope = false;
		}
		return loc.showThisEnvelope;
	}

	private function thisPersonEnvelopeInfo (type, personId, familyid) {
		if (type is 'adult') {
			try {
				var whereString = "equip_peopleid = #personId#"
				regs = model("Conferenceregistration").findAll(where=whereString)
			} catch (any e) {
				regs = "something went wrong"
				// writeOutput("something has gone wrong! ")
				// writeDump(whereString);abort;
			}
			return regs
		}
	}
	// This method is used by the envelope view to gather information that should be on the registration envelope

	public function thisFamilyEnvelopeInfo(required familyid, optionid="0", optionType="") {
		var EnvelopeInfo = structnew();
		var familyRegInfo = structnew();
		var him = structnew();
		var her = structnew();
		EnvelopeInfo.items = "";
		EnvelopeInfo.invoice = "";
		EnvelopeInfo.status = "";
		itemOrder="FIELD(type, 'Meal', 'Other', 'Workshop', 'Registration'), sortorder";
		consolidateLinkString = '/index.cfm/?controller=conference.registrations&action=consolidateregs&';
		him = Model("Conferenceperson").findAll(where="Equip_familiesid = #arguments.familyid# AND type='adult'", include="family");
		her = Model("Conferenceperson").findAll(where="equip_familiesid=#arguments.familyid# AND type='Spouse'", include="family");
		if ( him.recordcount && her.recordcount ) {
			EnvelopeInfo.name = him.fname & " & " & her.fname;
			if ( isDefined("params.showFnameId") ) {
				EnvelopeInfo.name = "<a href='#consolidateLinkString#temppersonid=#him.id#&lname=#lname#' target='_blank'>&##8225;</a> " & EnvelopeInfo.name;
			}
			wherestring = "event='#getEvent()#' AND (equip_peopleid = #him.id# OR equip_peopleid = #her.id#)";
		} else if ( him.recordcount ) {
			EnvelopeInfo.name = him.fname;
			if ( isDefined("params.showFnameId") ) {
				EnvelopeInfo.name = "<a href='#consolidateLinkString#temppersonid=#him.id#&lname=#lname#' target='_blank'>&##8225;</a> " & EnvelopeInfo.name;
			}
			wherestring = "event='#getEvent()#' AND equip_peopleid = #him.id#";
		} else if ( her.recordcount ) {
			EnvelopeInfo.name = her.fname;
			if ( isDefined("params.showFnameId") ) {
				EnvelopeInfo.name = "<a href='#consolidateLinkString#temppersonid=#him.id#&lname=#lname#' target='_blank'>&##8225;</a> " & EnvelopeInfo.name;
			}
			wherestring = "event='#getEvent()#' AND equip_peopleid = #her.id#";
		} else {
			EnvelopeInfo.name = "NA";
		}
		if ( isDefined("params.option") ) {
			wherestring = whereString & " AND name = '#params.option#'";
		}
		if ( !isDefined("params.showall") ) {
			whereString = whereString & " AND quantity <> 0";
		}

		if (optionType IS "mealsOnly") {
						whereString = whereString & " AND type = 'Meal'"
					}
		familyRegInfo = Model("Conferenceregistration").findAll(where=wherestring, include="option,invoice", order=itemOrder);
		try {
			envelopeInfo.status = paystatus(familyRegInfo.ccstatus);
		} catch (any cfcatch) {
		}
		try {
			envelopeInfo.invoice = familyRegInfo.ccorderid;
		} catch (any cfcatch) {
		}
		try {

			queryEach(familyRegInfo, function(EnvelopeInfo){
				EnvelopeInfo.items = EnvelopeInfo.items & "; " & quantity & name
			})

			/* toScript ERROR: Unimplemented cfloop condition:  query="familyRegInfo" 

						<cfloop query="familyRegInfo">
						<cfset EnvelopeInfo.items = EnvelopeInfo.items & "; " & quantity & name>
				</cfloop>

			*/

		} catch (any cfcatch) {
		}
		EnvelopeInfo.items = replace(EnvelopeInfo.items,"; ","","one");
		return EnvelopeInfo;
	}

	public function TestThisFamilyEnvelopeInfo() {
		test1 = thisFamilyEnvelopeInfo(2432);
		test2 = thisFamilyEnvelopeInfo(2945);
		writeDump( var=test1 );
		writeDump( var=test2 );
		abort;
	}

	function thisPersonsMealTickets(personid, familyid, type) {
		var EnvelopeInfo = thisFamilyEnvelopeInfo(familyid,0,"mealsOnly").items
		EnvelopeInfo = listToArray(EnvelopeInfo,";")
		var tickets = ""
		var item = ""
		if (type IS "spouse") {
			tickets = ""
			for ( item IN EnvelopeInfo ) {
				if (val(item) EQ 2) {
					tickets = tickets & ";" & item 
				}
			}
		} else {
			tickets = ""
			for ( item IN EnvelopeInfo ) {
				if (val(item)) {
					tickets = tickets & ";" & item
				}
		}
	}
		return tickets
	}

	function testthisPersonsMealTickets(){
		writeDump(thisPersonsMealTickets(6260,3869,"Spouse"));abort;
	}

  function testSeparateCountFromTicket() {
		var ticket = "3DinnerInspTueSingle"
		var text = separateCountFromTicket(ticket)
		writeDump(ticket);
		writeDump(text);
		write
    abort;
  }

}
