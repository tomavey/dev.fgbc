<cfcomponent extends="controllers.Controller">

    <cffunction name="getState">
        <cfargument name="stateid" required="true" type="numeric">
        <cfset var state = model("Handbookstate").findone(where="id=#arguments.stateid#")>
        <cfreturn state.state>
    </cffunction>

    <cffunction name="getOrgStatus">
        <cfargument name="statusid" required="true" type="numeric">
        <cfset var status = model("Handbookstatus").findone(where="id=#arguments.statusid#")>
        <cfreturn status.status>
    </cffunction>

    <cffunction name="getOrg">
        <cfargument name="orgId" required="true" type="numeric">
        <cfset orgname = model("Handbookorganization").findone(where="id=#arguments.orgid#", include="State")>
        <cfreturn orgname.selectname>
    </cffunction>

    <cffunction name="getPerson">
        <cfargument name="personId" required="true" type="numeric">
        <cfset person = model("Handbookperson").findone(where="id=#arguments.personid#", include="State")>
        <cfif isObject(person)>
            <cfreturn person.selectname>
        <cfelse>
            <cfreturn "NA">
        </cfif>
    </cffunction>

<cfscript>

public function getHandbookReviewSecretary(){
    if (isDefined("params.handbookReviewSecretary")){
        session.handbook.handbookReviewsecretary = params.handbookReviewsecretary;
    }
    if (isDefined("params.useHandbookReviewSecretary2")){
        session.handbook.handbookReviewsecretary = application.wheels.handbookReviewsecretary2;
    }
    if (isDefined("session.handbook.handbookReviewSecretary")){
        return session.handbook.handbookReviewSecretary;
    }
    else {
        return application.wheels.handbookReviewsecretary;
    }
}

private function $$useParamsForDefaults(params,args){
    var loc = arguments;
	var argKeys = StructKeyList(loc.args);
	var i = 0;
	for(i=1; i lte len(argkeys); i=i+1){
		if(isDefined("loc.params[listGetAt(argKeys,i)]")){
			loc.args[listGetAt(argKeys,i)] = loc.params[listGetAt(argKeys,i)];
		};
	};
	return loc.args;	
}


public function updateDateNumbers(){
	var profiles = model("Handbookprofile").findAll(where="(birthday IS NOT NULL AND birthdayDayNumber IS NULL) OR (anniversary IS NOT NULL AND anniversaryDayNumber IS NULL) OR (wifesBirthday IS NOT NULL AND wifesBirthdayDayNumber IS NULL)");
	var i = 0;
	var thisRecord = {};
	var ending = profiles.recordCount;
	var count = 0;
	for (i=1;i LTE ending;i=i+1){
		thisRecord = model("Handbookprofile").findByKey(profiles.id[i]);
		if (!isDefined("profiles.birthdayDayNumber[i]") && isDefined("profiles.birthday[i]")){
			thisRecord.birthdayDayNumber = day(profiles.birthday[i]);
			thisRecord.birthdayMonthNumber = month(profiles.birthday[i]);
			thisRecord.birthdayYear = year(profiles.birthday[i]);
			count = count +1;
		};
		if (!isDefined("profiles.wifesBirthdayDayNumber[i]") && isDefined("profiles.wifesBirthday[i]")){
			thisRecord.wifesBirthdayDayNumber = day(profiles.wifesBirthday[i]);
			thisRecord.wifesBirthdayMonthNumber = month(profiles.wifesBirthday[i]);
			thisRecord.wifesBirthdayYear = year(profiles.wifesBirthday[i]);
			count = count +1;
		};
		if (!isDefined("profiles.anniversaryDayNumber[i]") && isDefined("profiles.anniversary[i]")){
			thisRecord.anniversaryDayNumber = day(profiles.anniversary[i]);
			thisRecord.anniversaryMonthNumber = month(profiles.anniversary[i]);
			thisRecord.anniversaryYear = year(profiles.anniversary[i]);
			count = count +1;
		}
			thisRecord.update();			

	};
}

public function paramsEmailRequired(){
    if (!isDefined("params.key")){
		renderText("This page cannot display - wrong parameters");
    }
}

</cfscript>

<cffunction name="isAGBM">
<cfargument name="personid">
<cfset var loc=structNew()>
<cfset loc.return = false>

  <cfset loc.check = model("Handbookagbminfo").findOne(where="personid = #arguments.personid#")>

  <cfif isObject(loc.check)>
    <cfset loc.return = true>
  </cfif>

<cfreturn loc.return>
</cffunction>

<cffunction name="isAgbmMember">
<cfargument name="personid" required="true" type="numeric">
<cfreturn model("Handbookagbminfo").isAgbmMember(arguments.personid)>
</cffunction>

<cffunction name="isFormerAGBMMember">
<cfargument name="personid" required="true" type="numeric">
    <cfif isAGBM(personid) && !isAgbmMember(personid)>
        <cfreturn true>
    <cfelse>    
        <cfreturn false>
    </cfif>    
</cffunction>

</cfcomponent>