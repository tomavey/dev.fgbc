<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset table("handbookorganizations")>

		<!---Associations--->
		<cfset hasMany(name="Handbookpositions", foreignKey="organizationId", joinType="inner")>
		<cfset hasMany(name="Positions", modelName="Handbookposition", foreignKey="organizationId", joinType="outer")>
		<cfset hasMany(name="Handbookstatistics", foreignKey="organizationId")>
		<cfset belongsTo(name="Handbookstate", foreignkey="stateid")>
		<cfset belongsTo(name="State", modelName="Handbookstate", foreignkey="stateid")>
		<cfset belongsTo(name="ListeAsState", modelName="Handbookstate", foreignkey="listed_as_stateid")>
		<cfset belongsTo(name="Handbookstatus", foreignkey="statusid")>
		<cfset belongsTo(name="Handbookdistrict", foreignkey="districtid")>
		<cfset belongsTo(name="District",  modelName="Handbookdistrict", foreignkey="districtid")>
		<cfset hasMany(name="Handbooktags", foreignKey="itemid")>

		<!---CallBacks--->
		<cfset beforeUpdate("logUpdates,doListedAS")>
		<cfset beforeCreate("doListedAs")>
		<cfset beforeSave("doListedAs")>
		<cfset afterCreate("logCreates")>
		<cfset afterDelete("logDeletes")>
		<cfset afterFind("doListedAs")>

		<!---Properties--->

		<cfset property(
			name="state_mail_abbrev",
			sql="(SELECT handbookstates.state_mail_abbrev FROM handbookstates WHERE handbookstates.id = handbookorganizations.stateid)"
			)>

		<cfset property(
			name="selectName",
			sql="CONCAT_WS(', ',handbookorganizations.name,org_city,state_mail_abbrev)"
			)>
		<cfset property(
			name="selectNameCity",
			sql="CONCAT_WS(', ',org_city,state_mail_abbrev,handbookorganizations.name)"
			)>
		<cfset property(
			name="selectNameCity2",
			sql="CONCAT_WS('-',handbookorganizations.name,org_city,state_mail_abbrev)"
			)>

	</cffunction>

	<!---CallBack Functions--->
	<cffunction name="logUpdates">
	<cfargument name="modelName" default="Handbookorganization">
	<cfargument name="createdBy" default="#session.auth.email#">

		<cfset old = model("#arguments.modelName#").findByKey(key=this.id, include="Handbookstate")>
		<cfset new = this>
		<cfset changes= new.changedProperties()>
		<cfoutput>
		<cfloop list="#changes#" index="i">
			<cfif not i is "updatedAt">
				<cfset newupdate.modelName = arguments.modelName>
				<cfset newupdate.recordId = this.id>
				<cfset newupdate.columnName = i>
				<cfset newupdate.datatype = "update">
				<cfset newupdate.olddata = old[i]>
				<cfset newupdate.newData = new[i]>
				<cfset newupdate.createdBy = "#arguments.createdBy#">
				<cfset update = model("Handbookupdate").create(newupdate)>
			</cfif>
		</cfloop>
		</cfoutput>
		<cfreturn true>
	</cffunction>

	<cffunction name="logCreates">
	<cfargument name="modelName" default="Handbookorganization">
	<cfargument name="createdBy" default="#session.auth.email#">

		<cfset newSave.modelName = arguments.modelName>
		<cfset newSave.recordId = this.id>
		<cfset newSave.datatype = "new">
		<cfset newSave.createdBy = "#arguments.createdBy#">
		<cfset update = model("Handbookupdate").create(newSave)>

		<cfreturn true>

	</cffunction>


	<cffunction name="logDeletes">
		<cfset person = model("handbookOrganization").findByKey(key=this.id, include="handbookState")>
		<cfset superLogDeletes('handbookOrganization',person.selectName)>
	</cffunction>

	<cffunction name="doListedAs">
		<cfif isDefined("this.org_city") AND !len(this.listed_as_city)>
			<cfset this.listed_as_city = this.org_city>
		</cfif>	
		<cfif isDefined("this.stateid") AND (!len(this.listed_as_stateid) OR this.listed_as_stateid is 60)>
			<cfset this.listed_as_stateid = this.stateid>
		</cfif>	
	</cffunction>

