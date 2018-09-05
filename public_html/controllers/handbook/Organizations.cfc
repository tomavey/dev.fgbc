<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
		<cfset usesLayout("/handbook/layout_handbook")>
		<cfset filters(through="gotBasicHandbookRights,logview", except="memberChurches,findChurches,findChurchWithStaff,groupRoster")>
		<!---
		<cfset filters(through="isOnStaffHere", except="index,show,handbookpages,edit,new,notStaff,resort,move")>
		--->
		<cfset filters(through="getStates,getDistricts,getStatus", only="new,edit,update,index,create,downloadguidelines")>
		<cfset filters(through="noShowString,getGroupRosterOptions", only="new,edit")>
		<cfset provides("json")>
	</cffunction>

<!---Filters--->
	<cffunction name="getStates">
		<cfset states = model("Handbookstate").findall(order="state")>
	</cffunction>

	<cffunction name="getDistricts">
		<cfset districts = model("Handbookdistrict").findall(order="district")>
	</cffunction>

	<cffunction name="getStatus">
		<cfset status = model("Handbookstatus").findall(order="status")>
	</cffunction>

	<cffunction name="isOnStaffHere">
	<cfset var loc=structNew()>
	<cfset loc.return = false>

	<cfif gotRights("superadmin,office")>
		  <cfset loc.return = true>
	</cfif>

	<cfif isDefined("session.auth.handbook.review") and session.auth.handbook.review>
		  <cfset loc.return = true>
	</cfif>

	<cfif isDefined("params.key") and isDefined("session.auth.handbook.organizations") and find(params.key,session.auth.handbook.organizations)>
		  <cfset loc.return = true>
	</cfif>

	<cfif loc.return>
	<cfelse>
		  <cfset renderText("You do not have permission to view this page")>
	</cfif>
	</cffunction>

	<cffunction name="NoShowString">
		<cfset var NoShow = model("Handbookstatus").findall(where="show_in_handbook = 0")>
		<cfset NoShowString = "">
		<cfloop query="NoShow">
			<cfset NoShowString = NoShowString & ", " & status>
		</cfloop>
		<cfset noShowString = replace(NoShowString,", ","","one")>
	</cffunction>

	<cffunction name="getGroupRosterOptions">
		<cfset groupsRosterOptions = "Yes,No,#year(now())#">
	</cffunction>

<!---Basic CRUD--->

	<!--- handbook-organizations/index --->
	<cffunction name="index">
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

	<!--- handbook-organizations/show/key --->
	<cffunction name="show">

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

	<cffunction name="showInPanel">

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

	<!--- handbook-organizations/new --->
	<cffunction name="new">
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

	<!--- handbook-organizations/edit/key --->
	<cffunction name="edit">

		<!--- Find the record --->
    	<cfset handbookorganization = model("Handbookorganization").findByKey(key=params.key, include="handbookstate")>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(handbookorganization)>
	        <cfset flashInsert(error="Handbookorganization #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

	<!--- handbook-organizations/create --->
	<cffunction name="create">
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

	<cffunction name="$updateNewChurchOrApplication">
	<cfargument name="handbookorganization" required="true" type="object">
		<cfif isDefined("handbookorganization.applicationUUID")>
			<cfset $connectApplicationToHandbook(handbookorganization.applicationUUID,handbookorganization.id)>
		</cfif>		
		<cfif isDefined("handbookorganization.newchurchUUID")>
			<cfset $connectNewChurchToHandbook(handbookorganization.newchurchUUID,handbookorganization.id)>
		</cfif>		
	</cffunction>

<cfscript>

<!---Methods for Handbook Review Emailing--->

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
		sendEmail(to=churches[i].email, from=getHandbookReviewSecretary(), subject="FGBC Handbook Review", template="emailChurchesForUpdates.cfm", layout="/layout_for_email");
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

</cfscript>


	<!--- handbook-organizations/update --->
	<cffunction name="update">

		<cfset handbookorganization = model("Handbookorganization").findByKey(key=params.key, include="Handbookstate", order="selectname")>

		<!--- Verify that the handbookorganization updates successfully --->
		<cfif handbookorganization.update(params.handbookorganization)>
			<cfset flashInsert(success="The handbookorganization was updated successfully.")>
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the handbookorganization.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>

	<!--- handbook-organizations/delete/key --->
	<cffunction name="delete">
		<cfset handbookorganization = model("Handbookorganization").findByKey(key=params.key, include="handbookState")>

		<!--- Verify that the handbookorganization deletes successfully --->
		<cfif handbookorganization.delete()>
			<cfset flashInsert(success="The handbookorganization was deleted successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the handbookorganization.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>

<!---Variations on "show"--->

	<cffunction name="mychurch">
		<cfset myChurches = model("handbookPerson").findAll(where="email='#params.key#' AND sortorder < 900", include="Handbookstate,Handbookpositions")>
		<cfloop query="myChurches">
			<cfset myChurch[mychurches.currentrow] = model("handbookOrganization").findall(where="Id = #organizationId#", include="handbookState")>
		</cfloop>
		<cfdump var="#myChurches#">
	<cfdump var="#myChurch#"><cfabort>

	</cffunction>">

	<!--------handbookDownloadguidelines	GET	/handbook/downloadguidelines----------->
	<cffunction name="downloadguidelines">
		<cfset renderPage(layout="/handbook/layout_handbook1")>
	</cffunction>


<!---Downloads--->
	<!---handbookDownloadmembers	GET	/handbook/organizations/downloadmemberchurches--->
	<cffunction name="downloadMemberChurches">
		<cfset memberChurches = model("Handbookorganization").findAll(where="statusId in (1,8,9)",include="Handbookstate,Handbookdistrict,Handbookstatus")>
		<cfset setDownloadLayout()>
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

	<cffunction name="addStatNote">
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

		<cfset whereString = "organizationid='#params.key#' AND p_sortorder < #getNonStaffSortOrder()# AND position NOT LIKE '%Removed%'">
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

	<cffunction name="move">
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

	<cffunction name="getNextPosition">
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

	<cffunction name="resort"><!---Removes any gaps in staff sortorders--->
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

	<cffunction name="getPreviousPerson">
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
		loc.positiontypeid = 32
	}
	else {
		loc.position = "Removed From Staff";
		loc.positiontypeid = 13
	};
	model("Handbookorganization").removeFromStaff(loc.positionid, loc.position, loc.positiontypeid);
	redirectTo(back=true);
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
	<cfdump var="#params#"><cfabort>
	<cfargument name="organizationId" default="#params.key#">
	<cfif session.auth.email NEQ "tomavey@fgbc.org">
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
			<cfset renderPage(layout="/handbook/layout_handbook1")>
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
		<cfset rosterChurches = model("Handbookorganization").findAll(where="ingrouproster <> 'no' OR ingrouproster IS NOT NULL", include="State")>
		<cfset renderPage(layout="/handbook/layout_handbook2")>
	</cffunction>

</cfcomponent>


