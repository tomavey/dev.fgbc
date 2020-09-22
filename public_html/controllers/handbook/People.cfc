//
//Written by Tom Avey for the Charis Fellowship
//Refactored October 2019 to use cfscript
//Used by the online handbook application - people (church and ministry staff)
//
component extends="Controller" output="true" {

	function init(){
		usesLayout("/handbook/layout_handbook")
		filters(through="gotBasicHandbookRights,getStates,getPositionTypes", except="focus,sendhandbook,inspire,findstaff,findallstaff")
		filters(through="getPositions", only="edit,show,view")
		filters(through="getChurches", only="new,edit,create,update")
		filters(through="setReturn", only="show,bluepages,distribution")
		filters(through="setIsAgbmAdmin")
		filters(through="logview", type="after", only="show")
		provides("json")
	}	


<!--------------->
<!----FILTERS---->	
<!--------------->

	private function getStates(){
		states = model("Handbookstate").findall(order="state")
	}

	private function getPositions(){
		if ( isDefined("params.keyy") ) {
			params.key = params.keyy
		}
		if ( gotrights("superadmin,agbmadmin") ) {
			positions = model("Handbookposition").findAll(where="personid=#params.key#", include="Handbookorganization(Handbookstate)", order="p_sortorder")
		} else {
			positions = model("Handbookposition").findAll(where="personid=#params.key# AND positionTypeId <> 32 AND position NOT LIKE '%Remove%'", include="Handbookorganization(Handbookstate)", order="p_sortorder")
		}
	}

	private function getPositionTypes(){
		positionTypes = model("Handbookpositiontype").findall(order="position")
	}

	private function getChurches(){
		churches = model("Handbookorganization").findall(where="show_in_handbook = 'yes'", include="Handbookstatus,Handbookstate", order="org_city,state,name")
	}

	private function setIsAgbmAdmin(){
		if ( isDefined("params.agbm") ) {
			isAgbmAdmin = true
			session.handbook.agbmnew = true
		} else if ( isDefined("session.handbook.agbmnew") and session.handbook.agbmnew ){
			isAgbmAdmin = true
		} else (
			isAgbmAdmin = false
		)
	}


<!-------------------->
<!---End of Filters--->
<!-------------------->



<!-------------------------->
<!-----BASIC CRUD----->
<!-------------------------->

	// route="handbookPeople" pattern="handbook/people"
	public function index(){
		allHandbookPeople = model("Handbookperson").findAll(where="p_sortorder < #getNonStaffSortOrder()+1#", order="alpha", include="Handbookstate,Handbookpositions")
		handbookPeople = model("Handbookperson").findHandbookPeople(params)
	}

	public function show(){
		try {
			handbookperson = model("Handbookperson").findOne(where="id=#params.key#", include="Handbookstate,Handbookprofile,Handbookpictures,Handbooknotes")
			tags=model("Handbooktag").findMyTagsForId(params.key,"person")
			if ( gotrights("agbm,office,superadmin,agbmadmin") ){
				handbookGroup = model("Handbookgroup").new()
				handbookGroup.personId = params.key
				allgroups = model("Handbookgrouptype").findAll(order="title")
				groups = model("Handbookgroup").findAll(where="personid=#params.key#", include="handbookGroupType")
			}
			if ( !isObject(handbookperson) ){
				redirectTo(action="index", error="Handbookperson #params.key# was not found")
			}
			if ( isdefined("params.ajax") ){
				renderPartial("show")
			}
		} catch (any e) {
			$sendPersonPageErrorNotice("Charis Fellowship Handbook Person Show Error")
		}
	}

	<!---route="handbookViewperson", pattern="/handbook/people/[key]"---->
	<!---this "view controller was used to provide more public access to people info.  Caused security concerns so it has been locked behind login--->
	public function view(){
		handbookperson = model("Handbookperson").findOne(where="id=#params.key#", include="State,Handbookpositions,Handbookpictures")
		if ( handbookperson.private is "yes" ){
			redirectTo(action="index")
		}
		renderPage(layout="/handbook/layout_handbook2")
	}

	public function inspire(){
		renderPage(layout="/handbook/layout_handbook_vue")
	}

	public function new() {
		var loc = structNew();
		loc.newposition = [ model("Handbookposition").new() ];
		loc.newprofile = model("Handbookprofile").new();
		handbookperson = model("Handbookperson").new(handbookpositions = loc.newposition, handbookprofile=loc.newprofile);
		// Set up organizationid if provided in key
		if ( isDefined("params.key") ) {
			handbookperson.handbookpositions[1].organizationid = params.key;
		}
		// Set the default sortorder or use sortorder provided in params is exists
		if ( isDefined("params.sortorder") ) {
			handbookperson.handbookpositions[1].p_sortorder = params.sortorder;
		} else {
			handbookperson.handbookpositions[1].p_sortorder = #getNonStaffSortOrder()#;
		}
		if ( isAgbmAdmin ) {
			handbookperson.handbookpositions[1].p_sortorder = #getNonStaffSortOrder()#;
			handbookperson.handbookpositions[1].position = "AGBM Only";
			handbookperson.handbookpositions[1].positiontypeid = 32;
		}
		if ( isDefined("params.organizationid") ) {
			handbookperson.handbookpositions[1].organizationid = params.organizationid;
		}
		renderPage(layout="/handbook/layout_handbook1.cfm");
	}

	// "editHandbookPerson" /handbook/people/[key]/edit
	public function edit() {
		var profile = "";
		//  Find the record 
		handbookperson = model("Handbookperson").findByKey(key=params.key, include="Handbookstate,Handbookpositions,Handbookprofile");
		//  Check if the record exists 
		if ( !IsObject(handbookperson) ) {
			flashInsert(error="HandbookPerson #params.key# was !found");
			redirectTo(action="index");
		}
		renderPage(layout="/handbook/layout_handbook2.cfm");
	}

	// handbookPeople	POST	/handbook/people
	public function create() {
		handbookperson = model("Handbookperson").new(params.handbookperson);
		if ( !len(handbookperson.stateid) ) {
			handbookperson.stateid = 60;
		}
		//  Verify that the handbookperson creates successfully 
		if ( handbookperson.save() ) {
			flashInsert(success="The handbookperson was created successfully.");
			if ( isAgbmAdmin ) {
				redirectTo(route="handbookAddAGBMPayment", key=handbookperson.id);
			} else {
				returnBack("show");
			}
			//  Otherwise 
		} else {
			errors=handbookperson.handbookpositions[1].allerrors();
			flashInsert(error="There was an error creating this staff person. Check to make sure you selected the correct church || ministry && that you selected a state.");
			renderPage(action="new", layout="/handbook/layout_handbook2.cfm");
		}
	}
		
	// handbookPerson	PUT	/handbook/people/[key]
	private function update() {
		// Check to see if there is a profile record for this person and create one if not
		handbookprofile = model("Handbookprofile").findOne(where='personid = #params.key#');
		if ( !isObject(handbookprofile) ) {
			handbookprofile = model("Handbookprofile").new(params.handbookperson.handbookprofile);
			handbookprofile.personid = params.key;
			if ( handbookprofile.save() ) {
				flashInsert(success="The profile was created successfully.");
			} else {
				flashInsert(success="The profile was !created.");
			}
		}
		handbookperson = model("Handbookperson").findByKey(key=params.key, include="Handbookstate,Handbookprofile,Handbookpositions");
		//  Verify that the handbookperson updates successfully 
		if ( handbookperson.update(params.handbookperson) ) {
			errors = handbookperson.handbookprofile.allerrors();
			flashInsert(success="This person was updated successfully.");
			try {
				if ( $isSendImmediatePersonUpdates() ) {
					sendEmail(
							to=getSetting("HandbookProfileSecretary"),
							from="tomavey@fgbc.org",
							subject="Person Update",
							layout="/layout_naked",
							template="/handbook/updates/notices"
							);
				}
				flashInsert(success="This person was updated successfully!");
			} catch (any cfcatch) {
			}
			returnBack();
			//  Otherwise 
		} else {
			errors = handbookperson.handbookprofile.allerrors();
			renderPage(action="edit", error="There was an error updating this person.");
		}
	}

	//  handbookPerson	DELETE	/handbook/people/[key] 
	function delete() {
		handbookperson = model("Handbookperson").findByKey(key=params.key, include="HandbookState,Handbookpositions");
		profilesDeleted = model("Handbookprofile").deleteAll(where="personid=#params.key#");
		picturesDeleted = model("Handbookpicture").deleteAll(where="personid=#params.key#");
		//  Verify that the handbookperson deletes successfully 
		if ( handbookperson.delete() ) {
			flashInsert(success="The handbookperson was deleted successfully.");
			returnBack();
			//  Otherwise 
		} else {
			flashInsert(error="There was an error deleting the handbookperson.");
			redirectTo(action="index");
		}
	}

<!--------------------------->
<!-------END OF BASIC CRUD--->
<!--------------------------->





<!--------------------------->
<!-------SPECIAL REPORTS----->
<!--------------------------->

	public function downloadStaff() {
		allHandbookPeople = model("Handbookperson").findAll(where="p_sortorder <= #getNonStaffSortOrder()#", include="Handbookstate,Handbookpositions(Handbookorganization(Handbookdistrict))", order="lname,fname");
		$setDownloadLayout();
	}

	public function handbookInfo() {
		if ( isDefined("params.key") ) {
			people = model("Handbookperson").findall(where="organizationid='#params.key#' && p_sortorder < #getNonStaffSortOrder()#", include="Handbookpositions,Handbookstate", order="lname,fname");
		} else {
			people = model("Handbookperson").findall(where="p_sortorder < #getNonStaffSortOrder()#", include="Handbookpositions,Handbookstate", order="lname,fname");
		}
		renderPage(layout="/layout_naked");
	}

	// handbookBluepages	GET	/handbook/people/bluepages
	public function bluepages() {
		includeString = "Handbookstate,Handbookpositions(Handbookorganization(District))";
		orderString = "lname,fname,id";
		whereString = $buildWhereStringForBluePages(params)

		//  Run the query then filter out persons that should not be listed in the handbook 
		bluepagesPeople = model("Handbookperson").findAll(where=whereString, order=orderString, include=includeString);
		bluePagesPeople = queryFilter(bluepagesPeople, $isInHandbookMap);
		allhandbookpeople = bluepagesPeople;

		//  select layout and template based on params 
		if ( isDefined("params.layout") && params.layout == "naked" ) {
			renderPage(layout="/layout_naked");
		} else if ( isDefined("params.download") ) {
			renderpage(template="downloadstaff", layout="/layout_download");
		} else if ( isDefined("params.preview") ) {
			renderpage(template="downloadstaff", layout="/layout_naked");
		} else {
			renderPage(layout="/handbook/layout_handbook1");
		}
	}

	//probably not needed since the send handbook update links feature was created
	public function distribution() {
		var loc = structNew();
		loc.whereString = "p_sortorder = 500 AND state <> 'Non US' AND position <> 'Removed From Staff'";
		loc.whereString = loc.wherestring & " AND statusid in (1,8,3,4,2,9,10,11)";
		if ( isDefined("params.sendHandbookOnly") ) {
			loc.whereString = loc.whereString & " AND sendhandbook = 'yes'";
		}
		people = model("Handbookperson").findAll(where=loc.whereString, order="lname,fname,id", include="Handbookstate,Handbookpositions(Handbookorganization)");
		if ( isDefined("params.showHandbookLinkColumn") ) { showHandbookLinkColumn = true }
		$setDownloadLayout()
	}

	// Used for birthday and anniversary reports
	public function dates() {
		if ( !isDefined("params.dateType") ) {
			params.dateType = "birthday";
		}
		datesSorted = model("Handbookperson").findDatesSorted(params.dateType);
		datesSorted = queryFilter(datesSorted,function(el){
			return isInHandbook(el.personid) && !hasAnAlias(el.personid)
		})
		datesThisWeek = model("Handbookperson").findDatesThisWeek(params.dateType);
		subscribed = model("Handbooksubscribe").findOne(where="email = '#session.auth.email#' && type='dates'");
		if ( isObject(subscribed) ) {
			params.isSubscribed = true;
		}
	}
	
	public function datesByYear() {
		if ( !isDefined("params.dateType") ) {
			params.dateType = "birthday";
		}
		datesSorted = model("Handbookperson").findDatesSorted(params.dateType,"birthdayyear DESC");
	}
	
	//Used by the focus retreat admin to create an email list of everyone who has recently attended each focus retreat PLUS anyone attending a church in a district served by that focus retreat
	public function focus() {
		if ( isDefined("params.keyy") ) {
			params.key = params.keyy;
		}
		people = model("Handbookperson").findFocus(params);
		if ( isDefined("params.csv") ) {
			people = QueryToCSV(people,'fname, lname, email, phone, phone1')
		}
		$setDownloadLayout()
	}

	public function downloadAGBM() {
		var loc=structNew()
		loc.orderString = "lname,fname"
		if ( isDefined("params.byAge") ) {
			loc.orderString = "birthdayyear #params.byAge#,lname,fname"
		}
		loc.currentmembershipyear = model("Handbookagbminfo").currentMembershipYear(params)
		agbmmembers = model("Handbookperson").findAll(where="membershipfeeyear = #loc.currentmembershipyear# && p_sortorder <= 500", include="Handbookstate,Handbookagbminfo,Handbookpositions,Handbookprofile", order=loc.orderString)
		$setDownloadLayout()
	}

	//handbook/people/review - route = handbookPeopleReview
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
		// writeOutput(serialize(people));abort;
		testpeople = model("Handbookperson").getHandbookReviewStruct(
			lastReviewedBefore=lastReviewedBefore,
			orderby=orderby, 
			type=type, 
			tag=tag,
			go=false
			);	
		emailMessage = $getEmailMessageForPeopleReview();
		tags = model("Handbooktag").findMyTags(auth=session.auth, group="tag");
		renderPage(layout="/handbook/layout_handbook2")
	}

	// Sends an email to every person and organization email address - edit email in _message.cfm - does not have a menu option
	function sendToHandbookPeople() {
		emailall = "";
		count = 0;
		emailsubject = getEmailSubject();
		maxsortorder = 500;
		maxrows = 100000;
		if ( isDefined("params.test") ) {
			maxrows = 5;
		}
		distinctEmails = model('Handbookperson').getAllEmails(maxsortorder,maxrows)
		for ( distinctemail in distinctemails) {
			if ( isValid("email",distinctemail.emailsend) ) {
				emailall = emailall & "; " & distinctemail.emailsend
				count = count + 1
				if ( isdefined("params.go") && params.go is "send" && !isLocalMachine() ) {
					sendEmail(from="tomavey@charisfellowship.us", subject=emailsubject, to=distinctemail.emailsend, template="message", layout="/layout_naked", name=name)
				}
				if ( isdefined("params.go") && params.go is "test" && !isLocalMachine() ) {
					sendEmail(from="tomavey@charisfellowship.us", subject=emailsubject, to="tomavey@fgbc.org", template="message", layout="/layout_naked", name=name)
				}
			}
		}
		emailall = replace(emailall,"; ","","one");
		renderPage(layout="/layout_naked");
	}	

	public function pastorsWives(){
		var onlyIfEmail = false
		if ( isDefined('params.onlyIfEmail') ) { onlyIfEmail = true }
		pastorsWives = model("Handbookperson").findPastorsWives(titleIncludesList = 'pastor,chaplain', onlyIfEmail = onlyIfEmail)
		$setDownloadLayout(template='downloadwives')
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
		if ( !isLocalMachine() ){
			sendEmail(
				to=people[i].email, 
				from=getHandbookReviewSecretary(), 
				subject=getSetting('PersonHandbookReviewGreeting'), 
				bcc="charis@fgbc.org", 
				template="emailPeopleForHandbookReview.cfm", 
				layout="/layout_for_email", 
				args=people[i]
			);
		}
		allemails = allemails & "; " & people[i].email; 
		};
		allemails = replace(allemails,"; ","","one");
		structDelete(session,"people");

	renderPage(template="emailPeopleForHandbookReviewReport", layout="/handbook/layout_handbook2");
	}


	function $sendPersonPageErrorNotice(subject="Charis Fellowship Person Page Error"){
		if ( !isLocalMachine() ) {
			sendEmail(from=application.wheels.errorEmailAddress, to=application.wheels.errorEmailAddress, template="personpageerroremail.cfm", subject=arguments.subject)
		} else {
			renderPage(template="personpageerroremail.cfm")
		}
	}

	function cellPhoneNumbers(){
		var orderString = "lname, fname"
		if ( isDefined("params.sortby") ) { orderString = params.sortBy }
		if ( isDefined("params.desc") ) { orderString = orderString & " DESC" }
		var phoneNumbers = model("Handbookperson").findall(select="id, fname, lname, phone2, createdAt, UpdatedAt", include="State", order=orderString)
		cellPhoneNumbers = queryFilter(phoneNumbers, function(el){
			return len(el.phone2)
		})
		if( isDefined("params.noFormat") ) { renderPage(layout="/layout_naked") }
	}
	
	
