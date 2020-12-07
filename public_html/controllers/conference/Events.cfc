component extends="Controller" output="false" {

	writeOutput("//TODO: Change to cfscript");

	public function config() {
		usesLayout("/conference/adminlayout");
		filters(through="getEvents,getLocations,getCourses", except="update,create,delete");
		filters(through="officeOnly", except="index,summary,show,listScheduleAsJson,listMealsAsJson,listExcursionsAsJson,listOtherEventsAsJson,generalInfo,testCopy,copyCategoryToNextDay");
		filters(through="setreturn", only="index,show");
	}
	// --------
	// Filters
	// --------

	public function getEvents() {
		var thisEvent = getSetting("event");
		events = model("Conferenceoption").findall(where="event='#thisEvent#'", order="type DESC");
	}

	public function getLocations() {
		locations = model("Conferencelocation").findall(where="event='#getEvent()#'", order="roomnumber");
	}

	public function getCourses() {
		courses = model("Conferencecourse").findall(where="event='#getEvent()#'", order="title");
	}
	// --------
	// --------
	// CCRUD
	// --------
	//  conference/events/index 

	public function index() {
		var loc=structNew();
		loc.today = CreateDate(Year(Now()),Month(Now()),Day(Now()));
		loc.orderbystring = "eventDate,timebegin,category,roomnumber,description";
		if ( isDefined("params.category") && isDefined("params.date") ) {
			events = model("Conferenceevent").findAll(where="category='#params.category#' AND event='#getEvent()#' AND date like '#params.date#%'", include="location", order=loc.orderbystring);
			session.return = params.category;
		} else if ( isdefined("params.category") && params.category != "all" ) {
			events = model("Conferenceevent").findAll(where="category='#params.category#' AND event='#getEvent()#'", include="location", order=loc.orderbystring);
			session.return = params.category;
		} else if ( isdefined("params.category") && params.category == "all" ) {
			events = model("Conferenceevent").findAll(where="event='#getEvent()#'", include="location", order=loc.orderbystring);
		} else if ( isDefined("params.desc") ) {
			params.desc = left(desc,5);
			events = model("Conferenceevent").findAll(where="event='#getEvent()#' && description like '#params.desc#%'", include="location", order=loc.orderbyString);
		} else if ( isDefined("params.locationid") ) {
			events = model("Conferenceevent").findAll(where="event='#getEvent()#' AND locationid = #params.locationid#", include="location", order=loc.orderbyString);
		} else {
			events = model("Conferenceevent").findAll(where="event='#getEvent()#'", include="location", order=loc.orderbystring);
			if ( isdefined("session.return") ) {
				structDelete(session,"return");
			}
		}
	}
	//  conference/events/show/key 

	public function show() {
		//  Find the record 
		event = model("Conferenceevent").findByKey(key=params.key, include="location,course");
		instructors = model("Conferenceevent").findInstructors(params.key);
		//  Check if the record exists 
		if ( !IsObject(event) ) {
			flashInsert(error="Event #params.key# was !found");
			redirectTo(action="index");
		}
	}
	//  conference/events/new 

	public function new() {
		event = model("Conferenceevent").new();
		event.event = getEvent();
	}
	//  conference/events/edit/key 

	public function edit() {
		//  Find the record 
		event = model("Conferenceevent").findByKey(key=params.key, include="location");
		try {
			event.day = DayOfWeekAsString(dayOfWeek(event.date));
		} catch (any cfcatch) {
		}
		//  Check if the record exists 
		if ( !IsObject(event) ) {
			flashInsert(error="Event #params.key# was !found");
			redirectTo(action="index");
		}
	}
	//  conference/events/create 

	public function create() {
		var newlocation="";
		event = model("Conferenceevent").new(params.event);
		if ( isdefined("params.event.day") ) {
			event.date = dayToDate(params.event.day);
		}
		if ( len(params.event.newlocation) ) {
			newlocation = model("Conferencelocation").create(roomnumber=params.event.newlocation);
			event.locationid = newlocation.id;
		}
		// add a new course and connect if field is defined
		if ( isDefined("params.event.newCourseName") && len(params.event.newCourseName) ) {
			var newCourse = model("Conferencecourse").create(title=params.event.newCourseName, type="other", event=getEvent());
			event.courseid = newCourse.id;
		}
		//  Verify that the event creates successfully 
		if ( event.save() ) {
			flashInsert(success="The event was created successfully.");
			if ( isdefined("session.return") ) {
				returnBack();
			} else {
				redirectTo(action="index");
			}
			//  Otherwise 
		} else {
			flashInsert(error="There was an error creating the event.");
			renderView(action="new");
		}
	}
	//  conference/events/copy 

	public function copy() {
		//  Find the record 
		event = model("Conferenceevent").findByKey(key=params.key, include="location");
		event.day = DayOfWeekAsString(dayOfWeek(event.date));
		//  Check if the record exists 
		if ( !IsObject(event) ) {
			flashInsert(error="Event #params.key# was !found");
			redirectTo(action="index");
		}
		renderView(action="new");
	}
	//  conference/events/copyAllToCurrentEvent 

	public function copyAllToCurrentEvent(){
			super.copyAllToCurrentEvent( tableName = "Conferenceevent" );
			returnBack();
		}
	//  conference/events/update 

	public function update() {
		if ( isDefined("params.keyy") ) {
			params.key = params.keyy;
		}
		event = model("Conferenceevent").findByKey(params.key);
		if ( isdefined("params.event.day") ) {
			event.date = dayToDate(params.event.day);
		}
		if ( isdefined("params.event.newlocation") && len(params.event.newlocation) ) {
			params.event.locationid = model("Conferencelocation").create(roomnumber=params.event.newlocation).id;
		}
		// add a new course and connect if field is defined
		if ( isDefined("params.event.newCourseName") && len(params.event.newCourseName) ) {
			var newCourse = model("Conferencecourse").create(title=params.event.newCourseName, type="other", event=getEvent());
			event.courseid = newCourse.id;
		}
		//  Verify that the event updates successfully 
		if ( event.update(params.event) ) {
			flashInsert(success="The event was updated successfully.");
			returnBack();
			//  Otherwise 
		} else {
			flashInsert(error="There was an error updating the event.");
			renderView(action="edit", layout="/adminlayout");
		}
	}
	//  conference/events/delete/key 

	public function delete() {
		event = model("Conferenceevent").findByKey(params.key);
		//  Verify that the event deletes successfully 
		if ( event.delete() ) {
			flashInsert(success="The event was deleted successfully.");
			returnBack();
			//  Otherwise 
		} else {
			flashInsert(error="There was an error deleting the event.");
			redirectTo(action="index", layout="/adminlayout");
		}
	}

	private function createNewCourseForEvent(courseName){
		var newCourse = model("Conferencecourse").new();
		newCourse.title = courseName;
		newCourse.descriptionlong = "";
		newCourse.event = getEvent();
		newCourse.display = "No";
		newCourse.track = "Other";
		writeDump(newCourse.properties());abort;		
		if (newCourse.save()){
			return newCourse.id;
			}
				else
			{
				return false;
			};
	}
	// ---------------------------
	// --------
	// Need to edit this each year-
	// --------

	private function dayToDate(required string day) {
		var loc = arguments;
		loc.dates = structNew();
		loc.counter = 0;
		for ( loc.i in eventDaysOptions() ) {
			loc.dates[loc.i] = dateAdd("d",loc.counter,eventFirstDaysOptionsDate());
			loc.dates[loc.i] = dateAdd("h",3,loc.dates[loc.i]);
			loc.counter = loc.counter + 1;
		}
		return loc.dates[loc.day];
	}

	public function testDayToDate() {
		return dayToDate("Tuesday");
		writeDump( var=return );
		abort;
	}
	// --------------------------
	// --------
	// Misc-
	// --------

	public function fixdates() {
		for ( i in "timebegin,timeend" ) {
			try {
				params.events[i]= createodbcdate(params.events[i]+1);
			} catch (any cfcatch) {
			}
		}
	}

	public function eachList(required string category, string startTime, string date) {
		var thislist="";
		if ( isdefined("arguments.starttime") && isdefined("arguments.date") ) {
			thislist = model("Conferenceevent").findAll(where="category='#arguments.category#' AND timeBegin='#arguments.startTime#' AND date = '#arguments.date#'", include="location", order="description");
			return thislist;
		} else if ( isdefined("arguments.starttime") ) {
			thislist = model("Conferenceevent").findAll(where="category='#arguments.category#' AND timeBegin='#arguments.startTime#'", include="location", order="description");
			return thislist;
		} else if ( isdefined("arguments.date") ) {
			thislist = model("Conferenceevent").findAll(where="category='#arguments.category#' AND date = '#arguments.date#'", include="location", order="description");
			return thislist;
		}
	}

	public function Seminars() {
		MondayIM = eachlist(category="Seminar-Integrated Ministries", startTime="9:00", date="2011-07-25");
		MondayLD = eachlist(category="Seminar-Leadership Development", startTime="9:00", date="2011-07-25");
		TuesdayIM = eachlist(category="Seminar-Integrated Ministries", startTime="9:00", date="2011-07-26");
		TuesdayLD = eachlist(category="Seminar-Leadership Development", startTime="9:00", date="2011-07-26");
		MondayMT = eachlist(category="Seminar-Ministry Track", date="2011-07-25");
		TuesdayMT = eachlist(category="Seminar-Ministry Track", date="2011-07-26");
		MondayNet = eachlist(category="Network", date="2011-07-25");
		TuesdayNet = eachlist(category="Network", date="2011-07-26");
		renderView(layout="/layout");
	}

	public function ShowSeminar() {
		event = model("Conferenceevent").findByKey(key=params.key, include="location");
		if ( !IsObject(event) ) {
			renderText("No Seminar Listed");
		}
		renderView(layout="/layout");
	}

	public function excel() {
		events = model("Conferenceevent").findAll(where="event='#getEvent()#'", include="location", order="date,timebegin");
		renderView(layout="/conference/layoutdownload");
	}

	public function datatable() {
		if ( isdefined("session.wheels.datatables") && session.wheels.datatables ) {
			session.wheels.datatables = 0;
		} else {
			session.wheels.datatables = 1;
		}
		redirectTo(action="index");
	}
	// JSON Controllers

	public function listScheduleAsJson() {
		data = model("Conferenceevent").findScheduleAsJson(params);
		renderView(template="/json", layout="/layout_json", hideDebugInformation=true);
	}

	public function listExcursionsAsJson() {
		params.useExcursions = true;
		data = model("Conferenceevent").findScheduleAsJson(params);
		renderView(template="/json", layout="/layout_json", hideDebugInformation=true);
	}

	public function listOtherEventsAsJson() {
		params.useOtherEvents = true;
		data = model("Conferenceevent").findScheduleAsJson(params);
		renderView(template="/json", layout="/layout_json", hideDebugInformation=true);
	}

	public function listMealsAsJson() {
		params.type = "meal";
		data = model("Conferenceevent").findScheduleAsJson(params);
		renderView(template="/json", layout="/layout_json", hideDebugInformation=true);
	}

	public function listMealsAsJson() {
		params.type = "workshop";
		data = model("Conferenceevent").findScheduleAsJson(params);
		renderView(template="/json", layout="/layout_json", hideDebugInformation=true);
	}

	public function generalInfo() {
		renderView(layout="/layout_json", hideDebugInformation=true);
	}

	public function copyCategoryToNextDay(category,date){
	var whereString = "category = '#category#'";
	var events = model("Conferenceevent").findall(where=whereString & " AND date like '#date#%'");
	date = date & " 23:00:00";
	var newdate = dateAdd("d",1,date);
	var newdateformated = dateFormat(newdate,"yyyy-mm-dd");
	var count = 0;
	var tempevent = structNew();
	for 	(
		intRow = 1;
		intRow LTE events.recordcount;
		intRow = (intRow + 1)
		){
			event = model("Conferenceevent").findByKey(events["id"][intRow]);
			structClear(tempevent);
			tempevent.description = event.description;
			tempevent.descriptionschedule = event.descriptionschedule;
			tempevent.descriptionprogram = event.descriptionprogram;
			tempevent.category = event.category;
			tempevent.manager = event.manager;
			tempevent.locationid = event.locationid;
			tempevent.eventid = event.eventid;
			tempevent.timebegin = event.timebegin;
			tempevent.timeend = event.timeend;
			tempevent.attending = event.attending;
			tempevent.equipment = event.equipment;
			tempevent.setup = event.setup;
			tempevent.comment = event.comment;
			tempevent.event = event.event;
			tempevent.date = newdate;
			newevent = model("Conferenceevent").new(tempevent);
			newevent.save();
			count = count +1;
		};
	newevents = model("Conferenceevent").findall(where=whereString & " AND date like '#newdateformated#%'");
	redirectTo(action="index", params="category=#category#&date=#newdateformated#");
}

public function testCopy(){
	var date = "2014-07-21";
	if (isDefined("params.date")) {date = params.date};
	events = copyCategoryToNextDay("Workshop",date);
	writedump(events);
	abort;
}

public function deleteCategoryOnDay(category,date){
	var deleted = model("Conferenceevent").deleteAll(where="category = '#category#' AND date like '#date#%'");
	redirectTo(action="index", params="category=#category#&date=#date#");
}

private function getWorshipTitleForEvent(eventid,description,prefer="course"){
	if (val(eventid) && prefer is "course"){
		var course = model("Conferencecourse").findOne(where="eventid=#eventid#");
		if (isObject(course)) {
			return course.title;
		}
	}
	return description;
}

}
