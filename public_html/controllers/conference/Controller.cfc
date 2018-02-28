<cfcomponent extends="controllers.Controller">

	<cffunction name="isBefore">
	<cfargument name="date" required="yes" type="date">
	<cfif datecompare(now(),arguments.date) is -1>
		<cfreturn 1>
	<cfelse>
		<cfreturn 0>
	</cfif>
	</cffunction>

	<cffunction name="sendMonitoringEmail">
		<cfif application.wheels.Monitoring>
			<cfset sendemail(from="tomavey@fgbc.org", to="tomavey@fgbc.org", template="emailparams", subject="V2020 Params", layout="layout_for_email")>
		</cfif>
	</cffunction>

<!---Moved to main controller
	<cffunction name="GotRights">
	<cfargument name="rightRequired" required="yes">
		<cfset permission = "no">
	        <cfloop list="#rightrequired#" index="i">
	            <cfif isdefined("session.auth.rightslist") and listFindNoCase(session.auth.rightslist,"#i#")>
	                <cfset permission = "yes">
	            </cfif>

	            <cfif i is "handbook">
	                <cftry>
	                    <cfinvoke component="_model.handbook.staff.cfc_handbook_staff" method="get" email="#session.auth.email#" maxSortOrder="900" returnvariable="handbook" />

	                    <cfif handbook.recordcount>
	                        <cfset permission = "yes">
	                    </cfif>
	                <cfcatch></cfcatch></cftry>
	            </cfif>

	        </cfloop>

	<cfreturn permission>
	</cffunction>
--->    

    <cffunction name="inAuthGroup">
    
    </cffunction>

	<cffunction name="officeOnly">
		<cfif isDefined("params.key") AND params.key is "kkjhdgwerlkjshdghhjkskjhd">
			<cfset session.vision2020admin = 1>
		<cfelseif isDefined("params.office") and params.office is "kkjhdgwerlkjshdghhjkskjhd">
			<cfset session.vision2020admin = 1>
		<cfelseif gotRights("superadmin,office")>
			<cfset session.vision2020admin = 1>
		</cfif>
		<cfif not isDefined("session.vision2020admin") OR not session.vision2020admin>
			Sorry, you do not have permission to view this page!
			<cfabort>
		</cfif>
	</cffunction>

	<cffunction name="getEvent">
        <cfreturn getSetting("event")>
	</cffunction>

	<cffunction name="getEventAsText">
        <cfreturn getSetting("eventAsText")>
	</cffunction>

    <cffunction name="getEventAsTextA">
    <cfset var loc.eventA = getEventAsText()>
    <cfset var f = left(loc.eventA,1)>
    <cfif f is "A" || f is "E" || f is "I" || f is "O" || f is "U" >
        <cfset loc.eventA = ("An " & loc.eventA)>
    <cfelse>
        <cfset loc.eventA = ("A " & loc.eventA)>
    </cfif>    
    <cfreturn loc.eventA>
    </cffunction>

    <cffunction name="getEventAsUrlEncodedText">
    <cfset var event = "">
            <cfif isDefined("params.eventAsText")>
                <cfset event = params.eventAsText>
            <cfelse>
                <cfset event = application.wheels.eventAsText>
            </cfif>
            <cfset event = replace(event," ","%20","all")>
            <cfreturn trim(event)>
    </cffunction>

    <cffunction name="getNextEvent">
           <cfreturn application.wheels.nextEvent>
    </cffunction>

	<cffunction name="getSpouse" access="private" >
	<cfargument name="id" required="true" type="numeric">
	<cfset var loc=structNew()>
		<cfset loc.thisperson = model("Conferenceperson").findOne(where="id=#arguments.id#", include="family")>

		<cfif isObject(loc.thisperson) AND loc.thisperson.type is "Adult">

			<cfset loc.spouse = model("Conferenceperson").findOne(where="equip_familiesid=#loc.thisperson.equip_familiesid# AND type='spouse'", include="family")>

			<cfif isObject(loc.spouse)>
				<cfset loc.return.id = loc.spouse.id>
				<cfset loc.return.fname = loc.spouse.fname>
				<cfset loc.return.equip_prayer_tripletsid = loc.spouse.equip_prayer_tripletsid>
                <cfset loc.return.email = loc.spouse.email>
			<cfelse>
				<cfset loc.return.id = "">
				<cfset loc.return.fname = "">
				<cfset loc.return.equip_prayer_tripletsid = "">
                <cfset loc.return.email = "">
			</cfif>

		<cfelseif isObject(loc.thisperson) AND loc.thisperson.type is "spouse">
			<cfset loc.adult = model("Conferenceperson").findOne(where="equip_familiesid=#loc.thisperson.equip_familiesid# AND type='Adult'", include="family")>

			<cfif isObject(loc.adult)>
				<cfset loc.return.id = loc.adult.id>
				<cfset loc.return.fname = loc.adult.fname>
				<cfset loc.return.equip_prayer_tripletsid = loc.adult.equip_prayer_tripletsid>
                <cfset loc.return.email = loc.adult.email>
			<cfelse>
				<cfset loc.return.id = "">
				<cfset loc.return.fname = "">
				<cfset loc.return.equip_prayer_tripletsid = "">
	            <cfset loc.return.email = "">
			</cfif>

		<cfelse>
				<cfset loc.return.id = "">
				<cfset loc.return.fname = "">
				<cfset loc.return.equip_prayer_tripletsid = "">
	            <cfset loc.return.email = "">
		</cfif>
    <cfreturn loc.return>
	</cffunction>

	<cffunction name="testGetSpouse">
	<cfargument name="id" default="#params.key#">
		<cfset return = getSpouse(arguments.id)>
		<cfdump var="#return#"><cfabort>
	</cffunction>

	<cffunction name="getConfUrl">
		<cfreturn application.wheels.webpage>
	</cffunction>

	<cffunction name="workshopsRegOpen">
	<cfif application.wheels.workshopsRegIsOpen OR gotRights("office") or isDefined("params.openreg") || (isDefined("session.auth.openWorkshops") && session.auth.openWorkshops)>
		<cfreturn true>
	<cfelse>
		<cfreturn false>
	</cfif>
	</cffunction>

    <cffunction name="regIsOpen">
    <cfif application.wheels.registrationIsOpen OR gotRights("office") || isDefined("params.openreg") || isDefined("session.auth.openreg")>
        <cfreturn true>
    <cfelse>
        <cfreturn false>
    </cfif>
    </cffunction>

