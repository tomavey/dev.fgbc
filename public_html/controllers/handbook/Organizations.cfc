//
//Written by Tom Avey for the Charis Fellowship
//Refactored October 2019 to use cfscript
//Used by the online handbook application - organizations (churches and ministries)
//
component extends="Controller" output="false" {

	function init(){
		usesLayout("/handbook/layout_handbook")
		filters(through="gotBasicHandbookRights", except="memberChurches,findChurches,findChurchWithStaff,groupRoster")
		filters(through="getStates,getDistricts,getStatus", only="new,edit,update,index,create,downloadguidelines")
		filters(through="setWillNotShowString,getGroupRosterOptions", only="new,edit")
		filters(through="setReturn", only="show,handbookpages")
		filters(through="logview", type="after", only="show")
		provides("json")
	}

<!------------------------>
<!---------Filters-------->
<!------------------------>

	private function getStates(){
		states = model("Handbookstate").findall(order="state")
	}

	private function getDistricts(){
		districts = model("Handbookdistrict").findall(order="district")
	}

	private function getStatus(){
		status = model("Handbookstatus").findall(order="status")
	}

	private function setWillNotShowString(){
		//used by 'status' dropdown in organization form to shwow which status will dissapear
		var NoShow = model("Handbookstatus").findall(where="show_in_handbook = 0")
		willNotShowString = ""
		for ( item in NoShow ) {
			willNotShowString = willNotShowString & ", " & item.status
		}
		willNotShowString = replace(willNotShowString,", ","","one")
	}

	private function XisOnStaffHere(){
		if ( gotRights("superadmin,office") ) { return true }
		if ( isDefined("session.auth.handbook.review") and session.auth.handbook.review ) { return true }
		if ( isDefined("params.key") and isDefined("session.auth.handbook.organizations") and find(params.key,session.auth.handbook.organizations) ) { return true }
		renderText("You do not have permission to view this page")
	}

	private function getGroupRosterOptions() {
		//used by 'group roster' dropdown in organization form to select a group roster status/date
		groupsRosterOptions = "Yes,No,#year(now())#,#year(now())-1#,#year(now())-2#"
	}

<!------------------------>
<!------END OF FILTERS---->
<!------------------------>





<!------------------------>
<!-------Basic CRUD------->	
<!------------------------>

	<!--- handbook-organizations/index --->
	public function index(){
		param name="params.page" default="1";
		request.showpagination = true
		if ( isDefined("params.page") ) { page=params.page }
		states = model("Handbookorganization").findStatesWithOrganizations()

		var whereString = "show_in_handbook = 1"
		var includeString="handbookstate,handbookstatus"
		var orderString="state,org_city"
		var pageCount = 0
		var perpageCount = 10000000
		var returnAsString = "query"
		var selectString = ""

		if ( isdefined("params.status") ) {
			whereString = "status='#params.status#'"
		} else if ( isdefined("params.state") ) {
			whereString = whereString & " AND state_mail_abbrev = '#params.state#'"
			request.showpagination = false
		} else if ( isDefined("params.district") AND isDefined("params.membersonly") ) {
			includeString = includeString & ",handbookdistrict"
			whereString = whereString & " AND districtid = #params.district# AND statusID = 1"			
			request.showpagination = false
		} else if ( isDefined("params.district") ) {
			includeString = includeString & ",handbookdistrict"
			whereString = whereString & " AND districtid = #params.district# AND statusID = 1"			
			request.showpagination = false
		} else if ( isDefined("params.format") and params.format is "json" ) {
			returnAsString = "structs"
			selectString = "name,org_city,listed_as_city,meetingplace,state,id,address1,address2,phone,email,website,fname"
		} else {
			pageCount = params.page
			perpageCount = 50
		}

		handbookorganizations = model("Handbookorganization").findAll(
			select=selectString, 
			where=whereString, 
			include=includeString, 
			page=pageCount, 
			perPage=perPageCount, 
			order=orderString, 
			returnAs=returnAsString
			)

			renderWith(data=handbookorganizations)
		}

	<!--- handbook-organizations/show/key --->
	public function show( key=params.key ){
			handbookorganization = model("Handbookorganization").findByKey(key=params.key, include="Handbookstate,Handbookstatus,Handbookdistrict")
			tags=model("Handbooktag").findMyTagsForId(params.key,"organization")
			positions = model("Handbookperson").findall(where="organizationid='#params.key#' AND p_sortorder < #getNonStaffSortOrder()#", include="Handbookpositions,Handbookstate", order="p_sortorder,updatedAt")
	
			if ( !isObject(handbookorganization) ) {
				redirectTo(action="index", error="Handbookorganization #params.key# was not found")
			}
			
			if ( isDefined("params.ajax") ) { renderPartial("show") }
		}

	<!--- handbook-organizations/new --->
	public function new(){
			handbookorganization = model("Handbookorganization").new()
			handbookorganization = $createObjPropsFromParams(handbookorganization,params)
		}

	<!--- handbook-organizations/edit/key --->
	public function edit(key=params.key){
		handbookorganization = model("Handbookorganization").findByKey(key=arguments.key, include="handbookstate")
		if ( !IsObject(handbookorganization) ) {
			redirectTo(action="index", error="Handbookorganization #params.key# was not found")
		}
	}

	<!--- handbook-organizations/create --->
	private function create(newOrganization=params.handbookorganization){
		handbookorganization = model("Handbookorganization").new(arguments.newOrganization)
		if ( handbookorganization.save() ) {
			$updateNewChurchOrApplication(handbookorganization)
			redirectTo(action="index", success="The handbookorganization was created successfully.")
		} else {
			renderPage(action="new", error="There was an error creating the handbookorganization.")
		}
	}

		<!--- handbook-organizations/update --->
		function update(key=params.key){
			handbookorganization = model("Handbookorganization").findByKey(key=arguments.key, include="Handbookstate", order="selectname")
			if ( handbookorganization.update(params.handbookorganization)	){
				flashInsert(success="The handbookorganization was updated successfully.")
				returnBack()
			} else {
				renderPage(action="edit", error="There was an error updating the handbookorganization.")
			}
		}
	
		<!--- handbook-organizations/delete/key --->
		function delete() {
			handbookorganization = model("Handbookorganization").findByKey(key=params.key, include="handbookState")
			if ( handbookorganization.delete() ) {
				redirectTo(action="index", success="The handbookorganization was deleted successfully.")
			} else {
				redirectTo(action="index", error="There was an error deleting the handbookorganization.")
			}
		}

	<!------------------------>
	<!----- END OF CRUD ------>	
	<!------------------------>

	



	<!------------------------------------------>
	<!---Methods for Handbook Review Emailing--->
	<!------------------------------------------>

	public function handbookReviewOptions(reviewedBefore = dateAdd("d",1,now()),orderby="id",go=false,refresh=true){
		args = $$useParamsForDefaults(params,arguments);
		if (args.refresh){
			session.churches = [];
			session.churches = model("Handbookorganization").findChurchesForEmailing(reviewedBefore='#args.reviewedBefore#',go="true",orderby=args.orderby);
		}
		churches=session.churches;
		testchurches = model("Handbookorganization").findChurchesForEmailing(reviewedBefore='#args.reviewedBefore#',go="false",orderby=args.orderby);
		renderPage(layout="/handbook/layout_handbook2");
	}

	public function EmailChurchesForHandbookReview(){
		allemails = "";
		i=0;
		if (!isDefined("session.churches")){redirectTo(action="handbookReviewOptions")}
		if (isDefined("params.go") && params.go){
				churches = session.churches;
			}
			else {
				churches = model("Handbookorganization").findChurchesForEmailing();
			}
		for (i=1; i LTE arrayLen(churches); i=i+1){
			if ( !isLocalMachine() ){
				sendEmail(to=churches[i].email, from=getHandbookReviewSecretary(), subject="Charis Fellowship Handbook Review", template="emailChurchesForUpdates.cfm", layout="/layout_for_email");
			}
			allemails = allemails & "; " & churches[i].email;
		};
		allemails = replace(allemails,"; ","","one");
		i = arrayLen(churches);
		structDelete(session,"churches");
		renderPage(template="emailChurchesForHandbookReviewReport", layout="/handbook/layout_handbook2");
	}

	public function removeChurchFromSessionArray(item){
		ArrayDeleteAt(session.churches,item);
		redirectTo(action="handbookReviewOptions", params="refresh=false");
	}
	
	private object function BirthDayAnniversary(required numeric personid) {
		var loc = structNew();
		loc.profile = model("Handbookprofile").findOne(where="personid = #arguments.personid#");
		if ( isObject(loc.profile) ) {
			loc.return.birthday = dateformat(loc.profile.birthday,"medium");
			loc.return.anniversary = dateformat(loc.profile.anniversary,"medium");
		} else {
			loc.return.birthday = "?";
			loc.return.anniversary = "?";
		}
		return loc.return;
	}
	
<!------------------------------------------------->
<!---END OF Methods for Handbook Review Emailing--->
<!------------------------------------------------->





<!---------------------->
<!---Various Reports"--->
<!---------------------->

	<!--------handbookDownloadguidelines	GET	/handbook/downloadguidelines----------->
	function downloadguidelines(){
		renderPage(layout="/handbook/layout_handbook1")
	}

	<!---handbookDownloadmembers	GET	/handbook/organizations/downloadmemberchurches--->
	function downloadMemberChurches(){
		var whereString = "statusid = 1"
		var includeString = "Handbookstate,Handbookdistrict,Handbookstatus"
		var orderString = "state_mail_abbrev,org_city,name"
		if ( isDefined("params.include") && params.include is "campuses" ){
			whereString = whereString & " OR statusid = 8 OR statusid = 9"
		} else if ( isDefined("params.include") && params.include is "campusesandnewchurches" ) {
			whereString = whereString & " OR statusid = 8 OR statusid = 2 OR statusid = 9"
		}
		churches = model("Handbookorganization").findAll(where=wherestring, include=includeString, order=orderString)
		memberChurches = churches
		$setDownloadLayout()
	}

	public function memberChurches(){
		//used for annual delegates report of member churches
		var statNotesArray = []
		var whereString = "statusid = 1"
		var includeString = "Handbookstate"
		var orderString = "state_mail_abbrev,org_city,name"
		churches = model("Handbookorganization").findall(where=whereString, include=includeString, order=orderString)
		for ( church in churches ) {
			arrayAppend(statNotesArray,$addStatNote(church.id))
		}
		queryAddColumn(churches,"statNote",statNotesArray)
		renderPage(layout="/handbook/layout_admin")
	}

	<!---Handbook Pages--->
	public function handbookpages(key){
		// throw(message = serialize(params))
		if ( isDefined("params.orgid") ) { params.key = params.orgid }
		if ( isDefined("params.move") ) { $move() }
		organization = model("Handbookorganization").findByKey(key=params.key, include="Handbookstate,Handbookstatus,Handbookdistrict")
		$reSort(arguments.key)
		var whereString = "organizationid='#params.key#' AND position NOT LIKE '%Removed%' AND position NOT LIKE '%AGBM Only%'"
		if ( !isDefined("params.showall") ) {
			whereString = whereString & " AND p_sortorder < #getNonStaffSortOrder()#"
		}

		var orderString = "p_sortorder,lname"		
		if ( isDefined("params.sortByLname") ) {
			orderString = "lname,fname,p_sortorder"
		}

		var includeString = "Handbookpositions,Handbookstate"
		positions = model("Handbookperson").findall(where=whereString, include=includeString, order=orderString)

		positionsAlpha = model("Handbookperson").findall(where=whereString, include=includeString, order="lname,fname")

		if ( positions.recordcount ) {
			newSortOrder = positions.p_sortorder + 1
		}

		renderPage(layout="/Handbook/layout_handbook2")

	}

	public function websites(){
		var whereString = "website IS NOT NULL AND website <> ' ' AND statusid IN '1,4,2,8,9,10,11,12'"
		var selectString = "id, website, selectName"
		var maxrows = 999999999999
		var order = "selectName"
		var includeString = "State"
		if ( isLocalMachine() ) { maxrows = 1000 }
		websites = model("Handbookorganization").findAll(
			where = whereString,
			select = selectString,
			include = includeString,
			maxrows = maxrows,
			order = order
			)
	}

	<!--- handbookUpdatelinks	GET	/handbook/organization/updatelinks --->
	function updateLinks(){
		var whereString = "p_sortorder = 1 AND statusid IN (1,8,9,2)"
		if ( isDefined("params.reviewedAfter") ) {
			wherestring = whereString & " AND reviewedAt > '#params.reviewedafter#'"
		} elseif ( isDefined("params.reviewedBefore") ) {
			wherestring = whereString & " AND reviewedAt < '#params.reviewedBefore#'"
		} elseif ( isDefined("params.reviewedAt") ) {
			wherestring = whereString & " AND reviewedAt = '#params.reviewedAt#'"
		} elseif ( isDefined("params.ministries") ) {
			wherestring = "p_sortorder = 1 AND statusid IN (10,11)"
		}
		organizations = model("Handbookorganization").findall(where=wherestring, order="state, org_city", include="Positions(Handbookperson),Handbookstate")
		$setDownloadLayout()
	}

	public function yellowPages() {
		var whereString = "statusid IN (1,2,8) AND (p_sortorder IS NULL OR positiontypeid = 32 OR (p_sortorder > 0 AND p_sortorder < #getNonStaffSortOrder()#))"
		if ( isDefined("params.key") ) {
			whereString = "id = #params.key#"
		}
		var orderString = "state,listed_as_city,name,p_sortorder"
		var includeString = "ListeAsState,Positions(Handbookperson)"
		churches = model("Handbookorganization").findAll(where=whereString, include=includeString, order=orderString)
		if ( isDefined("params.noFormat") ) {
			renderPage(layout="/layout_naked", hideDebugInformation="true")
		} else {
			renderPage(layout="/handbook/layout_handbook")
		}
	}

	function prayerlist(){
		churches = model("Handbookorganization").findAll(where="statusid IN (1,4,8,9)", include="Handbookstate", order="rand()")
		weeks = 50
		churchesPerWeek = round(churches.recordcount/weeks)+1
	}

	function groupRoster(orderBy="createdAt"){
		if ( isdefined("params.sortby") ) { arguments.orderBy = params.sortBy }
		var whereString = "(ingrouproster <> 'no' AND ingrouproster IS NOT NULL) AND statusid IN (1,2,10,11,12)"
		if ( isDefined("params.search") ) { whereString = whereString & " AND (selectname LIKE '%#params.search#%' OR fein = '#params.search#')" }
		// throw(message=whereString)
		rosterChurches = model("Handbookorganization").findAll(where= whereString, include="State", order="#arguments.orderBy#")
		renderPage(layout="/handbook/layout_handbook2")
	}
	
<!----------------------------->
<!-----------END OF REPORTS --->
<!----------------------------->






<!----------------------------->
<!------Utilities-------------->	
<!----------------------------->

	<!---Used by "new" function--->
	private function $createObjPropsFromParams(required struct obj, required struct params) {
		for (item in StructKeyArray(params)) {
			obj[item] = params[item]
		}
		return obj
	}

	private function $updateNewChurchOrApplication(required object handbookorganization){
		if ( isDefined("handbookorganization.applicationUUID") ) {
			$connectApplicationToHandbook(handbookorganization.applicationUUID,handbookorganization.id)
		}
		if ( isDefined("handbookorganization.newchurchUUID") ) {
			$connectNewChurchToHandbook(handbookorganization.newchurchUUID,handbookorganization.id)			
		}
	}	

	private function $connectApplicationToHandbook(applicationUUID, handbookId){
		var loc = arguments;
		loc.application = model("Membershipapplication").findApp(loc.applicationUUID);
		loc.application.handbookid = loc.handbookid;
		if (loc.application.update()){
			return true;
		}	
		else {
			return false;
		}
	}

	private function $connectNewChurchToHandbook(newchurchUUID, handbookId){
		var loc = arguments;
		loc.newchurch = model("Membershipnewchurch").findOne(where="uuid='#loc.newchurchUUID#'");
		loc.newchurch.handbookid = loc.handbookid;
		if (loc.newchurch.update()){
			return true;
		}
		else {
			return false;
		}
	}

	function $getSeniorPastorEmail(required numeric churchid){
		var whereString = "organizationid=#arguments.churchid# AND p_sortorder=1"
		var includeString = "Handbookperson,Handbookorganization(Handbookstate)"
		pastor = model("Handbookposition").findAll(where=whereString, include=includeString)
		if ( pastor.recordcount and len(pastor.email) ) {
			return pastor.email			
		}
		return ""
	}

	function $getLastAtt(required numeric churchid) {
		var lastAtt = model("Handbookstatistic").findLastAtt(arguments.churchid)
		return lastAtt
	}

	<!---handbookDownloadMemberChurchesForBrotherhood	GET	/handbook/organizations/brotherhood--->
	function downloadMemberChurchesForBrotherhood(){
		var whereString = "statusId in (1,2,8,9,10,11)"
		var includeString = "Handbookstate,Handbookdistrict,Handbookstatus"
		memberChurches = model("Handbookorganization").findAll(where=whereString,include=includeString)
		$setDownloadLayout()
	}

	function $addStatNote(required numeric churchid, year=year(now())-1){
		if ( isDefined("params.year") ) { arguments.year = params.year }
		var stat = model("Handbookstatistic").findOne(where="organizationid = #arguments.churchid# AND year = '#arguments.year#'")
		if ( isObject(stat) ) {
			return stat.att & "/" & stat.members
		}
		return '*'
	}

	//used by handbookpages view to reorder staff in an organization
	public function $move(
		thisId=params.positionId,
		thisSortorder=params.sortOrder,
		otherId=params.otherId,
		otherSortorder=params.otherSortorder,
		orgId=params.orgid
	){

		model("Handbookperson").swapSortorder(
			thisid = #arguments.thisid#,
			thisSortorder = #arguments.thisSortOrder#,
			otherid = #arguments.otherid#,
			othersortorder = #arguments.othersortorder#
			)

			redirectTo(controller="handbook.organizations", action="handbookpages", key=arguments.orgid, params="orgid=#arguments.orgid#")	
	}

	function $getNextPosition(required numeric positionid){
		var watch = 0
		var position
		var nextposition = {}
		for ( position in positions ) {
			if ( watch ) {
				nextposition.id = position.handbookpositionid
				nextposition.sortorder = position.p_sortorder
				return nextPosition
			}
			if ( position.handbookpositionid IS arguments.positionid ) {
				watch = 1
			}
		}
		return false
	}

	<!---Removes any gaps in staff sortorders--->
	function $reSort(orgId){
		if ( isDefined('params.orgid') ) { orgid = params.orgid }
		else if ( isDefined('params.key') ) { orgid = params.key }
		return model("Handbookperson").resort(arguments.orgid)		
	}
		
	function $getPreviousPerson(required numeric personId,required numeric organizationId){
		staff = model("Handbookperson").findOne(where="id=#arguments.personid#")
		previousstaff = model("Handbookperson").findAll(where="sortorder = #staff.sortoder-1# AND organizationid = #arguments.organizationid#", include="Handbookpositions,Handbookstate")
	}

	public function notStaff(){
		var loc = arguments;
		loc.positionid = params.key;
		loc.personid = model("Handbookposition").findOne(where="id=#loc.positionid#").personid;
		loc.isAgbmMember = model("Handbookagbminfo").isAgbmMember(loc.personid);
		loc.isAgbm = isAgbm(loc.personid);
		if (loc.isAgbmMember || loc.isAGBM){
			loc.position = "AGBM Only";
			loc.positiontypeid = 32 //position type 32 is AGBM Only - position type does not show in handbook
		}
		else {
			loc.position = "Removed From Staff";
			loc.positiontypeid = 13 //position type 13 is 'later'
		};
		model("Handbookorganization").removeFromStaff(loc.positionid, loc.position, loc.positiontypeid);
		redirectTo(back=true);
	}

	function setReview(organizationId=params.key){
		if ( session.auth.email NEQ "tomavey@fgbc.org" && session.auth.email NEQ "tomavey@charisfellowship.us" ){
			var organization = model("Handbookorganization").findOne(where="id=#arguments.organizationid#", include="Handbookstate")
			if ( !len(organization.updatedBy) ) {
				organization.updatedBy = session.auth.email
			}
			organization.reviewedAt = now()
			organization.reviewedBy = session.auth.email
			organization.update()
		}
		returnBack()
	}

	private function $$hasNoStaff(require numeric churchId){
		var check = model("Handbookposition").findOne(where="p_sortorder < #getNonStaffSortOrder()# AND organizationid = #arguments.churchid#")
		if ( !isObject(check) ) {
			return false
		}
		return true
	}
	
	function setPrayerDates(){
		model("Handbookorganization").setPrayerDates()
		organizations = model("Handbookorganization").findAll(where="statusid IN (1,4,8,9,10,11)", include="Handbookstate", order="pray_for_week_of_year")
	}

	function distribution(){
		distribution = model("Handbookorganization").findall(where="statusid IN (1,2,4,8,9)", include="Handbookstate", order="state_mail_abbrev,org_city")
		$setDownloadLayout()
	}
	
	function getAtt(require numeric churchId){
		att = model("Handbookstatistic").findLastAtt(#arguments.churchid#)
		return att
	}

<!---------------------------->
<!-------END OF UTILITIES ---->
<!---------------------------->



<!---------------------------->
<!-------JSON REPORTS--------->	
<!---------------------------->
	
	function json(){
		renderPage(layout="/layout_json.cfm")
	}
	
	function findChurches(){
		orgs = model("Handbookorganization").findChurchesAsJson()
		renderPage(layout="/layout_json", template="json", hideDebugInformation=true)
	}

	function findMinistries(){
		orgs = model("Handbookorganization").findMinistriesAsJson(returnAs="structs")
		renderPage(layout="/layout_json", template="json", hideDebugInformation=true)
	}

	function findChurchWithStaff(){
		orgs = model("Handbookorganization").findChurchWithStaffAsJson(params.key)
		if ( get("environment") is "production" ) {
			set(environment="production")
		}
		renderPage(layout="/layout_json", template="json", hideDebugInformation=true)
	}


<!---------------------------->
<!------Abstracted Settings--->	
<!---------------------------->

	function showStaffList(required numeric orgId){
		return true
	}

	
}

