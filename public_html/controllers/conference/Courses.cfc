component extends="Controller" output="false" {

	public function init() {
		usesLayout(template="/conference/layout2018/");
		filters(through="getevents", only="edit,new,copy");
		filters(through="setreturn", only="index,show,showallselectedworkshops,showallselectedcohorts,list");
		filters(through="openWorkshops");
		filters(through="getCourses", only="list,listCohorts");
		filters(through="getSubtypes", only="list,listCohorts,selectcohorts,showSelectedWorkshops,sendSelectedWorkshops");
		// filters(through="setPublicLayout");
		filters(through="isAuthorized", only="copy,create,update,copyAllToCurrentEvent");
		//  <cfset filters(through="setKeyFromKeyy")> 
	}

// -------
// Filters
// -------

	// public function setPublicLayout() {
	// 	publicLayout = "/conference/layout2018";
	// }

	public function isAuthorized() {
		if ( !gotRights('office') ) {
			renderText("You do !have permission to view this page");
		}
	}

	public function getEvents() {
		var inCategory = "";
		var i = 0;
		var whereString = "";
		for ( i in typesOfCoursesForDropdown() ) {
			inCategory = "#inCategory# OR category = '#i#'";
		}
		inCategory = replace(inCategory,"OR","");
		whereString = "event='#getEvent()#' AND category IN (#inCategory#)";
		events = model("Conferenceevent").findAll(where=whereString, include="Location", order="selectName");
	}

	public function openWorkshops() {
		if ( isDefined("params.opeworkshops") || isDefined("params.openCohorts") ) {
			session.auth.openWorkshops = true;
		}
		return;
	}

	public function getCourses(type="all", orderBy="date,title,lname", recorded="no", courseid="0") {
		// Overwrite argument defaults based on params
		if ( isDefined("params.key") ) {
			arguments.type = params.key;
		}
		if ( isDefined("params.type") ) {
			arguments.type = params.type;
		}
		if ( isDefined("params.orderBy") ) {
			arguments.orderBy = params.orderBy;
		}
		if ( isDefined("params.recorded") ) {
			arguments.recorded = "yes";
		}
		if ( isDefined("params.event") ) {
			arguments.event = params.event;
		} else {
			arguments.event = getEvent();
		}
		if ( isDefined("params.courseid") ) {
			arguments.courseid = params.courseid;
		}
		if ( isDefined("params.NoQ") ) {
			showQuestionsPostLink = false;
		} else {
			showQuestionsPostLink = false;
		}
		introTitle = "Cohorts";
		courses = model("Conferencecourse").findList(order=arguments.orderby, type="#arguments.type#", recorded="#arguments.recorded#", event=arguments.event, courseid=arguments.courseid);
	}

	public function getSubtypes() {
		subtypes = structNew();
		subtypes.A = "Tuesday, July 23";
		subtypes.B = "Wednesday, July 24";
		subtypes.C = "Thursday, July 25";
		subtypes.D = "NA";
	}

	private function setKeyFromKeyy(){
		if (isDefined('params.keyy')) { params.key = params.keyy };
	}
// End of Filters




// ---------------------------------
//  CRUD
// ---------------------------------

	//  Courses/index 
	public function index() {
		courses = model("Conferencecourse").findAllCourses(params);
		renderPage(layout="/conference/adminlayout");
	}

	//  Courses/show/key 
	public function show() {
		//  Find the record 
		course = model("Conferencecourse").findOne(where="id=#params.key#", include="Agenda");
		instructors = model("Conferencecourseinstructor").findAll(where="courseId = #params.key#", include="InstructorInfo");
		//  Check if the record exists 
		if ( !IsObject(course) ) {
			flashInsert(error="Course/Workshop #params.key# was !found");
			redirectTo(action="index");
		}
		renderPage(layout="/conference/adminlayout");
	}

	//  Courses/create 
	public function create() {
		course = model("Conferencecourse").new(params.course);
		//  Verify that the Conferencecourse creates successfully 
		if ( course.save() ) {
			flashInsert(success="The Course was created successfully.");
			returnBack();
			//  Otherwise 
		} else {
			flashInsert(error="There was an error creating the course.");
			renderPage(action="new");
		}
	}

	//  Courses/update 
	public function update() {
		course = model("Conferencecourse").findByKey(params.key);
		//  Verify that the Conferencecourse updates successfully 
		if ( course.update(params.course) ) {
			flashInsert(success="The course was updated successfully.");
			returnBack();
			//  Otherwise 
		} else {
			flashInsert(error="There was an error updating the course.");
			renderPage(action="edit");
		}
	}

	//  Courses/delete/key 
	public function delete() {
		course = model("Conferencecourse").findOne(where="id=#params.key#");
		//  Verify that the Conferencecourse deletes successfully 
		if ( course.delete() ) {
			flashInsert(success="The course was deleted successfully.");
			returnBack();
			//  Otherwise 
		} else {
			flashInsert(error="There was an error deleting the course.");
			redirectTo(action="index");
		}
	}

	//  Courses/new 
	public function new() {
		course = model("Conferencecourse").new();
		course.event = getEvent();
		renderPage(layout="/conference/adminlayout");
	}

	//  Courses/edit/key 
	public function edit() {
		//  Find the record 
		course = model("Conferencecourse").findByKey(params.key);
		//  Check if the record exists 
		if ( !IsObject(course) ) {
			flashInsert(error="Course #params.key# was !found");
			redirectTo(action="index");
		}
		renderPage(layout="/conference/adminlayout");
	}

	//  Courses/copy/key 
	public function copy() {
		//  Find the record 
		course = model("Conferencecourse").findByKey(params.key);
		//  Check if the record exists 
		if ( !IsObject(course) ) {
			flashInsert(error="Course #params.key# was !found");
			redirectTo(action="index");
		}
		renderPage(controller="conference.courses", action="new");
	}

	//  Courses/copyAllToCurrentEvent 
	//  Turned off for now - 6/5/18 
<!--- 
	public function copyAllToCurrentEventX(){
			super.copyAllToCurrentEvent( tableName = "Conferencecourse" );
			returnBack();
		} --->
// END OF CRUD




//-----------------------------------
//SELECTING COHORTS/WORKSHOPS?COURSES
//-----------------------------------
	// Courses/select-workshops route="conferenceCoursesSelectWorkshops"
	public function selectWorkshops(type="cohort") {
		// over write default arguments based on params
		if ( isDefined("params.type") ) {
			arguments.type = params.type;
		}
		// if a personid is not provide go to the select person page
		if ( !isDefined("params.personid") || !len(params.personid) ) {
			redirectTo(route="conferenceCoursesSelectPersonToSelectCohorts", params="type=#arguments.type#");
		}
		// Get Workshops
		workshops = model("Conferencecourse").findAll(where="event='#getEvent()#' AND category = '#translateType(arguments.type)#'", include="Agenda", order="radioButtonGroup,eventDate,title");
		//  get this person - not sure why I need to check for personid
		if ( isDefined("params.personid") ) {
			person = model("Conferenceperson").findOne(where="id=#params.personid#", include="family");
		}
		// Set action to be used in the form
		formaction = "saveSelectedWorkshops";
	}

	// Courses/select-cohorts route="conferenceCoursesSelectCohorts"
	public function selectCohorts(type="cohort") {
		var loc=arguments;
		loc.whereString = "event='#getEvent()#'";
		if ( isDefined("params.type") ) {
			loc.whereString = "event='#getEvent()#' AND type IN ('cohort','workshop') AND (display = 'Yes' || display = 'Full')";
		}
		cohorts = model("Conferencecourse").findAll(where=loc.whereString, order="subtype title");
		if ( isDefined("params.personid") ) {
			selectedcohorts = model("Conferenceregistration").findAll(where="equip_peopleid=#params.personid# AND equip_optionsid = #getOptionIdFromName(translatetype(arguments.type))#");
			coursesIdList = "";
			for ( loc.selectedCohort in selectedCohorts ) {
				coursesIdList = coursesIdList & "," & loc.selectedCohort.equip_coursesid
			}

			coursesIdList = replace(coursesIdList,",","");
			headerSubTitle = "Select Cohorts || Workshops for #getPersonFromId(params.personid)# Here";
			if ( !len(getPersonFromId(params.personid)) ) {
				//  if these is no person at this id go to select person page
				redirectTo(route="conferenceCoursesSelectPersonToSelectCohorts", params="type=#arguments.type#");
			}
			formaction = "saveSelectedCohorts";
		} else {
			redirectTo(route="conferenceCoursesSelectPersonToSelectCohorts", params="type=#arguments.type#");
		}
	}

	public function showAllSelectedWorkshops() {
		whereString = "event='#getEvent()#' AND type='workshop'";
		if ( isDefined("params.key") ) {
			whereString = whereString & " AND id = #params.key#";
		}
		workshops = model("Conferenceregistration").findAll(where=whereString, include="Workshop(Agenda),person(family)", order="eventDate");
		countpeopleregistered = countPeopleRegistered();
	}

	public function showAllSelectedCohorts() {
		var orderby = "title";
		var loc = StructNew();
		if ( isDefined("params.orderby") ) {
			orderBy = params.orderby;
		}
		whereStringAll = "event='#getEvent()#' AND (type='cohort' || type = 'workshop')";
		if ( isDefined("params.key") ) {
			whereString = whereStringAll & " AND equip_coursesid = #params.key#";
		} else {
			whereString = whereStringAll;
		}
		workshops = model("Conferenceregistration").findAll(where=whereString, include="Workshop(Agenda),person(family)", order=orderby);
		loc.workshopsSignedUPFor = ValueList(workshops.title);
		allWorkshops = model("Conferencecourse").findAll(where=whereStringAll);
		emptyWorkshops = "";

		for ( var workshop in allWorkshops ) {
			if ( !listFind(loc.workshopsSignedUPFor,workshop.title) ) {
				emptyWorkshops = emptyWorkshops & "," & workshop.title
			}
		}

		emptyWorkshops = replace(emptyWorkshops,",","","one");
		countpeopleregistered = countPeopleRegistered();
		if ( isDefined("params.json") ) {
			cfquery( dbtype="query", name="data" ) { //Note: queryExecute() is the preferred syntax but this syntax is easier to convert generically

				writeOutput("SELECT fullname, coursetitle, eventday, eventroom
				FROM workshops
				ORDER BY fullname");
			}
			data = queryToJson(data);
			renderPage(layout="/layout_json", template="/json", hideDebugInformation=true);
		} else {
			renderPage(action="showAllSelectedWorkshops");
		}
	}

	// Courses/select-person-to-select-cohorts/
	public function selectPersonToSelectCohorts() {
		var loc=structNew();
		if ( !isDefined("params.type") ) {
			params.type = 'cohort';
		}
		loc.datelimit = createDateTime(year(now())-1,10,01,01,01,01);
		registrations = model("Conferenceperson").findAllPeopleRegistered();
		formaction = "ConferenceCoursesSelectCohorts";
		headerSubTitle = "Sign up for a Cohort || Workshop";
		renderPage(template="selectPersonToSelectWorkshops");
	}

	// Courses/select-person-to-select-cohorts/
	public function selectPersonToShowCohorts() {
		var loc=structNew();
		loc.datelimit = createDateTime(year(now())-1,10,01,01,01,01);
		registrations = model("Conferenceperson").findAllPeopleRegistered();
		formaction = "showSelectedWorkshops";
		headerSubTitle = "Show My Cohorts";
		instructions = "";
		renderPage(template="selectPersonToSelectWorkshops");
	}
//END OF SELECTING WORKSHOPS/COHORTS/COURSES





// ------------
// Public Pages
// ------------

	//  Courses/view/key route="conferenceCoursesView"
	public function view() {
		//  Find the record 
		course = model("Conferencecourse").findOne(where="id=#params.key# AND event='#getEvent()#'", include="Agenda");
		instructors = model("Conferencecourseinstructor").findAll(where="courseId = #params.key#", include="InstructorInfo");
		questions = model("Conferencecoursequestion").findAll(where="courseid=#params.key#", order="createdAt DESC", include="person(family)");
		introTitle = "Workshop...";
		//  Check if the record exists 
		if ( !IsObject(course) ) {
			flashInsert(error="Course/Workshop #params.key# was !found");
			redirectTo(action="index");
		}
	}

	//  Courses/list route="conferenceCoursesList"
	public function list() {
		if ( isDefined("params.print") ) {
			renderPage(layout="/conference/layout_naked", template="listprint");
		} else {
			setreturn();
		}
	}

	public function showAllSelectedExcursions() {
		whereString = "event='#getEvent()#' AND type='excursion'";
		if ( isDefined("params.key") ) {
			whereString = whereString & " AND equip_coursesid = #params.key#";
		}
		workshops = model("Conferenceregistration").findAll(where=whereString, include="Workshop(Agenda),person(family)", order="eventDate");
		renderPage(action="showAllSelectedWorkshops");
	}

	//  Courses/table 
	public function table(type="all", orderBy="room,date") {
		introTitle = "Workshops";
		// Overwrite argument defaults based on params
		if ( isDefined("params.key") ) {
			arguments.type = params.key;
		}
		if ( isDefined("params.type") ) {
			arguments.type = params.type;
		}
		if ( isDefined("params.orderby") ) {
			arguments.orderby = params.orderby;
			if ( params.orderby == "track" ) {
				arguments.orderBy = "track,date";
			}
			firstcolumnname = "Track";
			firstlevelgroup = "track";
		}
		courses = model("Conferencecourse").findList(order=arguments.orderby, type="#arguments.type#");
	}
	// --------------------
	// End of Public Pages
	// --------------------





	// --------------------
	// Get Text for Content
	// --------------------

	public function getSubtypeDesc(required string subtype) {
		if ( subtype == "A" ) {
			return "This cohort meets on Tuesday, July 23 from 11:00 am - 12:30 pm";
		}
		if ( subtype == "B" ) {
			return "This cohort meets on Wednesday, July 24 from 11:00 am - 12:30 pm.";
		}
		if ( subtype == "C" ) {
			return "This cohort meets on Thursday, July 25 from 11:00 am - 12:30 pm.";
		}
		if ( subtype == "D" ) {
			return "NA";
		}
		return "NA";
	}

	public function getCohortsDescription() {
		var description = '<p>Cohorts are peer learning groups focused around various areas of ministries. Participants will have lots of time to talk about what == working, what == not, ask questions, discuss best practices AND even work through issues together. Each cohort will be guided by trained facilitators.<br/> People who are registered for #getEventAsText()# can select three cohorts. </p>Each cohort meets once on either Tuesday, Wednesday || Thursday from 11:00 - 12:30. 
      </p>
      <p>
			We are also offering a workshops each day during the same times as cohorts.  Workshops are designed for larger groups, are more didactic with a teacher rather than a facilitator.  Workshops are marked.
      </p>';
		return description;
	}
// ------------------------------
// END OF Get Text for Content
// ------------------------------

	
	
	
	
// ------------
// Redirections
// ------------

	// Courses/workshops
	public function workshops() {
		redirectTo(controller="conference.courses", action="list", params="type=workshop");
	}
	//  Courses/workshopstable .get(name="conferenceworkshopstable", pattern="/workshops/table/", controller="courses", action="workshopstable") 

	public function workshopstable() {
		redirectTo(controller="conference.courses", action="table", params="type=workshop");
	}
	// Courses/riskursions

	public function riskursions() {
		redirectTo(controller="conference.courses", action="list", params="type=excursion");
	}

	public function listCohorts() {
		if ( isDefined("params.print") ) {
			renderPage(action="list", key="cohort", layout="/conference/layout_naked", template="listprint");
		} else {
			setreturn();
			renderPage(action="list", key="cohort");
		}
	}
	// -------End of Redirections--------------




	//  Courses/rss 
	public function rss() {
		courses = model("Conferencecourse").findList();
		title = "#getEventAsText()# Workshops";
		description= "#getEventAsText()# will include a number of workshops.";
		if ( application.wheels.environment != "production" ) {
			set(environment="production");
		}
		renderPage(template="rss.cfm", layout="rsslayout");
	}

	public function getInstructors(required numeric courseid) {
		var loc=structNew();
		loc = arguments;
		loc.instructors = model("Conferencecourseinstructor").findAll(where="courseId = #loc.courseid#", include="Instructor");
		return loc.instructors;
	}

	public function getInstructorNamesAsString(required courseid) {
		var loc=structNew();
		loc = arguments;
		loc.instructors = getInstructors(val(loc.courseid));
		loc.names = "";
		for ( var instructor in loc.instructors ) {
			loc.names = loc.names & ", " & "#linkto(text=instructor.selectName, controller='conference.instructors', action='show', key=instructor.id)#"
		}
		loc.names = replace(loc.names,", ","","one");
		return loc.names;
	}

	public function getPersonFromId(required numeric id) {
		personName = model("Conferenceperson").findAll(where="id=#arguments.id#", include="family").fullname;
		return personName;
	}

	public function saveSelectedCohorts(type="cohort") {
		var i = 0;
		if ( isDefined("params.type") ) {
			arguments.type = params.type;
		}
		deletedSelectedWorshopsForPersonid(params.personid,params.type);
		if ( isDefined("params.cohorts") && listlen(params.cohorts) <= getSetting('maxCohorts') ) {
			for ( i in params.cohorts ) {
				registration = model("Conferenceregistration").new();
				registration.equip_peopleid = params.personid;
				registration.equip_coursesid = i;
				registration.equip_optionsid = getOptionIdFromName(translatetype(arguments.type));
				registration.equip_invoicesid = 1115;
				registration.quantity = 1;
				check = registration.save();
			}
			redirectTo(action="showSelectedWorkshops", params="type=#params.type#&personid=#personid#");
		} else {
			flashInsert(toomany="Too many cohorts were selected. Please pick 2.");
			redirectTo(action="selectCohorts", personid=params.personid, params="type=#params.type#&personid=#personid#");
		}
	}

	/**
	 * allows variable in type that is called for
	 */
	public function translateType(required string type) {
		var loc=structNew();
		loc.workshops = "workshop";
		loc.workshop = "workshop";
		loc.excursion = "excursion";
		loc.riskursion = "excursion";
		loc.riskursions = "excursion";
		loc.riscursion = "excursion";
		loc.riscursions = "excursion";
		loc.cohorts = "cohort";
		loc.cohort = "cohort";
		return type;
	}

	public function isInWorkkshop(required numeric personid, required numeric workshopid) {
		thisPersonsWorkshops = model("Conferenceregistration").findOne(where="equip_peopleid=#arguments.personid# AND equip_coursesid=#arguments.workshopid#", include="Workshop");
		if ( isObject(thisPersonsWorkshops) ) {
			return true;
		} else {
			return false;
		}
	}

	public function saveSelectedWorkshops(type="#params.type#") {
		deletedSelectedWorshopsForPersonid(params.personid,params.type);
		dates = model("Conferencecourse").getCourseDates(translateType(arguments.type));
		for ( i in dates ) {
			for ( ii in params.radioButtonGroups ) {
				if ( ii == "0" ) {
					iii = i;
				} else {
					iii = i&ii;
				}
				registration = model("Conferenceregistration").new();
				registration.equip_peopleid = params.personid;
				registration.equip_coursesid = params[#iii#];
				registration.equip_optionsid = getOptionIdFromName(translatetype(arguments.type));
				registration.equip_invoicesid = 1115;
				registration.quantity = 1;
				registration.save();
			}
		}
		redirectTo(action="showSelectedWorkshops", params="personid=#params.personid#&type=#arguments.type#");
	}

	public function showSelectedWorkshops(type="cohorts,workshops") {
		/*  <cfif isDefined("params.type")>
			<cfset arguments.type = params.type>
		<cfelse>
			<cfset params.type = arguments.type>	
		</cfif> */
		/*  <cfif !isDefined("params.personid")>
			<cfset redirectTo(route="conferenceCoursesSelectPersonToSelectCohorts")>
		</cfif> */
		var loc = arguments;
		loc.sendString = "from='tomavey@fgbc.org', layout='/conference/layout_for_email', template='showSelectedWorkshops', subject='Your cohort || workshop selections...'";
		//  <cfset arguments.type = translateType(arguments.type)> 
		if ( isDefined("params.personid") ) {
			try {
				workshops = model("Conferenceregistration").findAll(where="equip_peopleid=#params.personid# AND (type = 'cohort' || type='workshop')", include="Workshop(Agenda)", order="eventDate");
				person = model("Conferenceperson").findOne(where="id=#params.personid#", include="family");
			} catch (any cfcatch) {

				writeOutput("//TODO - Set up a flash for redirect");
				redirectTo(route="mycohorts");
			}
		} else {
			redirectTo(action="selectPersonToShowCohorts", params="type=#arguments.type#&encodePersonId=false");

			writeOutput("Need to get personid");
			abort;
		}
		try {
			if ( isValid("email",person.email) && workshops.recordcount ) {
				loc.sendString = loc.sendString & ", to=person.email";
				if ( workshopNotificationsOpen() ) {
					sendEmail(from='tomavey@fgbc.org', layout='/conference/layout_for_email', template='showSelectedWorkshops', subject='Your cohort selections...', to=person.email, bcc=workshopnotifications());
				} else {
					sendEmail(from='tomavey@fgbc.org', layout='/conference/layout_for_email', template='showSelectedWorkshops', subject='Your cohort selections...', to=person.email);
				}
				flashInsert(success="#capitalize(arguments.type)# selections were sent to #person.email#");
			}
		} catch (any cfcatch) {
		}
		try {
			if ( isValid("email",person.family.email) && person.family.email != person.email ) {
				if ( application.wheels.workshopNotificationsOpen ) {
					sendEmail(from='tomavey@fgbc.org', layout='/conference/layout_for_email', template='showSelectedWorkshops', subject='Your cohort selections...', to=person.family.email, bcc=application.wheels.workshopnotifications);
				} else {
					sendEmail(from='tomavey@fgbc.org', layout='/conference/layout_for_email', template='showSelectedWorkshops', subject='Your cohort selections...', to=person.family.email);
				}
				flashInsert(success="#capitalize(arguments.type)# selections were sent to #person.family.email#");
			}
		} catch (any cfcatch) {
		}
		if ( isMobile() ) {
			renderPage(layout="/conference/layout_mobile");
		}
		setreturn();
		headerSubTitle = "Selected Cohorts";
	}

	public function sendSelectedWorkshops(type="", personid="#params.personid#", sendToEmail="tomavey@fgbc.org") {
		arguments.type = translateType(arguments.type);
		if ( isDefined("params.email") && isValid("email",params.email) ) {
			arguments.sendToEmail = params.email;
		} else {
			flashInsert(success="Please provide a valid email address to send this list to.");
			redirectTo(action="showSelectedWorkshops", params="personid=#params.personid#&type=#params.type#");
		}
		workshops = model("Conferenceregistration").findAll(where="equip_peopleid=#arguments.personid# AND (type = 'cohort' || type='workshop')", include="Workshop(Agenda)", order="eventDate");
		person = model("Conferenceperson").findOne(where="id=#params.personid#", include="family");
		if ( !isLocalMachine() ) {
			sendEMail(to=arguments.sendToEmail, from="tomavey@fgbc.org", layout="/conference/layout_for_email", template="showSelectedWorkshops", subject="Access2017 #params.type# selections");
			flashInsert(success="The email was sent to #arguments.sendToEmail#");
		} else {
			flashInsert(success="The email was !sent to #arguments.sendToEmail# from this local server");
		}
		redirectTo(action="showSelectedWorkshops", params="personid=#params.personid#&type=#params.type#");
	}

	public function downloadAllSelectedCohorts() {
		var orderby = "title";
		if ( isDefined("params.orderby") ) {
			orderBy = params.orderby;
		}
		whereString = "event='#getEvent()#' AND type='cohort'";
		if ( isDefined("params.key") ) {
			whereString = whereString & " AND equip_coursesid = #params.key#";
		}
		workshops = model("Conferenceregistration").findAll(where=whereString, include="Workshop(Agenda),person(family)", order=orderby);
		countpeopleregistered = countPeopleRegistered();
		renderPage(action="downloadallselectedworkshops", layout="/layout_download");
	}

	public function countPeopleRegistered() {
		var return = model("Conferenceregistration").countRegsByType(ccstatus="All",includeFree="true") + model("Conferenceregistration").countRegsByType(type="Couple", ccstatus="All",includeFree="true");
		return return;
	}

	public function countEligibleToSignup() {
		var regs = structNew();
		regs.vTORcouples = model("Conferenceregistration").countRegs(348,params) + model("Conferenceregistration").countRegs(354,params);
		regs.vTORsingles = model("Conferenceregistration").countRegs(349,params) + model("Conferenceregistration").countRegs(351,params);
		regs.vTORdaysingle = model("Conferenceregistration").countRegs(350,params);
		regs.vTORprepaid = model("Conferenceregistration").countRegs(360,params)*2 + model("Conferenceregistration").countRegs(361,params);
		regs.vTORFreeYoung = model("Conferenceregistration").countRegs(352,params) + (model("Conferenceregistration").countRegs(355,params) * 2);
		regs.vTORFreeOld = model("Conferenceregistration").countRegs(356,params) + (model("Conferenceregistration").countRegs(359,params) * 2);
		regs.vTORFree = regs.vTORFreeYoung + regs.vTORFreeOld;
		regs.vTORall = (regs.vTORcouples*2) + regs.vTORsingles + regs.vTORdaysingle + regs.vTORprepaid + regs.vTORFree;
		return regs.vTORall;
	}

	public function getEventEquipmentForThisCourse(eventid="716") {
		var loc = structNew();
		loc.eventinfo = model("Conferenceevent").findOne(where="id = #arguments.eventid#");
		//  <cfdump var="#loc.eventinfo.properties()#"><cfabort> 
		return loc.eventinfo;
	}

	public function deletedSelectedWorshopsForPersonid(required numeric personid, required string type) {
		var loc = structNew();
		loc=arguments;
		loc.optionid = getOptionIdFromName(translatetype(loc.type));
		loc.workshops = model("Conferenceregistration").deleteAll(where="equip_peopleid = #loc.personid# AND equip_optionsid = #loc.optionid#");
		return true;
	}

	public function deletedSelectedWorshopsForRegId() {
		worshops = model("Conferenceregistration").deleteAll(where="id = #params.key#");
		returnBack();
	}

	public function isSignedUpForCourse() {
	}

	public function alsoSignedUpFor(required numeric courseId) {
		var loc = arguments;
		loc.alsoSignedUpFor = model("Conferencecourse").alsoSignedUpFor(courseId);
		return loc.alsoSignedUpFor;
	}

	public function getCourseResources(required numeric courseId) {
		var resources = model("Conferencecourseresource").findall(where="id=#arguments.courseId#", order="createdAt DESC");
		return resources;
	}

	public function json() {
		data = model("Conferencecourse").findAllAsJson(params);
		renderPage(layout="/layout_json", template="/json", hideDebugInformation=true);
	}
	//  MArked for Deletion

	public function XgetRadioButtonGroups() {
		radioButtonTypes = "";
		for ( i in params ) {
		}
	}

	function gotRightsForEmailLinks() {
			return gotRights("basic")
		}

}
