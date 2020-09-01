//
//Written by Tom Avey for the Charis Fellowship
//Refactored October 2019 to use cfscript
//Used by the online handbook application - organizations (churches and ministries)
//
component extends="Model" output="false" {

	function init() {
		table("handbookorganizations")
		// Associations
		hasMany(name="Handbookpositions", foreignKey="organizationId", joinType="inner")
		hasMany(name="Positions", modelName="Handbookposition", foreignKey="organizationId", joinType="outer")
		hasMany(name="Handbookstatistics", foreignKey="organizationId")
		belongsTo(name="Handbookstate", foreignkey="stateid")
		belongsTo(name="State", modelName="Handbookstate", foreignkey="stateid")
		belongsTo(name="ListeAsState", modelName="Handbookstate", foreignkey="listed_as_stateid")
		belongsTo(name="Handbookstatus", foreignkey="statusid")
		belongsTo(name="Handbookdistrict", foreignkey="districtid")
		belongsTo(name="District",  modelName="Handbookdistrict", foreignkey="districtid")
		hasMany(name="Handbooktags", foreignKey="itemid")
		// CallBacks
		beforeUpdate("logUpdates,doListedAS")
		beforeCreate("doListedAs")
		beforeSave("doListedAs")
		afterCreate("logCreates")
		afterDelete("logDeletes")
		afterFind("doListedAs")
		// Properties
		property(
			name="state_mail_abbrev",
			sql="(SELECT handbookstates.state_mail_abbrev FROM handbookstates WHERE handbookstates.id = handbookorganizations.stateid)"
		)
		property(
			name="selectName",
			sql="CONCAT_WS(', ',handbookorganizations.name,listed_as_city,state_mail_abbrev)"
		)
		property(
			name="selectNameCity",
			sql="CONCAT_WS(', ',org_city,state_mail_abbrev,handbookorganizations.name)"
		)
		property(
			name="selectNameCity2",
			sql="CONCAT_WS('-',handbookorganizations.name,org_city,state_mail_abbrev)"
		)
	}




<!------------------------>
<!---CALLBACK FUNCTIONS--->
<!------------------------>
	
	function logUpdates(modelName="Handbookorganization"){
		superLogUpdates(arguments.modelName)
	}

	function logCreates(modelName="Handbookorganization") {
			superLogCreates(arguments.modelName)
	}
	
	function logDeletes(modelName="Handbookorganization") {
			superLogDeletes(arguments.modelName)
	}
	
	function doListedAs() {
		if ( isDefined("this.org_city") && !len(this.listed_as_city) ) {
			this.listed_as_city = this.org_city
		}
		if ( isDefined("this.stateid") && (!len(this.listed_as_stateid) || this.listed_as_stateid == 60) ) {
			this.listed_as_stateid = this.stateid
		}
	}
<!------------------------------->
<!---END OF CALLBACK FUNCTIONS--->
<!------------------------------->
	

<!--------------------->
<!---GENERAL FINDERS--->
<!--------------------->

	function findStatesWithOrganizations() {
		var loc = structNew();
		loc.states = findAll(where="show_in_handbook = 1", include="Handbookstate,Handbookstatus", order="state_mail_abbrev");
		return loc.states;
	}

	function findChurchesForDropDown(statusIds="1,2,4,8,9") {
		var loc=structNew();
		loc.return = findAll(where="statusid IN (#arguments.statusids#)", include="Handbookstate", select="handbookorganizations.id, CONCAT_WS(', ',org_city,state_mail_abbrev,handbookorganizations.name) AS selectname", order="org_city,state_mail_abbrev,name");
		return loc.return;
	}

	function findMinistriesForDropDown() {
		var loc=structNew();
		loc.return = findAll(where="statusid IN (10)", include="Handbookstate", select="handbookorganizations.id, CONCAT_WS(', ',org_city,state_mail_abbrev,handbookorganizations.name) AS selectname", order="org_city,state_mail_abbrev,name");
		return loc.return;
	}

	private function $findOrgs(selectname="true", type="churches") {
		var loc = arguments
		loc.includeString = "State,Handbookdistrict,Handbookpositions(Handbookperson)"
		loc.orderString = "state_mail_abbrev,org_city,id"
		if ( loc.selectname ) {
			loc.selectString = "handbookorganizations.id, concat(state,', ',org_city,': ',name,' [',lname,']') as selectName";
		} else {
			loc.selectString="handbookorganizations.id,name,handbookorganizations.address1,handbookorganizations.address2,handbookorganizations.phone,handbookorganizations.email,handbookorganizations.website,org_city as city,listed_as_city,state, meetingplace, district, statusid,handbookpeople.fname, handbookpeople.lname, handbookpeople.phone as person_phone, handbookpeople.email as person_email, handbookpositions.position, concat(org_city,', ',state,': ',name) as selectName";
		}
		if ( loc.type == "churches" ) {
			loc.whereString = "statusid IN (1,2,4,8,9) AND p_sortorder = 1";
		} else {
			loc.whereString = "statusid IN (10,11)";
			loc.selectString = "name, handbookorganizations.id, concat(state,', ',org_city,': ',name) as selectName";
			loc.includeString="State";
		}
		loc.orgs = findAll(select= loc.selectString, where=loc.whereString, include=loc.includeString, order=loc.orderString);
		return loc.orgs;
	}

	function findChurchWithStaff(required numeric id) {
		var org = findAll(where="id=#loc.id# AND p_sortorder < 500", include="state,Handbookpositions(Handbookperson)", order="p_sortorder")
		return org
	}

	function findChurchesAsJson() {
		var orgsQuery = $findOrgs()
		var orgsJson = queryToJson(orgsQuery)
		return orgsJson;
	}

	function findMinistriesAsJson() {
		var orgsQuery = $findOrgs(type="ministries")
		var orgsJson = queryToJson(orgsQuery);
		return orgsJson;
	}

	function findChurchWithStaffAsJson(required numeric id) {
		var orgsQuery = findChurchWithStaff(loc.id)
		var orgsJson = QueryToJson(orgsQuery)
		return orgsJson;
	}
<!---------------------------->
<!---END OF GENERAL FINDERS--->
<!---------------------------->




<!---------------------------------->
<!---FOR HANDBOOK REVIEW LINK APP--->
<!---------------------------------->

	public function findChurchesForEmailing(
			statusIds = "1,2,4,8,9",
			maxrows = 1000000,
			reviewedBefore = now(),
			go = "false",
			orderby = "id"){
		var = loc = arguments;
		if (loc.go){
			var churchEmails = ArrayNew();
			loc.whereString="statusid IN (#loc.statusids#) AND (reviewedAt < '#loc.reviewedBefore#' OR reviewedAt IS NULL)";
			loc.churchids = findAll(select="id", where=loc.whereString, include="State", order="id", maxrows=#loc.maxrows#, order=loc.orderby);
			for (loc.i=1; loc.i LTE loc.churchids.recordCount; loc.i=loc.i+1){
				loc.church = findByKey(key=loc.churchids.id[loc.i], include="state");
				churchEmails = $buildEmailingArray(loc.church,"email",churchEmails);
				churchEmails = $buildEmailingArray(loc.church,"email2",churchEmails);
				churchEmails = $buildEmailingArray(loc.church,"reviewedBy",churchEmails);
				if (!isValid("email",loc.church.email2)){
					churchEmails = $buildEmailingArray(loc.church,"email",churchEmails,$getSeniorPastorEmail(loc.churchids.id[loc.i]),"Senior Pastor Email");
					}
				}	
			churchesEmails = $addLastEmailToConfirm(churchEmails);
			churchesEmails = $removeDuplicates(churchEmails);
			return $cleanUpEmailArray(churchEmails); 		
		}
		else
		{ 
			return $loadTestEmails();
		}
	}

	private	function $loadTestEmails(){
		var testEmails = listToArray(getSetting('testEmailsForHandbookReview'));
		var churchEmails = [];
		var i = "";
		for (i=1;i LTE ArrayLen(testEmails); i=i+1){
			churchEmails[i].email = testEmails[i];
			churchEmails[i].selectName = "This test church-#i#";
			churchEmails[i].emailtype = "email";
			churchEmails[i].id = 233;
			churchEmails[i].lastReviewedAt = dateFormat("2016-09-01");
			churchEmails[i].lastReviewedBy = "tomavey@fgbc.org";
		}
		return churchEmails;
	}

	private function $buildEmailingArray(
		required church,
		fieldName = "email",
		required thisarray,
		forceEmail = "false",
		EmailType = "false"
	){
		var loc = arguments;
		var emailing = {};
		if (isObject(loc.church) && isDefined("loc.forceEmail") && isValid("email",loc.forceEmail)){
			loc.church.email = loc.forceEmail;
		};
		if (!isDefined("loc.EmailType")){
			loc.emailtype = loc.fieldName;
		};
		if (isObject(loc.church) && isValid("email",loc.church[loc.fieldName])){
				emailing.email = loc.church[loc.fieldName];
				emailing.id = loc.church.id;
				emailing.selectname = loc.church.selectname;
				emailing.lastReviewedAt = dateFormat(loc.church.reviewedAt);
				emailing.lastReviewedBy = loc.church.reviewedBy;
				emailing.updatedAt = loc.church.updatedAt
			};
		if (!arrayFind(loc.thisArray,emailing))	{
				ArrayAppend(loc.thisArray, emailing);
		};
		return loc.thisArray;
	}

	private function $addLastEmailToConfirm(required array thisArray){
		var loc = arguments;
		loc.emailing.email = "tomavey@fgbc.org";
		loc.emailing.id = 1;
		loc.emailing.selectname = "Test Church - #arrayLen(loc.thisarray)# at end of list";
		loc.emailing.lastReviewedAt = "2016-09-01";
		loc.emailing.lastReviewedBy = "tomavey@fgbc.org";
		ArrayAppend(loc.thisArray, loc.emailing);	
		return loc.thisarray;	
	}

	private function $getSeniorPastorEmail(required churchid){
		var loc = arguments;
		loc.seniorpastor = findAll(where="id = #loc.churchid# AND p_sortorder=1", include="Positions(Handbookperson(state))");
		if(loc.seniorpastor.recordCount AND isValid("email",loc.seniorpastor.Handbookpersonemail)){
			return loc.seniorpastor.Handbookpersonemail;
		}
		else {
			return false;
		};
	}

	private function $cleanUpEmailArray(required emailArray){
		var emailArray = arguments.emailArray;
		var returnedArray = [];
		var thisStruct = {};
		var i = 0;
		for(i=1; i LTE arrayLen(emailArray); i=i+1){
			try{
				if(isValid("email",emailArray[i].email)){
					arrayAppend(returnedArray,emailArray[i]);
				}
			}
			catch(any e){}
		}
		return returnedArray;
	}

	function removeFromStaff(required string positionid, required string position, required string positionTypeId) {
		var loc = arguments;
		cfquery( datasource=getDataSource() ) {

			writeOutput("UPDATE handbookpositions
					SET p_sortorder = #getNonStaffSortOrder()#,
					position = '#loc.position#',
					positiontypeid = #loc.positiontypeid#
					WHERE id = #loc.positionid#");
		}
	}

<!------------------------------------->
<!---END OF HANDBOOK REVIEW LINK APP--->
<!------------------------------------->
}