<!---------------------------->
<!---End of special reports--->
<!---------------------------->




<!-------------------->	
<!--- PROVIDES JSON--->	
<!-------------------->	

public function findAllStaff() {
	staff = model("Handbookperson").findAllStaff();
	renderPage(layout="/layout_json", template="json", hideDebugInformation=true);
}

public function findStaff() {
	staff = model("Handbookperson").findStaff(params.key);
	renderPage(layout="/layout_json", template="json", hideDebugInformation=true);
}
<!-------------------------->	
<!---END OF PROVIDES JSON--->	
<!-------------------------->	





<!-------------------------------------->
<!---UTILITIES CALLED FROM VIEWS-------->
<!-------------------------------------->

	public function hideFromPublic(personid) {
		var person = model("Handbookperson").findOne(where="id=#personid#", include="state")
		person.hideFromPublic = 1
		person.update()
		returnBack()
	}

	public function unHideFromPublic(personid) {
		var person = model("Handbookperson").findOne(where="id=#personid#", include="state")
		person.hideFromPublic = 0
		person.update()
		returnBack()
	}

	public function addStaff(organizationid,sortOrder){
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

	public function setReview(personId="#params.key#") {
			person = model("Handbookperson").findOne(where="id=#arguments.personid#", include="Handbookstate")
			person.reviewedAt = now()
			person.reviewedBy = session.auth.email
			test = person.update()
			returnBack()
		}

	public function addToAGBMMailList() {
		var loc = structNew()
		loc.return = false
		loc.check = model("Handbookgroup").findOne(where="personid=#params.key# && grouptypeid = 16")
		if ( !isObject(loc.check) ) {
			loc.group = model("Handbookgroup").new()
			loc.group.personid = params.key
			loc.group.grouptypeid = 16
			if ( loc.group.save() ) {
				loc.return = true
			}
		}
		returnBack()
	}

	public function changeSortOrder(numeric newSortOrder="10") {
		person = model("Handbookperson").findOne(where="id=#params.key#", include="Handbookstate")
		person.sortOrder = arguments.newsortorder
		person.update()
		returnBack()
	}

	public function connectRegToHandbook(regPersonId="", handbookPersonId="") {
		if ( isDefined("params.regPersonId") ) {
			arguments.regpersonid = params.regpersonid
		}
		if ( isDefined("params.handbookPersonId") ) {
			arguments.handbookPersonId = params.handbookPersonId
		}
		regPerson = model("Equip_person").findOne(where="id=#arguments.regPersonId#")
		regPerson.handbookpersonid = arguments.handbookPersonid
		regPerson.update()
		returnBack()
	}

	public function setSendHandbook(send="No") {
		var loc=structNew()
		loc.return = ""
		if ( isDefined("params.key") ) {
			person = model("Handbookperson").findOne(where="id=#simpleDecode(params.key)#", include="Handbookstate")
			person.update(sendHandbook="yes")
			returnBack()
		} 
			renderText("Something did not work")	
	}

	public function clearSendHandbooks() {
		clear = model("Handbookperson").clearSendHandbooks()
		returnBack()
	}
	
	public function removePersonFromSessionArray(item){
		ArrayDeleteAt(session.people,item)
		redirectTo(action="handbookReviewOptions", params="refresh=false")
	}

	public function changeToAGBMOnly (positionId){
		if (isDefined("params.positionid")){arguments.positionid = params.positionid}
		var thisPosition = model("Handbookposition").findOne(where="id=#arguments.positionid#")
		thisPosition.position = "AGBM Only"
		thisPosition.positionTypeId = 32
		thisPosition.save()
		returnback()
	}
<!---------------------------------------->
<!---END OF UTILITIES CALLED FROM VIEWS--->
<!---------------------------------------->


<!-------------------------------------->
<!---UTILITIES CALLED FROM CONTROLLER--->
<!-------------------------------------->

	private function $isSendImmediatePersonUpdates(){
		return getSetting("SendImmediatePersonUpdates");
	}

	private function $getThisUserName(){
		try {return session.auth.username;}
		catch (any e){return "none";};
	}

	private function $getEmailMessageForPeopleReview(){
		var emailMessage = "<h3>We are updating our database for the #year(now())+1# Charis Fellowship Handbook!</h3><p>Churches have updated their staff. You can check your personal listing before #getSetting('personReviewDeadline')# using the link below.</p><p>Be sure to click the 'This information is correct' button when you are finished. </p>";
		return emailMessage; 
	}

	private function $isInHandbookMap(obj){
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

	private function $buildWhereStringForBluePages(required struct params){
		var whereString = "statusid in (1,8,3,4,2,9,10,11)";

		//Switch to for show removed staff or not
		if ( !isDefined("params.showremoved") ) {
			whereString = whereString & " AND position NOT LIKE '%Removed%'";
		}

		//Switch for different kinds of staff	
		if ( isDefined("params.nonstaff") ) {
			whereString = whereString & " AND p_sortorder = #getNonStaffSortOrder()#";
		} else if ( isDefined("params.staffonly") ) {
			whereString = whereString & " AND p_sortorder < #getNonStaffSortOrder()#";
		} else if ( isDefined("params.pastoralstaffonly") ) {
			whereString = whereString & " AND p_sortorder < #getNonStaffSortOrder()# AND position LIKE '%pastor%'";
		} else if ( isDefined("params.showremovedstaffonly") ) {
			whereString = whereString & " AND position LIKE '%Removed%'";
		} else {
			whereString = whereString & " AND p_sortorder <= #getNonStaffSortOrder()#";
		}

		//Switch for filters
		if ( isDefined("params.districtid") ) {
			whereString = whereString & " AND districtid = #params.districtid#";
		}
		if ( isDefined("params.gender") ) {
			whereString = whereString & " AND fnameGender = '#params.gender#'";
		}
		if ( isDefined("params.lname") ) {
			whereString = whereString & " AND lname like '#params.lname#%'";
		}
		if ( isDefined("params.alpha") ) {
			whereString = whereString & " AND alpha =  '#params.alpha#'";
		}
		if ( isDefined('params.aged') ) {
			whereString = whereString & " AND updatedAt < '#params.aged#'";
		}

		return whereString
	}

<!--------------------------------------------->
<!---END OF UTILITIES CALLED FROM CONTROLLER--->
<!--------------------------------------------->

}