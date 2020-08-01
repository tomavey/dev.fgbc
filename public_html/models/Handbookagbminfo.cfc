<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset table("handbookagbminfo")>
		<cfset belongsTo(name="Handbookperson", foreignKey="personid")>
		<cfset hasMany(name="Handbookpositions", foreignKey="personid")>
	</cffunction>

	<cffunction name="getAgbm">
	<cfset var loc=structnew()>

		<cfquery datasource="#getDataSourceName()#" name="loc.return">
			SELECT p.lname, left(p.lname,1) as alpha, p.suffix, p.fname, o.name, p.address1, p.address2, p.city, p.zip, p.phone, p.email, district, d.districtid, ps.state_mail_abbrev as state, s.state_mail_abbrev as org_state, org_city, max(membershipfeeyear) as lastpayment, p.id as personid, o.id as organizationid, o.address1 as handbookorganizationaddress1, o.address2 as handbookorganizationaddress2, o.org_city, s.state_mail_abbrev as handbookorganizationstate, o.zip as handbookorganizationzip, o.statusid, o.email as org_email, region.name as regionname, region.id as regionid, regionrep.lname as regionreplname, regionrep.fname as regionrepfname, regionrep.id as regionrepid, ministrystartat, profile.birthdayyear, p.private, profile.agbmlifememberAt
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

public function getAgbm10YearMembers(countMin = 9){
	var members = getAgbm().filter( function (el) {
		return countOfMembershipYearsPaid(personid = el.personid) >= countMin
	} )
	return members
}

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
	var personInfo = findAll(select="id,membershipfeeyear,membershipfee,category", where = "personid = #loc.personid#", order="membershipfeeyear DESC");
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
	<cfargument name="publicOnly" default=false>
	<cfargument name="lifeTimeMembers" default=false>

	<cfset arguments.currentMembershipyear = val(arguments.currentMembershipyear)>

	<cfset var loc=structNew()>

		<cfset loc.agbm = getAgbm()>

		<cfif isDefined("arguments.district") and arguments.district is "all">
			  <cfset arguments.orderby = "district">
		</cfif>

	<cfscript>
		if ( lifeTimeMembers ) {
			loc.whereString = 'length(agbmlifememberAt) >= 4'
		} else {
			loc.whereString = '(lastpayment >= #arguments.currentmembershipyear# OR length(agbmlifememberAt) >= 4)'
		}

		if ( isDefined("arguments.alpha") and len(arguments.alpha) ) {
			loc.whereString = loc.whereString & " AND alpha = '#arguments.alpha#'"
		}

		if ( isDefined("arguments.district") and len(arguments.district) and arguments.district NEQ "all" ) {
			loc.whereString = loc.whereString & " AND districtid = #arguments.district#"
		}
			
		if ( isDefined("arguments.search") and len(arguments.search) ) {
			loc.whereString = loc.whereString & " AND lname = '#arguments.search#'
			OR fname = '#arguments.search#'"
		}

		if ( isDefined("arguments.publicOnly") && arguments.publicOnly ) {
			loc.whereString = loc.whereString & " AND private <> 'Yes'"
		}
	</cfscript>	
	<cfscript>
		// throw(loc.whereString)
	</cfscript>

		<cfquery dbtype="query" name="loc.return">
			SELECT *
			FROM loc.Agbm
			WHERE #loc.whereString#
			ORDER BY #arguments.orderby#
		</cfquery>

		<cfreturn loc.return>
	</cffunction>

	<cffunction name="findAllMailingList">
	<cfargument name="orderby" default="lname,fname">
	<cfargument name="currentMembershipYear" default="#currentMembershipYear()#">
	<cfset var loc=arguments>

		<cfset loc.agbm = getAgbm()>

		<cfquery dbtype="query" name="loc.return">
			SELECT *
			FROM loc.Agbm
			WHERE lastpayment <= #loc.currentmembershipyear#-1
		</cfquery>

		<cfreturn loc.return>
	</cffunction>

<cfscript>
	function isAgbmLifeMember(personid) {
		var person = model("Handbookprofile").findOne(where="personId = #personId#")
		if ( isDefined('person.agbmlifememberAt') && len(person.agbmlifememberAt) ) {
			return true
		}
		return false
	}
</cfscript>

	<cffunction name="isAgbmMember">
	<cfargument name="personid" required="true" type="numeric">
	<cfargument name="currentMembershipYear" default="#currentMembershipYear()#">
	<cfset var loc=structNew()>
	<cfset loc = arguments>
		<cfquery datasource="#getDataSourceName()#" name="loc.person">
			SELECT i.id, i.personid, max(membershipfeeyear) as lastpaymentmade, agbmlifememberAt
			FROM handbookagbminfo i JOIN handbookprofiles p
			WHERE i.personid=#loc.personid#
		</cfquery>
		<cfscript>
			// throw(serialize(loc.person))
		</cfscript>
		<cfif (val(loc.person.lastpaymentmade) GTE val(loc.currentMembershipYear) OR isAgbmLifeMember(loc.personid) )>
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>
	</cffunction>

<cfscript>
	function countOfMembershipYearsPaid(asOfMembershipFeeYear = year(now()), yearSpan = 10, required number personId) {
		var afterMembershipFeeYear = asOfMembershipFeeYear - yearSpan
		var whereString = 'personid = #personid# AND membershipFeeYear >= #afterMembershipFeeYear# AND membershipFeeYear <= #asOfMembershipFeeYear#'
		var agbmInfoRecords = findAll(where=whereString)
		return agbmInfoRecords.recordcount
	}
</cfscript>	

<cffunction name="Handbookagbminfoasjson">
	<cfargument name="currentMembershipYear" default="#currentMembershipYear()#">
	<cfargument name="publicOnly" default=false>
	<cfset var newData = "">
		<cfset var data = findAllMembers(currentMembershipYear=currentmembershipyear, orderby="lname,fname", publicOnly = arguments.publicOnly)>
		<cfquery dbtype="query" name="newData">
			select personid, lname, fname, name, org_city, org_state as state, district
			from data
		</cfquery>
		<cfset data = QueryToJson(newData)>
		<cfreturn data>
	</cffunction>

</cfcomponent>