<cfscript>

    public function preRegIsOpen(){
        if (application.wheels.preregistrationIsOpen) {
            return true;
        }
        else {
            return false;
        }
    }

    public function groupRegIsOpen(){
        if (application.wheels.groupregistrationIsOpen || gotRights("office") || isDefined(
        "params.opengroupsreg") || isDefined("session.auth.opengroupsreg")) {
            return true;
        }
        else {
            return false;
        }
    }

    public function convertGroupRegIsOpen(){
        if (application.wheels.convertGroupRegistrationIsOpen || gotRights("office") || isDefined(
        "params.convertGroupRegistrationIsOpen") || isDefined("session.auth.convertGroupRegistrationIsOpen")) {
            return true;
        }
        else {
            return false;
        }
    }

    public function mealsRegIsOpen(){
        if (application.wheels.mealsregistrationIsOpen OR gotRights("office") or isDefined("params.openreg") || isDefined("session.auth.openreg")) {
            return true;            
        }
        else {
            return false;
        }
    }    

    public function childRegIsOpen(){
        if ((application.wheels.ccareregistrationIsOpen && isBefore(application.wheels.ccareregistrationDeadline)) OR gotRights("office") or isDefined("params.openreg") || isDefined("session.auth.openreg")){
            return true;
        }
        else {
            return false;
        }
    }

    public function regAccountIsOpen(){
        if (application.wheels.regAccountIsOpen OR gotRights("office") or isDefined("params.openreg") || isDefined("session.auth.openreg")){
            return true;
        }
        else {
            return false;
        }
    }

    public function optionsRegIsOpen(){
        if (application.wheels.optionsregistrationIsOpen || isDefined("params.openreg") || isDefined("session.auth.openreg")){
            return true;
        }
        else {
            return false;
        };
    }

    public function regOpenPromiseDate(){
        return application.wheels.regOpenPromiseDate;
    }


</cfscript>


	<cffunction name="hasThisPersonSelectedWorkshops">
	<cfargument name="personid" required="true" type="numeric">
	<cfargument name="type" default="workshop">
    <cfargument name="workshopid" default=0>

    <cfset whereString = "equip_peopleid = #arguments.personid# AND equip_optionsid = #getOptionIdFromName(arguments.type)#">

    <cfif arguments.workshopid>
        <cfset whereString = whereString & " AND equip_coursesid = #arguments.workshopid#">
    <cfelse>
        <cfset whereString = whereString & " AND equip_coursesid <> 0">
    </cfif>

	<cfset workshop = model("Conferenceregistration").findOne(where=whereString)>
		<cfif isObject(workshop)>
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>
	</cffunction>

	<cffunction name='getOptionIdFromName'>
	<cfargument name="name" required="true" type="string">
	<cfset var loc=arguments>
		<cfset loc.optionid = model("Conferenceoption").findOne(where="name='#loc.name#'").id>
		<cfreturn loc.optionid>
	</cffunction>

	<cffunction name="renderJson">
		<cfset renderPage(layout="/layout_json", template="json", hideDebugInformation=true)>
	</cffunction>


