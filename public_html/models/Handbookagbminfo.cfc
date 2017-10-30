<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset table("handbookagbminfo")>
		<cfset belongsTo(name="Handbookperson", foreignKey="personid")>
		<cfset hasMany(name="Handbookpositions", foreignKey="personid")>
	</cffunction>

	<cffunction name="getAgbm">
	<cfset var loc=structnew()>

		<cfquery datasource="#getDataSourceName()#" name="loc.return">
			SELECT p.lname, left(p.lname,1) as alpha, p.fname, o.name, p.address1, p.address2, p.city, p.zip, p.phone, p.email, district, d.districtid, ps.state_mail_abbrev as state, s.state_mail_abbrev as org_state, org_city, max(membershipfeeyear) as lastpayment, p.id as personid, o.id as organizationid, o.address1 as handbookorganizationaddress1, o.address2 as handbookorganizationaddress2, o.org_city, s.state_mail_abbrev as handbookorganizationstate, p.zip as handbookorganizationzip, o.statusid, region.name as regionname, region.id as regionid, regionrep.lname as regionreplname, regionrep.fname as regionrepfname, regionrep.id as regionrepid, ministrystartat
			FROM handbookpeople p
			JOIN handbookpositions t
			ON t.personid = p.id
			LEFT JOIN handbookprofiles profile
			ON profile.personid = p.id
			LEFT JOIN handbookorganizations o
			ON t.organizationid = o.id
			LEFT JOIN handbookdistricts d
			ON o.districtid = d.districtid
			LEFT JOIN handbookagbmregions region
			ON d.agbmregionid = region.id
			LEFT JOIN handbookpeople regionrep
			ON region.agbmrepid = regionrep.id
			JOIN handbookstates ps
			ON p.stateid = ps.id
			JOIN handbookstates s
			ON o.stateid = s.id
			JOIN handbookagbminfo i
			ON i.personid = p.id
			WHERE o.statusid IN (#application.wheels.churchStatusForHandbook#,5,2)
				AND t.p_sortorder <> 999
				AND p.deletedAt IS NULL
    			AND t.deletedAt IS NULL
    			AND o.deletedAt IS NULL
    			AND d.deletedAt IS NULL
    			AND i.deletedAt IS NULL
			GROUP BY p.id
			ORDER BY lname, fname, t.createdAt
		</cfquery>
		<cfreturn loc.return>
	</cffunction>

<cfscript>

public function getAllAgbm(maxrows = 100){
	var people = model("Handbookperson").findAll(select="id, fname, lname, selectName", include="State,Handbookpositions", maxrows=arguments.maxrows);
	var peopleStruct = queryToArray(people);
	return peopleStruct;
};

public function getAgbmMembers(maxrows = -1,orderby="lname", district="Arctic", search="", refresh=true){
	var loc = arguments;
	var i = 1;
	var ii = 1;
	var memberArray = [];
	if (loc.refresh){
		session.handbook.membersArray = [];
		session.handbook.membersArray = getAllAGBM(maxrows);	
	}
	loc.allpersons = session.handbook.membersArray;
	loc.allAgbmMembers = [];
	for (i=1; i LTE arrayLen(loc.allpersons); i=i+1){
		if (isAgbmMember(loc.allpersons[i].id)){
			loc.allAgbmMembers[ii] = loc.allpersons[i];
			loc.allAgbmMembers[ii].position = $getBestPersonPositionAsStruct(loc.allpersons[i].id);
			loc.allAgbmMembers[ii].district = $getBestPersonPositionAsStruct(loc.allpersons[i].id).district;
			loc.allAgbmMembers[ii].districtid = $getBestPersonPositionAsStruct(loc.allpersons[i].id).districtid;
			loc.allAgbmMembers[ii].church = $getBestPersonPositionAsStruct(loc.allpersons[i].id).church;
			loc.allAgbmMembers[ii].churchid = $getBestPersonPositionAsStruct(loc.allpersons[i].id).churchid;
			loc.allAgbmMembers[ii].membershipfees = $getMembershipFeeInfo(loc.allpersons[i].id);
			ii = ii + 1;
		}
	}
	loc.allAgbmMembers = $arrayOfStructsSort(loc.allAgbmMembers,loc.orderby);
	return loc.allAgbmMembers;
	writedump(loc.allAgbmMembers);abort;
};

private function $applyDistrictFilter(AgbmArray,district){
	var loc = arguments;
	var newArray = [];
	var i=0;
	var ii = 1;
	for (i=1; i=arraylen(AgbmArray); i=i+1){
		if(agbmArray[i].district EQ loc.district){
			newArray[ii] = agbmArray[i]
			ii = ii + 1;
		}
	}
	return newArray;
}

private function $getBestPersonPositionAsStruct(personid){
	var loc = arguments;
	var i = 1;
	var thisPosition = {};
	loc.positions = model("Handbookposition").findAll(select="id,position,positiontypeid, p_sortorder,personid,organizationid,selectName,district,districtid", where="personid = #loc.personid#", include="Handbookorganization(State,Handbookdistrict)");
	loc.positionsArray = queryToArray(loc.positions);
	for (i=1; i LTE arrayLen(loc.positionsArray); i=i+1){
		if (loc.positionsArray[i].position IS "AGBM Only" or loc.positionsArray[i].positionTypeId is 32)
		{
			thisPosition = $createPositionStruct(loc.positionsArray[i]);
			return(thisPosition);
		}
		else {
			thisPosition = $createPositionStruct(loc.positionsArray[i]);
		}
	}
	return(thisPosition);
}

private function $createPositionStruct(position){
	var loc = arguments;
	var thisPosition = {};
			thisPosition.position = loc.position.position;
			thisPosition.positionid = loc.position.id;
			thisPosition.sortorder = loc.position.p_sortorder;
			thisPosition.churchid = loc.position.organizationid;
			thisPosition.church = loc.position.selectName;
			thisPosition.district = loc.position.district;
			thisPosition.districtid = loc.position.districtid;
		return thisPosition;
}

private function $isThisOrgAChurch(required organizationid){
	var loc = arguments;
	var getOrgFromPosition = model("Handbookorganization").findOne(select="statusid",where="id=#loc.organizationid# AND statusid IN (1,2,4,8,9)");
	if (isObject(getOrgFromPosition))
		{
			return true;
		}
		else {
			return false;
		}
}

private function $getMembershipFeeInfo(required number personid){
	var loc = arguments;
	var personInfoArray = [];
	var personInfo = findAll(select="id,membershipfeeyear,membershipfee,category", where = "personid = #loc.personid#", order="membershipfeeyear desc");
	var personInfoArray = queryToArray(personInfo);
	return personInfoArray;
}

private function $arrayOfStructsSort(aOfS,key){
		//by default we'll use an ascending sort
		var sortOrder = "asc";		
		//by default, we'll use a textnocase sort
		var sortType = "textnocase";
		//by default, use ascii character 30 as the delim
		var delim = ".";
		//make an array to hold the sort stuff
		var sortArray = arraynew(1);
		//make an array to return
		var returnArray = arraynew(1);
		//grab the number of elements in the array (used in the loops)
		var count = arrayLen(aOfS);
		//make a variable to use in the loop
		var ii = 1;
		//if there is a 3rd argument, set the sortOrder
		if(arraylen(arguments) GT 2)
			sortOrder = arguments[3];
		//if there is a 4th argument, set the sortType
		if(arraylen(arguments) GT 3)
			sortType = arguments[4];
		//if there is a 5th argument, set the delim
		if(arraylen(arguments) GT 4)
			delim = arguments[5];
		//loop over the array of structs, building the sortArray
		for(ii = 1; ii lte count; ii = ii + 1)
			sortArray[ii] = aOfS[ii][key] & delim & ii;
		//now sort the array
		arraySort(sortArray,sortType,sortOrder);
		//now build the return array
		for(ii = 1; ii lte count; ii = ii + 1)
			returnArray[ii] = aOfS[listLast(sortArray[ii],delim)];
		//return the array
		return returnArray;
}

</cfscript>

	<cffunction name="findAllMembers">
	<cfargument name="currentMembershipYear" required="true">
	<cfargument name="alpha" required="false" type="string">
	<cfargument name="district" required="false" type="string">
	<cfargument name="search" required="false" type="string">
	<cfargument name="orderby" default="lname,fname">
	<cfset arguments.currentMembershipyear = val(arguments.currentMembershipyear)>

	<cfset var loc=structNew()>

		<cfset loc.agbm = getAgbm()>

		<cfif isDefined("arguments.district") and arguments.district is "all">
			  <cfset arguments.orderby = "district">
		</cfif>

		<cfquery dbtype="query" name="loc.return">
			SELECT *
			FROM loc.Agbm
			WHERE lastpayment >= #arguments.currentmembershipyear#
			<cfif isDefined("arguments.alpha") and len(arguments.alpha)>
				AND alpha = '#arguments.alpha#'
			</cfif>
			<cfif isDefined("arguments.district") and len(arguments.district) and arguments.district NEQ "all">
				AND districtid = #arguments.district#
			</cfif>
			<cfif isDefined("arguments.search") and len(arguments.search)>
				AND lname = '#arguments.search#'
				OR fname = '#arguments.search#'
			</cfif>
			ORDER BY #arguments.orderby#
		</cfquery>

		<cfreturn loc.return>
	</cffunction>

	<cffunction name="findAllMailingList">
	<cfargument name="orderby" default="lname,fname">
	<cfset var loc=structNew()>

		<cfset loc.agbm = getAgbm()>

		<cfquery dbtype="query" name="loc.return">
			SELECT *
			FROM loc.Agbm
			WHERE lastpayment <= #currentMembershipYear()-1#
		</cfquery>

		<cfreturn loc.return>
	</cffunction>

	<cffunction name="currentMembershipYear">
	<cfargument name="params" required="false" type="struct">
	<cfset var loc = structNew()>
	  <cfset loc.return = year(now())>
	   	<cfif isDefined("params.currentMembershipyear")>
	   		 <cfset loc.return = params.currentMembershipYear>
		<cfelse>
			<cfif dateCompare(createODBCDate(now()),createODBCDate(application.wheels.agbmDeadlineDate)) EQ -1>
		 		  <cfset loc.return = loc.return-1>
			</cfif>
		</cfif>
		<cfreturn loc.return>
	</cffunction>

	<cffunction name="isAgbmMember">
	<cfargument name="personid" required="true" type="numeric">
	<cfargument name="currentMembershipYear" default="#currentMembershipYear()#">
	<cfset var loc=structNew()>
	<cfset loc = arguments>
		<cfquery datasource="#getDataSourceName()#" name="loc.person">
			SELECT id, personid, max(membershipfeeyear) as lastpaymentmade
			FROM handbookagbminfo
			WHERE personid=#loc.personid#
		</cfquery>
		<cfif val(loc.person.lastpaymentmade) GTE val(loc.currentMembershipYear)>
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>
	</cffunction>

	<cffunction name="Handbookagbminfoasjson">
	<cfargument name="currentMembershipYear" default="#currentMembershipYear()#">
		<cfset var data = findAllMembers(currentMembershipYear=currentmembershipyear, orderby="lname,fname")>
		<cfset data = QueryToJson(data)>
		<cfreturn data>
	</cffunction>

</cfcomponent>