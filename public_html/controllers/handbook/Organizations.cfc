<cfcomponent extends="Controller" output="false">

<cfscript>

	function init(){
		usesLayout("/handbook/layout_handbook")
		filters(through="gotBasicHandbookRights,logview", except="memberChurches,findChurches,findChurchWithStaff,groupRoster")
		filters(through="getStates,getDistricts,getStatus", only="new,edit,update,index,create,downloadguidelines")
		filters(through="setWillNotShowString,getGroupRosterOptions", only="new,edit")
		filters(through="setReturn", only="show")
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
<!-------Basic CRUD------->	
<!------------------------>

	<!--- handbook-organizations/index --->
	public function index(){
		param name="params.page" default="1";
		request.showpagination = true
		if ( isDefined("params.page") ) { page=params.page }
		states = model("Handbookorganization").findStatesWithOrganizations()

		whereString = "show_in_handbook = 1"
		includeString="handbookstate,handbookstatus"
		orderString="state,org_city"
		pageCount = 0
		perpageCount = 10000000
		returnAsString = "query"
		selectString = ""

		if ( isdefined("params.status") ) {
			whereString = "status='#params.status#'"
		} else if ( isdefined("params.state") ) {
			whereString = whereString & " AND state_mail_abbrev = '#params.state#'"
			request.showpagination = false
		} else if ( isDefined("params.district") AND isDefined("params.membersonly") ) {
			includeString = includeString & ",handbookdistrict"
			request.showpagination = false
		} else if ( isDefined("params.district") ) {
			includeString = includeString & ",handbookdistrict"
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

	private function $updateNewChurchOrApplication(required object handbookorganization){
		if ( isDefined("handbookorganization.applicationUUID") ) {
			$connectApplicationToHandbook(handbookorganization.applicationUUID,handbookorganization.id)
		}
		if ( isDefined("handbookorganization.newchurchUUID") ) {
			$connectNewChurchToHandbook(handbookorganization.newchurchUUID,handbookorganization.id)			
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
			sendEmail(to=churches[i].email, from=getHandbookReviewSecretary(), subject="Charis Fellowship Handbook Review", template="emailChurchesForUpdates.cfm", layout="/layout_for_email");
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

	<!------------------------------------>

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
		} else if ( isDefined("params.include") && params.include is "campuses" ) {
			whereString = whereString & " OR statusid = 8 OR statusid = 2 OR statusid = 9"
		}
		churches = model("Handbookorganization").findAll(where=wherestring, include=includeString, order=orderString)
		memberChurches = churches
		renderPage(layout="/handbook/layout_admin")
	}


</cfscript>




<!---Downloads--->

	<cffunction name="$getSeniorPastorEmail">
		<cfargument name="churchid" required="true" type="numeric">
		<cfset var loc=structNew()>
		<cfset loc.return = "">
			<cfset pastor = model("Handbookposition").findAll(where="organizationid=#arguments.churchid# AND p_sortorder=1", include="Handbookperson,Handbookorganization(Handbookstate)")>
			<cfif pastor.recordcount and len(pastor.email)>
				<cfset loc.return = pastor.email>
			</cfif>
		<cfreturn loc.return>
	</cffunction>

	<cffunction name="$getLastAtt">
	<cfargument name="churchid" required="true" type="numeric">
	<cfset var loc= structNew()>
		<cfset loc.lastAtt = model("Handbookstatistic").findLastAtt(arguments.churchid)>
		<cfreturn loc.lastatt>
	</cffunction>


	<!---handbookDownloadMemberChurchesForBrotherhood	GET	/handbook/organizations/brotherhood--->
	<cffunction name="downloadMemberChurchesForBrotherhood">
		<cfset memberChurches = model("Handbookorganization").findAll(where="statusId in (1,2,8,9,10,11)",include="Handbookstate,Handbookdistrict,Handbookstatus")>
		<cfset setDownloadLayout()>
	</cffunction>

<!---Reports--->
	<cffunction name="memberChurches">
		<cfset churches = model("Handbookorganization").findall(where="statusid = 1", include="Handbookstate", order="state_mail_abbrev,org_city,name")>
		<cfset renderPage(layout="/handbook/layout_admin")>
	</cffunction>

	<cffunction name="$addStatNote">
	<cfargument name="churchid" required="true" type="numeric">
	<cfset var loc=structNew()>
		<cfset loc.stat = model("Handbookstatistic").findOne(where="organizationid = #arguments.churchid# AND year = '#year(now())-1#'")>
		<cftry>
			<cfset loc.return = loc.stat.att & "/" & loc.stat.members>
		<cfcatch>
			<cfset loc.return = '*'>
		</cfcatch>
		</cftry>
		<cfreturn loc.return>
	</cffunction>

	<cffunction name="handbookpages">
		<cfset setReturn()>

    <cfset organization = model("Handbookorganization").findByKey(key=params.key, include="Handbookstate,Handbookstatus,Handbookdistrict")>

		<cfset reSort(params.key)>

		<cfset whereString = "organizationid='#params.key#' AND position NOT LIKE '%Removed%' AND position NOT LIKE '%AGBM Only%'">

		<cfif !isDefined("params.showall")>
			<cfset whereString = whereString & " AND p_sortorder < #getNonStaffSortOrder()#">
		</cfif>

		<cfset orderString = "p_sortorder,lname">

		<cfif isDefined("params.sortByLname")>
			<cfset orderString = "lname,fname,p_sortorder">
		</cfif>

		<cfset positions = model("Handbookperson").findall(where=whereString, include="Handbookpositions,Handbookstate", order=orderString)>

		<cfset positionsalpha = model("Handbookperson").findall(where=whereString, include="Handbookpositions,Handbookstate", order="lname,fname")>

		<cfif positions.recordcount>
		   <cfset newSortOrder = positions.p_sortorder + 1>
		</cfif>

		<cfset renderPage(layout="/Handbook/layout_handbook2")>
	</cffunction>

	<cffunction name="$move">
	<cfargument name="thisId" default="#params.positionid#">
	<cfargument name="thisSortorder" default="#params.sortorder#">
	<cfargument name="otherId" default="#params.otherId#">
	<cfargument name="otherSortorder" default="#params.otherSortorder#">
	<cfargument name="orgid" default="#params.orgid#">

	<cfset move = model("Handbookperson").swapSortorder(
		   thisid = #arguments.thisid#,
		   thisSortorder = #arguments.thisSortOrder#,
		   otherid = #arguments.otherid#,
		   othersortorder = #arguments.othersortorder#
		   )>

		<cfset redirectTo(back=true)>
	</cffunction>

	<cffunction name="$getNextPosition">
	<cfargument name="positionid" required="true" type="numeric">
	<cfset var watch = 0>
	<cfloop query="positions">
		<cfif watch>
			  <cfset nextposition.id = handbookpositionid>
			  <cfset nextposition.sortorder = p_sortorder>
			  <cfreturn nextposition>
		</cfif>
		<cfif handbookpositionid is arguments.positionid>
			  <cfset watch = 1>
		</cfif>
	</cfloop>
	<cfreturn false>

	</cffunction>

	<cffunction name="$resort"><!---Removes any gaps in staff sortorders--->
	<cfargument name="orgid" default="#params.orgid#">
		<cfset staff = model("Handbookperson").findAll(where="p_sortorder < #getNonStaffSortOrder()# AND organizationid = #arguments.orgid#", include="Handbookpositions,Handbookstate", cache=false, order="p_sortorder, updatedAt")>
		<cfloop query="staff">
			<cfquery datasource="fgbc_main_3" result="res">
    			UPDATE handbookpositions
    			SET p_sortorder = #currentrow#
    			WHERE personid = #id#
    				AND organizationid = #organizationid#
			</cfquery>
		</cfloop>
		<cfreturn true>
	</cffunction>

	<cffunction name="$getPreviousPerson">
	<cfargument name="personid" required="true" type="numeric">
	<cfargument name="organizationid" required="true" type="numeric">
		<cfset staff = model("Handbookperson").findOne(where="id=#arguments.personid#")>
		<cfset previousstaff = model("Handbookperson").findAll(where="sortorder = #staff.sortoder-1# AND organizationid = #arguments.organizationid#", include="Handbookpositions,Handbookstate")>

	</cffunction>

<cfscript>

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

</cfscript>

	<cffunction name="testReSort">
	<cfargument name="organizationid" default="#params.key#">
		<cfset test = reSort(arguments.organizationid)>
	</cffunction>

	<!--- handbookUpdatelinks	GET	/handbook/organization/updatelinks --->
	<cffunction name="updateLinks">
		<cfif isDefined("params.reviewedAfter")>
			<cfset wherestring = "p_sortorder = 1 AND statusid IN (1,8,9,2) AND reviewedAt > '#params.reviewedafter#'">
		<cfelseif isDefined("params.reviewedBefore")>
			<cfset wherestring = "p_sortorder = 1 AND statusid IN (1,8,9,2) AND reviewedAt < '#params.reviewedbefore#'">
		<cfelseif isDefined("params.reviewedAt")>
			<cfset wherestring = "p_sortorder = 1 AND statusid IN (1,8,9,2) AND reviewedAt < '#params.reviewedAt#'">
		<cfelseif isDefined("params.ministries")>
			<cfset wherestring = "p_sortorder = 1 AND statusid IN (10,11)">
		<cfelse>
			<cfset wherestring = "p_sortorder = 1 AND statusid IN (1,8,9,2)">
		</cfif>
		<cfset organizations = model("Handbookorganization").findall(where=wherestring, order="state, org_city", include="Positions(Handbookperson),Handbookstate")>

		<cfif isDefined("params.download")>
			<cfset renderPage(layout="/layout_download")>
		<cfelse>
			<cfset renderPage(layout="/layout_naked")>
		</cfif>
	</cffunction>

	<cffunction name="setReview">
	<cfargument name="organizationId" default="#params.key#">
	<cfif session.auth.email NEQ "tomavey@fgbc.org" && session.auth.email NEQ "tomavey@charisfellowship.us" >
    	<cfset organization = model("Handbookorganization").findOne(where="id=#arguments.organizationid#", include="Handbookstate")>
		<cfif NOT len(organization.updatedBy)>
			  <cfset organization.updatedBy = session.auth.email>
		</cfif>
    	<cfset organization.reviewedAt = now()>
    	<cfset organization.reviewedBy = session.auth.email>
    	<cfset test = organization.update()>
	</cfif>
		<cfset returnBack()>
	</cffunction>

	<cffunction name="yellowpages">
		<cfif isDefined("params.key")>
			<cfset whereString = "id = #params.key#">
		<cfelse>
			<cfset whereString = "statusid IN (1,2,8)">
		</cfif>

		<cfset orderString = "state,listed_as_city,name,p_sortorder">

		<cfset churches = model("Handbookorganization").findAll(where=whereString, include="ListeAsState,Positions(Handbookperson)", order=orderString)>

		<cfquery dbType="query" name="churches">
			SELECT * from churches
			WHERE p_sortorder IS NULL OR 
				positiontypeid = 32 OR 
				(p_sortorder > 0 AND p_sortorder < #getNonStaffSortOrder()#)
		</cfquery>

		<cfif isDefined("params.noFormat")>
			<cfset renderPage(layout="/layout_naked", hideDebugInformation="true")>
		<cfelse>
			<cfset renderPage(layout="/handbook/layout_handbook")>
		</cfif>
	</cffunction>

	<cffunction name="hasNoStaff">
	<cfargument name="churchId" required="true" type="numeric">
	<cfset var loc = structNew()>

	<cfset loc.check = model("Handbookposition").findOne(where="p_sortorder < #getNonStaffSortOrder()# AND organizationid = #arguments.churchid#")>

	<cfif isObject(loc.check)>
		<cfreturn false>
	<cfelse>
		<cfreturn true>
	</cfif>

	</cffunction>

	<cffunction name="prayerlist">
	<cfset churches = model("Handbookorganization").findAll(where="statusid IN (1,4,8,9)", include="Handbookstate", order="rand()")>
	<cfset weeks = 50>
	<cfset churchesPerWeek = round(churches.recordcount/weeks)+1>
	</cffunction>

	<cffunction name="setPrayerDates">
		<cfset model("Handbookorganization").setPrayerDates()>
		<cfset organizations = model("Handbookorganization").findAll(where="statusid IN (1,4,8,9,10,11)", include="Handbookstate", order="pray_for_week_of_year")>
	</cffunction>

	<cffunction name="distribution">
		<cfset distribution = model("Handbookorganization").findall(where="statusid IN (1,2,4,8,9)", include="Handbookstate", order="state_mail_abbrev,org_city")>
		<cfif isDefined("params.download")>
			<cfset renderPage(layout="/layout_download")>
		<cfelse>
			<cfset renderPage(layout="/layout_naked")>
		</cfif>
	</cffunction>

	<cffunction name="showparams">
		<cfloop collection="#params#" item="i">
			<cfdump var="#i#"><cfdump var="#params[i]#">
		</cfloop>
		<cfdump var="#params#"><cfabort>
	</cffunction>

	<cffunction name="getAtt">
	<cfargument name="churchid" required="true" type="numeric">
		<cfset att = model("Handbookstatistic").findLastAtt(#arguments.churchid#)>
		<cfreturn att>
	</cffunction>

	<cffunction name="speedDating">
	<cfset var loc= structNew()>
		<cfif isDefined("params.groupscount")>
			<cfset params.groups = structNew()>
			<cfloop from="1" to="#params.groupscount#" index="loc.session">
				<cfloop from="1" to="#params.groupscount#" index="loc.host">
					<cfloop from="1" to="#params.groupscount#" index="loc.guest">
						<cfif availableForSpeedDate(loc.host,loc.guest)>
							<cfset params.groups[loc.session][loc.host]=loc.guest>
						<cfbreak>
						</cfif>
					</cfloop>
				</cfloop>
			</cfloop>
		</cfif>
		<cfdump var="#params#"><cfabort>
		<cfset renderPage(layout="/handbook/layout_handbook2")>
	</cffunction>

	<cffunction name="availableForSpeedDate">
	<cfargument name="host" required="true" type="numeric">
	<cfargument name="guest" required="true" type="numeric">
	<cfset var loc= structNew()>
	<cfset loc = arguments>
	<cfset loc.return = true>
	<cfset loc.groups = params.groups>
	<cfset loc.groupscount = structCount(loc.groups)>
		<cfloop from="1" to="#loc.groupscount#" index="loc.session">
			<cftry>
				<cfif val(loc.groups[loc.session][loc.host]) EQ loc.guest OR val(loc.groups[loc.session][loc.guest]) EQ loc.host or loc.host EQ loc.guest>
					<cfset loc.return = false>
					<cfreturn loc.return>
				</cfif>
			<cfcatch></cfcatch></cftry>
		</cfloop>
	<cfreturn loc.return>
	</cffunction>

	<cffunction name="json">
		<cfset renderPage(layout="/layout_json.cfm")>
	</cffunction>

	<cffunction name="findChurches">
		<cfset orgs = model("Handbookorganization").findChurchesAsJson()>
		<cfset renderPage(layout="/layout_json", template="json", hideDebugInformation=true)>
	</cffunction>

	<cffunction name="findMinistries">
		<cfset orgs = model("Handbookorganization").findMinistriesAsJson(returnAs="structs")>
		<cfset renderPage(layout="/layout_json", template="json", hideDebugInformation=true)>
	</cffunction>

	<cffunction name="findChurchWithStaff">
		<cfset orgs = model("Handbookorganization").findChurchWithStaffAsJson(params.key)>
		<cfif get("environment") is "production">
		    <cfset set(environment="production")>
		</cfif>
		<cfset renderPage(layout="/layout_json", template="json", hideDebugInformation=true)>
	</cffunction>

	<cffunction name="showStaffList">
	<cfargument name="orgId" required="true" type="numeric">
	<cfreturn true>
	</cffunction>

	<cffunction name="groupRoster">
	<cfargument name="orderBy" default="createdAt">
	<!--- <cfif isDefined("") --->
		<cfset rosterChurches = model("Handbookorganization").findAll(where="ingrouproster <> 'no' OR ingrouproster IS NOT NULL", include="State", order="#arguments.orderBy#")>
		<cfset renderPage(layout="/handbook/layout_handbook2")>
	</cffunction>











	
<!---TRASH--->	
	<cffunction name="Xindex">
		<cfparam name="params.page" default="1">
		<cfset request.showpagination = true>
		<cfset states = model("Handbookorganization").findStatesWithOrganizations()>

		<cfset whereString = "show_in_handbook = 1">
		<cfset includeString="handbookstate,handbookstatus">
		<cfset orderString="state,org_city">
		<cfset pageCount = 0>
		<cfset perpageCount = 10000000>
		<cfset returnAsString = "query">
		<cfset selectString = "">

		<cfif isdefined("params.status")>
			<cfset whereString = "status='#params.status#'">
		<cfelseif isdefined("params.state")>
			<cfset whereString = whereString & " AND state_mail_abbrev = '#params.state#'">
		<cfelseif isDefined("params.district") AND isDefined("params.membersonly")>
			<cfset includeString = includeString & ",handbookdistrict">
			<cfset whereString = whereString & " AND districtid = #params.district# AND statusID = 1">
		<cfelseif isDefined("params.district")>
			<cfset includeString = includeString & ",handbookdistrict">
			<cfset whereString = whereString & " AND districtid = #params.district#">
		<cfelseif isDefined("params.format") and params.format is "json">
			<cfset returnAsString = "structs">
			<cfset selectString = "name,org_city,listed_as_city,meetingplace,state,id,address1,address2,phone,email,website,fname">
		<cfelse>
			<cfset pageCount = params.page>
			<cfset perpageCount = 50>
		</cfif>

		<cfset handbookorganizations = model("Handbookorganization").findAll(select=selectString, where=whereString, include=includeString, page=pageCount, perPage=perPageCount, order=orderString, returnAs=returnAsString)>

		<cfif isDefined("params.state")>
			<cfset request.showpagination = false>
		</cfif>
		<cfif isDefined("params.district")>
			<cfset request.showpagination = false>
		</cfif>

		<cfset renderWith(data=handbookorganizations)>

	</cffunction>

	<cffunction name="Xshow">

		<cfset setReturn()>
		<!--- Find the record --->
    	<cfset handbookorganization = model("Handbookorganization").findByKey(key=params.key, include="Handbookstate,Handbookstatus,Handbookdistrict")>
		<cfset tags=model("Handbooktag").findMyTagsForId(params.key,"organization")>
		<cfset positions = model("Handbookperson").findall(where="organizationid='#params.key#' AND p_sortorder < #getNonStaffSortOrder()#", include="Handbookpositions,Handbookstate", order="p_sortorder,updatedAt")>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(handbookorganization)>
	        <cfset flashInsert(error="Handbookorganization #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>

   		<cfif isdefined("params.ajax")>
			<cfset renderPartial("show")>
		</cfif>

	</cffunction>

	<cffunction name="XshowInPanel">

		<cfset setReturn()>
		<!--- Find the record --->
    	<cfset handbookorganization = model("Handbookorganization").findByKey(key=params.key, include="Handbookstate,Handbookstatus,Handbookdistrict")>
		<cfset tags=model("Handbooktag").findMyTagsForId(params.key,"organization")>
		<cfset positions = model("Handbookperson").findall(where="organizationid='#params.key#' AND p_sortorder < #getNonStaffSortOrder()#", include="Handbookpositions,Handbookstate", order="p_sortorder,lname")>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(handbookorganization)>
	        <cfset flashInsert(error="Handbookorganization #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>

		<cfset renderPartial("show")>

	</cffunction>

	<cffunction name="Xnew">
		<cfset handbookorganization = model("Handbookorganization").new()>
		<cfset var paramslist = structKeyList(params)>
		<cfset paramslist = replace(paramslist,"ROUTE,","")>
		<cfset paramslist = replace(paramslist,"CONTROLLER,","")>
		<cfset paramslist = replace(paramslist,"CONTROLLER","")>
		<cfset paramslist = replace(paramslist,"ACTION,","")>
		<cfset paramslist = replace(paramslist,"ACTION","")>
		<cfloop list="#paramslist#" index="i">
			<cfif isDefined("params[i]")>
				<cfset handbookorganization[i] = params[i]>
			</cfif>
		</cfloop>
	</cffunction>

	<cffunction name="Xedit">

		<!--- Find the record --->
    	<cfset handbookorganization = model("Handbookorganization").findByKey(key=params.key, include="handbookstate")>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(handbookorganization)>
	        <cfset flashInsert(error="Handbookorganization #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

	<cffunction name="Xcreate">
		<cfset handbookorganization = model("Handbookorganization").new(params.handbookorganization)>

		<!--- Verify that the handbookorganization creates successfully --->
		<cfif handbookorganization.save()>
			<cfset flashInsert(success="The handbookorganization was created successfully.")>
			<cfset $updateNewChurchOrApplication(handbookorganization)>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the handbookorganization.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>

	<cffunction name="XdownloadMemberChurches">
		<cfset memberChurches = model("Handbookorganization").findAll(where="statusId in (1,8,9)",include="Handbookstate,Handbookdistrict,Handbookstatus")>
		<cfset setDownloadLayout()>
	</cffunction>



</cfcomponent>


