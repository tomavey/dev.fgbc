<cfcomponent extends="Controller" output="false">
//TODO: Change to cfscript
	<cffunction name="config">
		<cfset usesLayout("/conference/adminlayout")>
		<cfset filters(through="getEvents,getLocations,getCourses", except="update,create,delete")>
		<cfset filters(through="officeOnly", except="index,summary,show,listScheduleAsJson,listMealsAsJson,listExcursionsAsJson,listOtherEventsAsJson,generalInfo,testCopy,copyCategoryToNextDay")>
		<cfset filters(through="setreturn", only="index,show")>
	</cffunction>

<!-------------->
<!---Filters--->
<!-------------->

	<cffunction name="getEvents">
		<cfset var thisEvent = getSetting("event")>
		<cfset events = model("Conferenceoption").findall(where="event='#thisEvent#'", order="type DESC")>
	</cffunction>

	<cffunction name="getLocations">
		<cfset locations = model("Conferencelocation").findall(where="event='#getEvent()#'", order="roomnumber")>
	</cffunction>

	<cffunction name="getCourses">
		<cfset courses = model("Conferencecourse").findall(where="event='#getEvent()#'", order="title")>
	</cffunction>
<!-------------->

<!-------------->
<!---CCRUD--->
<!-------------->

<!--- conference/events/index --->
	<cffunction name="index">
	<cfset var loc=structNew()>

		<cfset loc.today = CreateDate(Year(Now()),Month(Now()),Day(Now()))>
		<cfset loc.orderbystring = "eventDate,timebegin,category,roomnumber,description">
		<cfif isDefined("params.category") AND isDefined("params.date")>
			<cfset events = model("Conferenceevent").findAll(where="category='#params.category#' AND event='#getEvent()#' AND date like '#params.date#%'", include="location", order=loc.orderbystring)>
			<cfset session.return = params.category>
		<cfelseif isdefined("params.category") and params.category NEQ "all">
			<cfset events = model("Conferenceevent").findAll(where="category='#params.category#' AND event='#getEvent()#'", include="location", order=loc.orderbystring)>
			<cfset session.return = params.category>
		<cfelseif isdefined("params.category") and params.category is "all">
			<cfset events = model("Conferenceevent").findAll(where="event='#getEvent()#'", include="location", order=loc.orderbystring)>
		<cfelseif isDefined("params.desc")>
			<cfset params.desc = left(desc,5)>
			<cfset events = model("Conferenceevent").findAll(where="event='#getEvent()#' AND description like '#params.desc#%'", include="location", order=loc.orderbyString)>
		<cfelseif isDefined("params.locationid")>
			<cfset events = model("Conferenceevent").findAll(where="event='#getEvent()#' AND locationid = #params.locationid#", include="location", order=loc.orderbyString)>
		<cfelse>
			<cfset events = model("Conferenceevent").findAll(where="event='#getEvent()#'", include="location", order=loc.orderbystring)>
			<cfif isdefined("session.return")>
				<cfset structDelete(session,"return")>
			</cfif>
		</cfif>
	</cffunction>