<cfscript>

    function typeOfAddRegOptions(){
        return application.wheels.typeOfAddRegOptions;
    }

    function showschedule(){
        if (isDefined("params.dev") OR isDefined("params.showschedule"))
            {return true;}
            else
            {return false;}
    }

    function showworkshops(){
        if (isDefined("params.dev") OR isDefined("params.showworkshops"))
            {return true;}
            else
            {return false;}
    }

    function showspeakers(){
        if (isDefined("params.dev") OR isDefined("params.showspeakers"))
            {return true;}
            else
            {return false;}
    }

    function showsponsors(){
        if (isDefined("params.dev") OR isDefined("params.showsponsors"))
            {return true;}
            else
            {return false;}
    }

    function shownews(){
        if (isDefined("params.dev") OR isDefined("params.shownews"))
            {return true;}
            else
            {return true;}
    }

    function shownewsletter(){
        if (isDefined("params.dev") OR isDefined("params.shownewsletter"))
            {return true;}
            else
            {return true;}
    }

    function showchildcare(){
        if (isDefined("params.dev") OR isDefined("params.showchildcare"))
            {return true;}
            else
            {return true;}
    }

    function twitterUrl(){
        return "https://twitter.com/margins2016";
    }

    function facebookUrl(){
        return "https://www.facebook.com/margins2016";
    }

    function vimeoUrl(){
        return "https://vimeo.com/channels/margins2016";
    }

    function nameForCourse(){
        return application.wheels.nameForCourse;
    }

    function typesOfCourses(){
        return application.wheels.typesOfCourses;
    }

    function subTypesOfCourses(){
        return application.wheels.subTypesOfCourses;
    }

    function showSubTypesOfCourses(){
        var show = false;
        if (gotRights("office") || application.wheels.showSubTypesOfCourses){
            show = true;
        }
        return show;
    }

    function tracksOfCourses(){
        return application.wheels.tracksOfCourses;
    }

    function eventDaysOptions(){
        return application.wheels.eventDaysOptions;
    }

    function eventFirstDaysOptionsDate(){
        return application.wheels.eventFirstDaysOptionsDate;
    }

    function workshopnotifications(){
        return application.wheels.workshopnotifications;
    }

    function showFacilitatorsWithCourse(){
        return application.wheels.showFacilitatorsWithCourse;
    }

    function workshopsEventsAreSet(){
        if (application.wheels.workshopsEventsAreSet){
            return true;}
        else {
            return false;
            }    
    }

    function workshopNotificationsOpen(){
        if (application.wheels.workshopNotificationsOpen || gotrights("office")){
            return true;}
        else {
            return false;
            }    
    }

    function eventCategories(){
        return listSort(application.wheels.eventCategories,"text");
    }

    //turns the types of courses into a comma delimited list of types as singular terms//
    function typesOfCoursesForDropdown(){
        var list = replace(application.wheels.typesOfCourses," ","","all");
        var i = 0;
        var newlist = "";
        for (i=1; i lte listLen(list); i++){
           newlist = newlist & "," & singularize(ListGetAt(list, #i#));     
        };
        newlist = replace(newlist,",","");
        return newlist;
    }

    function nameForCourses(){
        return application.wheels.nameForCourses;
    }

    function registrationOpen(){
        return true;
    }

    function getDiscountTypes(){
        return application.wheels.discountTypes;
    }

    function getDollarType(){
        return application.wheels.dollar;
    }

    function getChildcareRegistrationDeadline() {
        return application.wheels.ccareregistrationDeadline;
    }

    function clearSession(){
        StructClear(session);
        return true;
    }

    public function getEmailsForInvoice(invoiceid) {
        var emaillist = "";

        try {
            var invoice = model("Conferenceinvoice").findOne(where="id=#invoiceid#");
            if (isObject(invoice) && invoice.ccemail NEQ "NA") {
                emaillist = invoice.ccemail;
            };
           if (isObject(invoice) && isValid("email",invoice.agent)) {
                if (!find(invoice.agent,emaillist)){
                    emaillist = emaillist & ";" & invoice.agent;
                }
            }

            var person = model("Conferenceregistration").findAll(where="equip_invoicesID = #invoiceid#", include="person(family)");
            for (i=1; i LTE person.recordcount; i=i+1){
                if (!find(person.email,emaillist)){
                emaillist = emaillist & ";" & person["email"][i];
                }
            }
            emailist = replace(emaillist,";","","one");
        }
        catch(any e){};
        return emaillist;
    }

    function getGroupCountAvailable(){
        var counts = "";
        if (isDefined("params.useoptionscount")){
            counts = application.wheels.optionsCountAvailable;
        }
        else {
            counts = application.wheels.groupCountAvailable;
        }
        return counts;
    }

    function getOptionsCountAvailable(){
        return application.wheels.optionsCountAvailable;
    }

    function getRegStatus(status){
        switch(status) {
    case "1":
         return "paid";
         break;
    case "0":
        if (!gotRights("office")){
            return "UnPaid";
            }
         else {
            return "Temp";
         };
         break;
    case "temp":     
        if (!gotRights("office")){
            return "<span style='color:red'>UnPaid</span>";
            }
         else {
            return "Temp";
         };
         break;
    default:
         return status;
    }
        }

    public function changeSessionSettingsToPreviousConference(){
            session.settings.event = application.wheels.previousevent;
            session.settings.eventastext = application.wheels.previouseventastext;
            redirectTo(controller="conference.registrations", action="index");
    }

    public function clearSessionSettingsForEvent(){
            structDelete(session.settings, "event");
            structDelete(session.settings, "eventAsText");
            redirectTo(controller="conference.registrations", action="index");
   }

</cfscript>

</cfcomponent>