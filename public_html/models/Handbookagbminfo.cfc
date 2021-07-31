component extends="Model" output="false" {

	public function config(){
		table("handbookagbminfo")
		belongsTo(name="Handbookperson", foreignKey="personid")
		hasMany(name="Handbookpositions", foreignKey="personid")
	}

	public function getAgbm(orderby="lname, fname, t.createdAt", limit=10000){
		var loc = structNew()
		loc.sql = "SELECT p.lname, left(p.lname,1) as alpha, p.suffix, p.fname, o.name, p.address1, p.address2, p.city, p.zip, p.phone, p.email, district, d.districtid, ps.state_mail_abbrev as state, s.state_mail_abbrev as org_state, org_city, max(membershipfeeyear) as lastpayment, p.id as personid, o.id as organizationid, o.address1 as handbookorganizationaddress1, o.address2 as handbookorganizationaddress2, o.org_city, s.state_mail_abbrev as handbookorganizationstate, o.zip as handbookorganizationzip, o.statusid, o.email as org_email, region.name as regionname, region.id as regionid, regionrep.lname as regionreplname, regionrep.fname as regionrepfname, regionrep.id as regionrepid, ministrystartat, profile.birthdayyear, p.private, profile.agbmlifememberAt, i.ordained, i.commissioned
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
		JOIN (
			SELECT membershipfeeyear, ordained, commissioned, personid, createdAt
			FROM handbookagbminfo
			WHERE deletedAt IS NULL 
			ORDER BY membershipfeeyear DESC
		) AS i
		ON i.personid = p.id
		WHERE (o.statusid IN (#getSetting("churchStatusForHandbook")#)
			OR o.id = 900) ## picks up on Inspire members
			AND t.p_sortorder <> 999
			AND p.deletedAt IS NULL
			AND t.deletedAt IS NULL
			AND o.deletedAt IS NULL
			AND d.deletedAt IS NULL
		GROUP BY p.id
		ORDER BY #arguments.orderby#
		LIMIT #arguments.limit#"
		loc.qoptions = {result = "myResult", datasource="#getDataSourceName()#"}
		return queryExecute(loc.sql,[],loc.qoptions)
		ddd(queryExecute(loc.sql,[],loc.qoptions))
	}

	public function getAgbm10YearMembers(countMin = 9){
		var members = getAgbm().filter( (el) => countOfMembershipYearsPaid(personid = el.personid) >= countMin )
		return members
	}


	function findAllMembers(
		required string currentMembershipYear,
		string alpha,
		string district,
		seach string,
		orderby = "lname,fname",
		publicOnly = false,
		lifeTimeMembers = false
		){
			arguments.currentMembershipyear = val(arguments.currentMembershipyear)
			var loc = arguments

			if ( isDefined("loc.district") and loc.district is "all" ) {
				loc.orderby = "district, lname, fname"
			}

			//Get the big list of potentialmembers
			loc.members = getAgbm(orderby = loc.orderby)		

			//filter for just lifeTime Members OR paid up members AND lifeTimeMembers
			if ( lifeTimeMembers ) {
				loc.members = queryFilter(loc.members, (el) => len(el.agbmlifememberAt))
			} else {
				var filter = loc.currentmembershipyear
				loc.members = queryFilter(loc.members, (el) => el.lastpayment >= filter || len(el.agbmlifememberAt))
			}

			//filter for a specific district
			if ( isDefined("loc.district") and len(loc.district) and loc.district NEQ "all" ) {
				var filter = loc.district
				loc.members = queryFilter(loc.members, (el) => el.district == filter)
			}

			//filter for a specific alpha
			if ( isDefined("loc.alpha") and len(loc.alpha) ) {
				var filter = loc.alpha
				loc.members = queryFilter(loc.members, (el) => el.alpha == filter)
			}

			//filter for a search field
			if ( isDefined("loc.search") and len(loc.search) ) {
				var filter = loc.search
				loc.members = queryFilter( loc.members, (el) => ( el.lname == filter || el.fname == filter ) )
			}

			//filter for public only - exclude records marked private
			if ( isDefined("loc.publicOnly") && loc.publicOnly ) {
				loc.members = queryFilter(loc.members, (el) => el.private != "yes")
			}

		return loc.members

	}


	function findAllMailingList(orderby="lname,fname", currentMembershipYear="#currentMembershipYear()#") {
		var loc=arguments;
		loc.agbm = getAgbm();
		cfquery( dbtype="query", name="loc.return" ) { //Note: queryExecute() is the preferred syntax but this syntax is easier to convert generically

			writeOutput("SELECT *
				FROM loc.Agbm
				WHERE lastpayment >= #loc.currentmembershipyear-getSetting('agbmLastPaymentYearsAgo')#");
		}
		return loc.return;
	}

	//Used people handbook.person controller
	function isAgbmLifeMember(personid) {
		var person = model("Handbookprofile").findOne(where="personId = #personId#")
		if ( isDefined('person.agbmlifememberAt') && len(person.agbmlifememberAt) ) {
			return true
		}
		return false
	}

	function countOfMembershipYearsPaid(asOfMembershipFeeYear = year(now()), yearSpan = 10, required number personId) {
		var afterMembershipFeeYear = asOfMembershipFeeYear - yearSpan
		var whereString = 'personid = #personid# AND membershipFeeYear >= #afterMembershipFeeYear# AND membershipFeeYear <= #asOfMembershipFeeYear#'
		var agbmInfoRecords = findAll(where=whereString)
		return agbmInfoRecords.recordcount
	}


	function isAgbmMember(required numeric personid, currentMembershipYear="#currentMembershipYear()#") {
		var loc=structNew();
		loc = arguments;
		cfquery( name="loc.person", datasource=getDataSourceName() ) { //Note: queryExecute() is the preferred syntax but this syntax is easier to convert generically
	
			writeOutput("SELECT i.id, i.personid, max(membershipfeeyear) as lastpaymentmade, agbmlifememberAt
					FROM handbookagbminfo i JOIN handbookprofiles p
					WHERE i.personid=#loc.personid#");
		}
	
		// throw(serialize(loc.person))
		if ( (val(loc.person.lastpaymentmade) >= val(loc.currentMembershipYear) || isAgbmLifeMember(loc.personid) ) ) {
			return true;
		} else {
			return false;
		}
	}

	
//Likely trash - need to test more

	public function getAllAgbm(maxrows = 100){
		var people = model("Handbookperson").findAll(select="id, fname, lname, selectName", include="State,Handbookpositions", maxrows=arguments.maxrows);
		var peopleStruct = queryToArray(people);
		return peopleStruct;
	};


	function Handbookagbminfoasjson(currentMembershipYear="#currentMembershipYear()#", publicOnly="false") {
		var newData = "";
		var data = findAllMembers(currentMembershipYear=currentmembershipyear, orderby="lname,fname", publicOnly = arguments.publicOnly);
		cfquery( dbtype="query", name="newData" ) { //Note: queryExecute() is the preferred syntax but this syntax is easier to convert generically

			writeOutput("select personid, lname, fname, name, org_city, org_state as state, district
				from data");
		}
		data = QueryToJson(newData);
		return data;
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
		if(arraylen(arguments) GT 2) { sortOrder = arguments[3] }
		//if there is a 4th argument, set the sortType
		if(arraylen(arguments) GT 3) { sortType = arguments[4] }
		//if there is a 5th argument, set the delim
		if(arraylen(arguments) GT 4) { delim = arguments[5] }
		//loop over the array of structs, building the sortArray
		for(ii = 1; ii lte count; ii = ii + 1) {
			sortArray[ii] = aOfS[ii][key] & delim & ii;
		}
		//now sort the array
		arraySort(sortArray,sortType,sortOrder);
		//now build the return array
		for(ii = 1; ii lte count; ii = ii + 1) {
			returnArray[ii] = aOfS[listLast(sortArray[ii],delim)];
		}
		//return the array
		return returnArray;
		}



	private function $getMembershipFeeInfo(required number personid){
		var loc = arguments;
		var personInfoArray = [];
		var personInfo = findAll(select="id,membershipfeeyear,membershipfee,category", where = "personid = #loc.personid#", order="membershipfeeyear DESC");
		var personInfoArray = queryToArray(personInfo);
		return personInfoArray;
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


	public function getAgbmMembers(maxrows = -1, orderby="lname", district="Arctic", search="", refresh=true){
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



	//Not Used?

	// private function $applyDistrictFilter(AgbmArray,district){
	// 	var loc = arguments;
	// 	var newArray = [];
	// 	var i=0;
	// 	var ii = 1;
	// 	for (i=1; i=arraylen(AgbmArray); i=i+1){
	// 		if(agbmArray[i].district EQ loc.district){
	// 			newArray[ii] = agbmArray[i]
	// 			ii = ii + 1;
	// 		}
	// 	}
	// 	return newArray;
	// }

	// //Not Used?
	// private function $isThisOrgAChurch(required organizationid){
	// 	var loc = arguments;
	// 	var getOrgFromPosition = model("Handbookorganization").findOne(select="statusid",where="id=#loc.organizationid# AND statusid IN (1,2,4,8,9)");
	// 	if (isObject(getOrgFromPosition))
	// 		{
	// 			return true;
	// 		}
	// 		else {
	// 			return false;
	// 		}
	// }

}

