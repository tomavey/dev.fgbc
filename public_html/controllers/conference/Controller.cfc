component extends="controllers.Controller" {

	public function isBefore(required date date) {
		if ( datecompare(now(),arguments.date) == -1 ) {
			return 1;
		} else {
			return 0;
		}
	}

	public function sendMonitoringEmail() {
		if ( getSetting('Monitoring') ) {
			sendemail(from="tomavey@fgbc.org", to="tomavey@fgbc.org", template="emailparams", subject="V2020 Params", layout="layout_for_email");
		}
	}

	public function inAuthGroup() {
	}

	public function officeOnly() {
		if ( isDefined("params.key") && params.key == "kkjhdgwerlkjshdghhjkskjhd" ) {
			session.vision2020admin = 1;
		} else if ( isDefined("params.office") && params.office == "kkjhdgwerlkjshdghhjkskjhd" ) {
			session.vision2020admin = 1;
		} else if ( gotRights("superadmin,office") ) {
			session.vision2020admin = 1;
		}
		if ( !isDefined("session.vision2020admin") || !session.vision2020admin ) {

			writeOutput("Sorry, you do not have permission to view this page!");
			abort;
		}
	}

	public function getEvent() {

		if ( isDefined("params.event" )) { return params.event }
		return getSetting("event");
	}

	public function getPreviousEvent() {
		return getSetting("previousEvent");
	}

	public function getEventAsText() {
		return getSetting("eventAsText");
	}

	public function getEventAsTextA() {
		var loc.eventA = getEventAsText();
		var f = left(loc.eventA,1);
		if ( f == "A" || f == "E" || f == "I" || f == "O" || f == "U" ) {
			loc.eventA = ("An " & loc.eventA);
		} else {
			loc.eventA = ("A " & loc.eventA);
		}
		return loc.eventA;
	}

	public function getEventAsUrlEncodedText() {
		var event = "";
		if ( isDefined("params.eventAsText") ) {
			event = params.eventAsText;
		} else {
			event = getSetting('eventAsText');
		}
		event = replace(event," ","%20","all");
		return trim(event);
	}

	public function getNextEvent() {
		return getSetting('nextEvent');
	}

	private function getSpouse(required numeric id) {
		var loc=structNew();
		loc.thisperson = model("Conferenceperson").findOne(where="id=#arguments.id#", include="family");
		if ( isObject(loc.thisperson) && loc.thisperson.type == "Adult" ) {
			loc.spouse = model("Conferenceperson").findOne(where="equip_familiesid=#loc.thisperson.equip_familiesid# AND type='spouse'", include="family");
			if ( isObject(loc.spouse) ) {
				loc.return.id = loc.spouse.id;
				loc.return.fname = loc.spouse.fname;
				loc.return.equip_prayer_tripletsid = loc.spouse.equip_prayer_tripletsid;
				loc.return.email = loc.spouse.email;
			} else {
				loc.return.id = "";
				loc.return.fname = "";
				loc.return.equip_prayer_tripletsid = "";
				loc.return.email = "";
			}
		} else if ( isObject(loc.thisperson) && loc.thisperson.type == "spouse" ) {
			loc.adult = model("Conferenceperson").findOne(where="equip_familiesid=#loc.thisperson.equip_familiesid# AND type='Adult'", include="family");
			if ( isObject(loc.adult) ) {
				loc.return.id = loc.adult.id;
				loc.return.fname = loc.adult.fname;
				loc.return.equip_prayer_tripletsid = loc.adult.equip_prayer_tripletsid;
				loc.return.email = loc.adult.email;
			} else {
				loc.return.id = "";
				loc.return.fname = "";
				loc.return.equip_prayer_tripletsid = "";
				loc.return.email = "";
			}
		} else {
			loc.return.id = "";
			loc.return.fname = "";
			loc.return.equip_prayer_tripletsid = "";
			loc.return.email = "";
		}
		return loc.return;
	}

	public function testGetSpouse(id="#params.key#") {
		return getSpouse(arguments.id);
		writeDump( var=return );
		abort;
	}

	public function getConfUrl() {
		return getSetting('webpage');
	}
	// ----------------------------------------
	// Getters for what is open and what is not
	// ----------------------------------------

	public function regIsOpen(){
        if (getSetting("registrationIsOpen") OR gotRights("office") || isDefined("params.openreg") || isDefined("session.auth.openreg")){
            return true;
        } else {
            return false;
        }
    }    

    public function regRegIsOpen(){
        if (getSetting("regRegIsOpen") OR gotRights("office") || isDefined("params.openreg") || isDefined("session.auth.openreg")){
            return true;
        } else {
            return false;
        }
    }    

    public function workshopsRegOpen(){
    	if (getSetting("workshopsRegIsOpen") OR gotRights("office") or isDefined("params.openreg") || (isDefined("session.auth.openWorkshops") && session.auth.openWorkshops)){
            return true;
        } else {
            return false;
        }
    }    

    public function preRegIsOpen(){
        if (getSetting("preregistrationIsOpen")) {
            return true;
        }
        else {
            return false;
        }
    }

    public function groupRegIsOpen(){
        if (getSetting("groupregistrationIsOpen") || gotRights("office") || isDefined(
        "params.opengroupsreg") || isDefined("session.auth.opengroupsreg")) {
            return true;
        }
        else {
            return false;
        }
    }

    public function myRegsIsOpen(){
        if (getSetting("regAccountIsOpen") || gotRights("office") || isDefined(
        "params.openmyregs") || isDefined("session.auth.openmyregs")) {
            return true;
        }
        else {
            return false;
        }
    }

    public function convertGroupRegIsOpen(){
        if (getSetting("convertGroupRegistrationIsOpen") || gotRights("office") || isDefined(
        "params.convertGroupRegistrationIsOpen") || isDefined("session.auth.convertGroupRegistrationIsOpen")) {
            return true;
        }
        else {
            return false;
        }
    }

    public function mealsRegIsOpen(){
        if (getSetting("mealsregistrationIsOpen") || gotRights("office") || isDefined("params.openreg") || isDefined("session.auth.openreg")) {
            return true;            
        }
        else {
            return false;
        }
    }    

    public function childRegIsOpen(){
        if ((getSetting("ccareregistrationIsOpen") && isBefore(getSetting("ccareregistrationDeadline"))) OR gotRights("office") or isDefined("params.openreg") || isDefined("session.auth.openreg")){
            return true;
        }
        else {
            return false;
        }
    }

    public function regAccountIsOpen(){
        if (getSetting("regAccountIsOpen") OR gotRights("office") or isDefined("params.openreg") || isDefined("session.auth.openreg")){
            return true;
        }
        else {
            return false;
        }
    }

    public function optionsRegIsOpen(){
        if (getSetting("optionsregistrationIsOpen") || isDefined("params.openreg")){
            return true;
        }
        else {
            return false;
        };
    }

    public function optionsregistrationIsOpen(){
        return optionsRegIsOpen()
    }

    public function regOpenPromiseDate(){
        return getSetting("regOpenPromiseDate");
    }

	public function hasThisPersonSelectedWorkshops(required numeric personid, type="workshop", workshopid="0") {
		whereString = "equip_peopleid = #arguments.personid# AND equip_optionsid = #getOptionIdFromName(arguments.type)#";
		if ( arguments.workshopid ) {
			whereString = whereString & " AND equip_coursesid = #arguments.workshopid#";
		} else {
			whereString = whereString & " AND equip_coursesid <> 0";
		}
		workshop = model("Conferenceregistration").findOne(where=whereString);
		if ( isObject(workshop) ) {
			return true;
		} else {
			return false;
		}
	}

	public function getOptionIdFromName(required string name) {
		var loc=arguments;
		loc.optionid = model("Conferenceoption").findOne(where="name='#loc.name#'").id;
		return loc.optionid;
	}

	public function renderJson() {
		renderView(layout="/layout_json", template="/json", hideDebugInformation=true);
	}

	function typeOfAddRegOptions(){
        return getSetting('typeOfAddRegOptions');
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
        return getSetting('nameForCourse');
    }

    function typesOfCourses(){
        return getSetting('typesOfCourses');
    }

    function subTypesOfCourses(){
        return getSetting('subTypesOfCourses');
    }

    function showSubTypesOfCourses(){
        var show = false;
        if (gotRights("office") || getSetting('showSubTypesOfCourses')){
            show = true;
        }
        return show;
    }

    function tracksOfCourses(){
        return getSetting('tracksOfCourses');
    }

    function eventDaysOptions(){
        return getSetting('eventDaysOptions');
    }

    function eventFirstDaysOptionsDate(){
        return getSetting('eventFirstDaysOptionsDate');
    }

    function workshopnotifications(){
        return getSetting('workshopnotifications');
    }

    function showFacilitatorsWithCourse(){
        return getSetting('showFacilitatorsWithCourse');
    }

    function workshopsEventsAreSet(){
        if (getSetting('workshopsEventsAreSet')){
            return true;}
        else {
            return false;
            }    
    }

    function workshopNotificationsOpen(){
        if (getSetting('workshopNotificationsOpen') || gotrights("office")){
            return true;}
        else {
            return false;
            }    
    }

    function eventCategories(){
        return listSort(getSetting('eventCategories'),"text");
    }

    //turns the types of courses into a comma delimited list of types as singular terms//
    function typesOfCoursesForDropdown(){
        var list = replace(getSetting('typesOfCourses')," ","","all");
        var i = 0;
        var newlist = "";
        for (i=1; i lte listLen(list); i++){
           newlist = newlist & "," & singularize(ListGetAt(list, #i#));     
        };
        newlist = replace(newlist,",","");
        return newlist;
    }

    function nameForCourses(){
        return getSetting('nameForCourses');
    }

    function registrationOpen(){
        return true;
    }

    function getDiscountTypes(){
        return getSetting('discountTypes');
    }

    function getDollarType(){
        return getSetting('dollar');
    }

    function getChildcareRegistrationDeadline() {
        return getSetting('ccareregistrationDeadline');
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
        if (isDefined("params.useoptionscount") || gotRights('office')){
            counts = getSetting('optionsCountAvailable');
        }
        else {
            counts = getSetting('groupCountAvailable');
        }
        return counts;
    }

    function getOptionsCountAvailable(){
        return getSetting('optionsCountAvailable');
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
            session.settings.event = getSetting('previousevent');
            session.settings.eventastext = getSetting('previouseventastext');
            redirectTo(controller="conference.registrations", action="index");
    }

    public function clearSessionSettingsForEvent(){
            structDelete(session.settings, "event");
            structDelete(session.settings, "eventAsText");
            redirectTo(controller="conference.registrations", action="index");
   }

    public function copyAllToCurrentEvent(required tableName){
        var neweventname = getEvent();
        var oldeventname =  getPreviousEvent();
        var oldItems = model(tableName).findAll(where="event='#oldeventname#'");
        var newItems = model(tableName).new();
        var thisItem = {};
        for ( var i=1; i lte oldItems.recordcount; i=i+1 ){
            thisItem = queryGetRow(oldItems, i);
            thisItem.event = neweventname;
            structDelete(thisItem, 'id');
            newItems.create(thisItem);
        }
        newItems = model(tableName).findAll(where="event='#neweventname#'");
        return true;
    }

    private function $getMaxrows(args = params){
		if ( isDefined("args.maxrows") ) {
			return args.maxrows
		} else {
			return -1
		}
	}

}