<!--- conference/events/show/key --->
	<cffunction name="show">
		<!--- Find the record --->
    	<cfset event = model("Conferenceevent").findByKey(key=params.key, include="location,course")>
    	<cfset instructors = model("Conferenceevent").findInstructors(params.key)>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(event)>
	        <cfset flashInsert(error="Event #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

<!--- conference/events/new --->
	<cffunction name="new">
		<cfset event = model("Conferenceevent").new()>
		<cfset event.event = getEvent()>
	</cffunction>

<!--- conference/events/edit/key --->
	<cffunction name="edit">

		<!--- Find the record --->
    	<cfset event = model("Conferenceevent").findByKey(key=params.key, include="location")>

		<cftry>
			<cfset event.day = DayOfWeekAsString(dayOfWeek(event.date))>
			<cfcatch></cfcatch>
		</cftry>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(event)>
	        <cfset flashInsert(error="Event #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

<!--- conference/events/create --->
	<cffunction name="create">
	<cfset var newlocation="">

		<cfset event = model("Conferenceevent").new(params.event)>

		<cfif isdefined("params.event.day")>
			<cfset event.date = dayToDate(params.event.day)>
		</cfif>

		<cfif len(params.event.newlocation)>
			<cfset newlocation = model("Conferencelocation").create(roomnumber=params.event.newlocation)>
			<cfset event.locationid = newlocation.id>
		</cfif>

		<!---add a new course and connect if field is defined--->
		<cfif isDefined("params.event.newCourseName") && len(params.event.newCourseName)>
			<cfset var newCourse = model("Conferencecourse").create(title=params.event.newCourseName, type="other", event=getEvent())>
			<cfset event.courseid = newCourse.id>
		</cfif>


		<!--- Verify that the event creates successfully --->
		<cfif event.save()>
			<cfset flashInsert(success="The event was created successfully.")>
			<cfif isdefined("session.return")>
            	<cfset returnBack()>
			<cfelse>
	            <cfset redirectTo(action="index")>
			</cfif>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the event.")>
			<cfset renderView(action="new")>
		</cfif>
	</cffunction>

<!--- conference/events/copy --->
	<cffunction name="copy">

		<!--- Find the record --->
    	<cfset event = model("Conferenceevent").findByKey(key=params.key, include="location")>

			<cfset event.day = DayOfWeekAsString(dayOfWeek(event.date))>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(event)>
	        <cfset flashInsert(error="Event #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>

	    <cfset renderView(action="new")>
	</cffunction>

<!--- conference/events/copyAllToCurrentEvent --->

	<cfscript>
		public function copyAllToCurrentEvent(){
			super.copyAllToCurrentEvent( tableName = "Conferenceevent" );
			returnBack();
		}
	</cfscript>


<!--- conference/events/update --->
	<cffunction name="update">
		<cfif isDefined("params.keyy")>
			<cfset params.key = params.keyy>
		</cfif>

		<cfset event = model("Conferenceevent").findByKey(params.key)>

		<cfif isdefined("params.event.day")>
			<cfset event.date = dayToDate(params.event.day)>
		</cfif>

		<cfif isdefined("params.event.newlocation") and len(params.event.newlocation)>
			<cfset params.event.locationid = model("Conferencelocation").create(roomnumber=params.event.newlocation).id>
		</cfif>

		<!---add a new course and connect if field is defined--->
		<cfif isDefined("params.event.newCourseName") && len(params.event.newCourseName)>
			<cfset var newCourse = model("Conferencecourse").create(title=params.event.newCourseName, type="other", event=getEvent())>
			<cfset event.courseid = newCourse.id>
		</cfif>

		<!--- Verify that the event updates successfully --->
		<cfif event.update(params.event)>
			<cfset flashInsert(success="The event was updated successfully.")>
           	<cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the event.")>
			<cfset renderView(action="edit", layout="/adminlayout")>
		</cfif>
	</cffunction>

<!--- conference/events/delete/key --->
	<cffunction name="delete">

		<cfset event = model("Conferenceevent").findByKey(params.key)>

		<!--- Verify that the event deletes successfully --->
		<cfif event.delete()>
			<cfset flashInsert(success="The event was deleted successfully.")>
            	<cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the event.")>
			<cfset redirectTo(action="index", layout="/adminlayout")>
		</cfif>
	</cffunction>

<cfscript>
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
</cfscript>
<!--------------------------------->

<!-------------->
<!---Need to edit this each year---->
<!-------------->

	<cffunction name="dayToDate" access="private">
	<cfargument name="day" required="yes"  type="string">
	<cfset var loc = arguments>
	<cfset loc.dates = structNew()>
	<cfset loc.counter = 0>
	<cfloop index="loc.i" list="#eventDaysOptions()#"> 
		<cfset loc.dates[loc.i] = dateAdd("d",loc.counter,eventFirstDaysOptionsDate())>
		<cfset loc.dates[loc.i] = dateAdd("h",3,loc.dates[loc.i])>
		<cfset loc.counter = loc.counter + 1>
	</cfloop>

	<cfreturn loc.dates[loc.day]>

	</cffunction>

	<cffunction name="testDayToDate">
		<cfset return = dayToDate("Tuesday")>
		<cfdump var="#return#"><cfabort>
	</cffunction>
<!-------------------------------->

<!-------------->
<!---Misc---->
<!-------------->
	<cffunction name="fixdates">
		<cfloop list="timebegin,timeend" index="i">
			<cftry>
			<cfset  params.events[i]= createodbcdate(params.events[i]+1)>
			<cfcatch></cfcatch></cftry>
		</cfloop>
	</cffunction>

	<cffunction name="eachList">
	<cfargument name="category" required="true" type="string">
	<cfargument name="startTime" required="false" type="string">
	<cfargument name="date" required="false" type="string">
	<cfset var thislist="">
		<cfif isdefined("arguments.starttime") and isdefined("arguments.date")>
			<cfset thislist = model("Conferenceevent").findAll(where="category='#arguments.category#' AND timeBegin='#arguments.startTime#' AND date = '#arguments.date#'", include="location", order="description")>
			<cfreturn thislist>
		<cfelseif isdefined("arguments.starttime")>
			<cfset thislist = model("Conferenceevent").findAll(where="category='#arguments.category#' AND timeBegin='#arguments.startTime#'", include="location", order="description")>
			<cfreturn thislist>
		<cfelseif isdefined("arguments.date")>
			<cfset thislist = model("Conferenceevent").findAll(where="category='#arguments.category#' AND date = '#arguments.date#'", include="location", order="description")>
			<cfreturn thislist>
		</cfif>
	</cffunction>

	<cffunction name="Seminars">
		<cfset MondayIM = eachlist(category="Seminar-Integrated Ministries", startTime="9:00", date="2011-07-25")>
		<cfset MondayLD = eachlist(category="Seminar-Leadership Development", startTime="9:00", date="2011-07-25")>
		<cfset TuesdayIM = eachlist(category="Seminar-Integrated Ministries", startTime="9:00", date="2011-07-26")>
		<cfset TuesdayLD = eachlist(category="Seminar-Leadership Development", startTime="9:00", date="2011-07-26")>
		<cfset MondayMT = eachlist(category="Seminar-Ministry Track", date="2011-07-25")>
		<cfset TuesdayMT = eachlist(category="Seminar-Ministry Track", date="2011-07-26")>
		<cfset MondayNet = eachlist(category="Network", date="2011-07-25")>
		<cfset TuesdayNet = eachlist(category="Network", date="2011-07-26")>
		<cfset renderView(layout="/layout")>
	</cffunction>

	<cffunction name="ShowSeminar">
    	<cfset event = model("Conferenceevent").findByKey(key=params.key, include="location")>
	    <cfif NOT IsObject(event)>
	    	<cfset renderText("No Seminar Listed")>
	    </cfif>
		<cfset renderView(layout="/layout")>
	</cffunction>

	<cffunction name="excel">
		<cfset events = model("Conferenceevent").findAll(where="event='#getEvent()#'", include="location", order="date,timebegin")>
		<cfset renderView(layout="/conference/layoutdownload")>
	</cffunction>

	<cffunction name="datatable">
		<cfif isdefined("session.wheels.datatables") AND session.wheels.datatables>
			<cfset session.wheels.datatables = 0>
		<cfelse>
			<cfset session.wheels.datatables = 1>
		</cfif>
		<cfset redirectTo(action="index")>
	</cffunction>

<!---JSON Controllers--->

	<cffunction name="listScheduleAsJson">
		<cfset data = model("Conferenceevent").findScheduleAsJson(params)>
       	<cfset renderView(template="/json", layout="/layout_json", hideDebugInformation=true)>
	</cffunction>

	<cffunction name="listExcursionsAsJson">
		<cfset params.useExcursions = true>
		<cfset data = model("Conferenceevent").findScheduleAsJson(params)>
       	<cfset renderView(template="/json", layout="/layout_json", hideDebugInformation=true)>
	</cffunction>

	<cffunction name="listOtherEventsAsJson">
		<cfset params.useOtherEvents = true>
		<cfset data = model("Conferenceevent").findScheduleAsJson(params)>
       	<cfset renderView(template="/json", layout="/layout_json", hideDebugInformation=true)>
	</cffunction>

	<cffunction name="listMealsAsJson">
	<cfset params.type = "meal">
		<cfset data = model("Conferenceevent").findScheduleAsJson(params)>
	        	<cfset renderView(template="/json", layout="/layout_json", hideDebugInformation=true)>
	</cffunction>

	<cffunction name="listMealsAsJson">
	<cfset params.type = "workshop">
		<cfset data = model("Conferenceevent").findScheduleAsJson(params)>
	        	<cfset renderView(template="/json", layout="/layout_json", hideDebugInformation=true)>
	</cffunction>

	<cffunction name="generalInfo">
	        	<cfset renderView(layout="/layout_json", hideDebugInformation=true)>
	</cffunction>


<cfscript>

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

</cfscript>
</cfcomponent>