<!---Finders--->

	<cffunction name="findStatesWithOrganizations">
	<cfset var loc = structNew()>
		<cfset loc.states = findAll(where="show_in_handbook = 1", include="Handbookstate,Handbookstatus", order="state_mail_abbrev")>
		<cfreturn loc.states>
	</cffunction>

	<cffunction name="findChurchesForDropDown">
	<cfargument name='statusIds' default = "1,8,9">
	<cfset var loc=structNew()>
		<cfset loc.return = findAll(where="statusid IN (#arguments.statusids#)", include="Handbookstate", select="handbookorganizations.id, CONCAT_WS(', ',org_city,state_mail_abbrev,handbookorganizations.name) AS selectname", order="org_city,state_mail_abbrev,name")>
	<cfreturn loc.return>
	</cffunction>

	<cffunction name="findMinistriesForDropDown">
	<cfset var loc=structNew()>
		<cfset loc.return = findAll(where="statusid IN (10)", include="Handbookstate", select="handbookorganizations.id, CONCAT_WS(', ',org_city,state_mail_abbrev,handbookorganizations.name) AS selectname", order="org_city,state_mail_abbrev,name")>
	<cfreturn loc.return>
	</cffunction>

	<cffunction name="findOrgs">
	<cfargument name="selectname" default="true">
	<cfargument name="type" default="churches">
	<cfset var loc = structNew()>
	<cfset loc = arguments>
		<cfquery datasource="fgbc_main_3">
			SET SESSION group_concat_max_len = 1000000
		</cfquery>

		<cfset loc.includeString = "State,Handbookdistrict,Handbookpositions(Handbookperson)">

		<cfif loc.selectname>
			<cfset loc.selectString = "handbookorganizations.id, concat(state,', ',org_city,': ',name,' [',lname,']') as selectName">
		<cfelse>
			<cfset loc.selectString="handbookorganizations.id,name,handbookorganizations.address1,handbookorganizations.address2,handbookorganizations.phone,handbookorganizations.email,handbookorganizations.website,org_city as city,listed_as_city,state, meetingplace, district, statusid,handbookpeople.fname, handbookpeople.lname, handbookpeople.phone as person_phone, handbookpeople.email as person_email, handbookpositions.position, concat(org_city,', ',state,': ',name) as selectName">
		</cfif>

		<cfif loc.type is "churches">
			<cfset loc.whereString = "statusid IN (1,2,4,8,9) AND p_sortorder = 1">
		<cfelse>
			<cfset loc.whereString = "statusid IN (10,11)">
			<cfset loc.selectString = "name, handbookorganizations.id, concat(state,', ',org_city,': ',name) as selectName">
			<cfset loc.includeString="State">
		</cfif>
		<cfset loc.orgs = findAll(select= loc.selectString, where=loc.whereString, include=loc.includeString, order="state_mail_abbrev,org_city,id")>
		<cfreturn loc.orgs>
	</cffunction>

	<cffunction name="findChurchWithStaff">
	<cfargument name="id" required=true type="numeric">
	<cfset var loc = structNew()>
	<cfset loc = arguments>
		<cfset loc.org = findAll(where="id=#loc.id# AND p_sortorder < 500", include="state,Handbookpositions(Handbookperson)", order="p_sortorder")>
		<cfreturn loc.org>
	</cffunction>

	<cffunction name="findChurchesAsJson">
	<cfset var loc = structNew()>
	<cfset loc = arguments>
	<cfset loc.orgsquery = findOrgs()>
		<cfset loc.orgs = QueryToJson(loc.orgsquery)>
		<cfreturn loc.orgs>
	</cffunction>

	<cffunction name="findMinistriesAsJson">
	<cfset var loc = structNew()>
	<cfset loc = arguments>
	<cfset loc.orgsquery = findOrgs(type="ministries")>
	<cfset loc.return = queryToJson(loc.orgsquery)>
		<cfreturn loc.return>
	</cffunction>

	<cffunction name="findChurchWithStaffAsJson">
	<cfargument name="id" required=true type="numeric">
	<cfset var loc = structNew()>
	<cfset loc = arguments>
	<cfset loc.orgquery = findChurchWithStaff(loc.id)>
		<cfset loc.org = QueryToJson(loc.orgquery)>
		<cfreturn loc.org>
	</cffunction>

<cfscript>

<!---Methods to create the array for handbook review view--->
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
	var testEmails = ["tomavey@fgbc.org","tomavey9173@gmail.com"];
	var churchEmails = [];
	var i = "";
	for (i=1;i LTE ArrayLen(testEmails); i=i+1){
		churchEmails[i].email = testEmails[i];
		churchEmails[i].selectName = "This new church-#i#";
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

</cfscript>

	<cffunction name="removeFromStaff">
	<cfargument name="positionid" required="true" type="string">
	<cfargument name="position" required="true" type="string">
	<cfargument name="positionTypeId" required="true" type="string">
		<cfset var loc = arguments>
			<cfquery datasource="fgbc_main_3">
				UPDATE handbookpositions
				SET p_sortorder = #getNonStaffSortOrder()#,
				position = '#loc.position#',
				positiontypeid = #loc.positiontypeid#
				WHERE id = #loc.positionid#
			</cfquery>
	</cffunction>



</cfcomponent>