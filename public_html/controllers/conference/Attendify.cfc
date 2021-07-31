component extends="Controller" {

<!---Overrides settings.cfm--->
public function getEvent() {
  return "visionconference2017";
}

<!---Only Public Functions for /conference.attendify/schema --->

public function json(){

    data = everythingAsJson();
    renderJson();

}

public function schema(){

    data = everythingAsJson();
    renderJson();

}
<!---End of public method--->

private function everythingAsJson(){
   savecontent variable="data" {
        writeOutput('
{
  "features": [
    {
      "name": "Schedule",
      "settings": {
        "type": "schedule-settings",
        "timeFormat": "12",
        "timeZone": "US/Eastern",
        "multiTrack": true
      },
      "type": "feature-schedule",
      "icon": "13",
      "id": "98G5YCtcYNE2STBHsn",
      "sessions": [#scheduleAsJson()#]
    },
    {
      "speakers": [  #speakersAsJson()#  ],
      "name": "Our Speakers",
      "type": "feature-speakers",
      "icon": "69",
      "id": "98G5YCtcYNE2STBHsp",
      "sorting": "lastName"
    },
    {
      "speakers": [  #personalitiesAsJson()#  ],
      "name": "Personalities",
      "type": "feature-speakers",
      "icon": "69",
      "id": "98G5YCtcYNE2STBHs3",
      "sorting": "lastName"
    },
    {
      "name": "Twitter",
      "type": "feature-twitter",
      "icon": "100",
      "id": "98G5YCtcYNE2STBHsw",
      "sorting": "manual",
      "queries": [
        {
          "type": "twitter",
          "term": "@accessfgbc"
        }
      ]
    }
  ]
}
');
    };
    return(data);

}

<!---Methods to create json objects for the json array--->
private function scheduleAsJson(){
    var categories = "'meal','celebration','workshop','other-public','excursion','cohort'";
    var index = 0;
    var jsonString = "";
    var excludeCategory = "none";
    var events = model("Conferenceevent").findall(where="event='#getevent()#' AND category IN (#categories#)", include="location,option");
    if (!workshopsEventsAreSet()){excludeCategory = "cohort"};
    for (index = 1; index LE events.recordcount; index = index +1) {
      if (events.category[index] NEQ excludeCategory){
        jsonString = jsonString & '
        {
          "description": "#sanitizeDescription(left(getDescriptionForEvent(events.id[index]),11200))#",
          "speakers": [#getInstructors(events.id[index])#],
          "startTime": "#makeDateTime(events.date[index],events.timebegin[index])#",
          "endTime": "#makeDateTime(events.date[index],events.timeend[index])#",
          "type": "schedule-session",
          "title": "#getTitleForEvent(events.id[index])#",
          "id": "#events.id[index]#",
          "files": [],
          "location": "#events.roomnumber[index]#",
          "tracks": [#gettracks(events.id[index])#]
        },'
      }
    };

    if (!workshopsEventsAreSet()){
      jsonString = jsonString & defaultCohortsAsJson();
    };
    if (len(jsonString)) {
      jsonString = left(jsonString,len(jsonString)-1);
    };
    return jsonString;
    writedump(events);abort;
    writeOutput(jsonString);abort;
}

private function defaultCohortsAsJson(){
  var jsonString = '{
          "description": "Access Relationships Start Here! Each attendee can participate in two cohorts. A-Cohorts meet Tuesday morning, afternoon and Wednesday morning. Use the Cohorts link in the menu to see the list. Actual locations and times will",
          "speakers": [],
          "startTime": "2017-07-25T11:15:00-0400",
          "endTime": "2017-07-25T12:15:00-0400",
          "type": "schedule-session",
          "title": "A Cohorts",
          "id": "ACohorts1",
          "files": [],
          "location": "Cohort - Location TBD",
          "tracks": [{"color":"##ffffff","name":"Cohort"}]
        },{
          "description": "Access Relationships Start Here! Each attendee can participate in two cohorts. A-Cohorts meet Tuesday morning, afternoon and Wednesday morning. Use the Cohorts link in the menu to see the list. Actual locations and times will",
          "speakers": [],
          "startTime": "2017-07-25T15:00:00-0400",
          "endTime": "2017-07-25T17:00:00-0400",
          "type": "schedule-session",
          "title": "A Cohorts",
          "id": "ACohorts2",
          "files": [],
          "location": "Cohort - Location TBD",
          "tracks": [{"color":"##ffffff","name":"Cohort"}]
        },{
          "description": "Access Relationships Start Here! Each attendee can participate in two cohorts. A-Cohorts meet Tuesday morning, afternoon and Wednesday morning. Use the Cohorts link in the menu to see the list. Actual locations and times will",
          "speakers": [],
          "startTime": "2017-07-26T09:30:00-0400",
          "endTime": "2017-07-26T11:30:00-0400",
          "type": "schedule-session",
          "title": "A Cohorts",
          "id": "ACohorts3",
          "files": [],
          "location": "Cohort - Location TBD",
          "tracks": [{"color":"##ffffff","name":"Cohort"}]
        },{
          "description": "Access Relationships Start Here! Each attendee can participate in two cohorts. B-Cohorts meet Wednesday afternoon, Thursday morning and afternoon. Use the Cohorts link in the menu to see the list. Actual locations and times will",
          "speakers": [],
          "startTime": "2017-07-26T14:00:00-0400",
          "endTime": "2017-07-26T16:00:00-0400",
          "type": "schedule-session",
          "title": "B Cohorts",
          "id": "BCohorts1",
          "files": [],
          "location": "Cohort - Location TBD",
          "tracks": [{"color":"##ffffff","name":"Cohort"}]
        },{
          "description": "Access Relationships Start Here! Each attendee can participate in two cohorts. B-Cohorts meet Wednesday afternoon, Thursday morning and afternoon. Use the Cohorts link in the menu to see the list. Actual locations and times will",
          "speakers": [],
          "startTime": "2017-07-27T09:30:00-0400",
          "endTime": "2017-07-27T11:30:00-0400",
          "type": "schedule-session",
          "title": "B Cohorts",
          "id": "BCohorts2",
          "files": [],
          "location": "Cohort - Location TBD",
          "tracks": [{"color":"##ffffff","name":"Cohort"}]
        },{
          "description": "Access Relationships Start Here! Each attendee can participate in two cohorts. B-Cohorts meet Wednesday afternoon, Thursday morning and afternoon. Use the Cohorts link in the menu to see the list. Actual locations and times will",
          "speakers": [],
          "startTime": "2017-07-27T14:00:00-0400",
          "endTime": "2017-07-27T16:00:00-0400",
          "type": "schedule-session",
          "title": "B Cohorts",
          "id": "BCohorts3",
          "files": [],
          "location": "Cohort - Location TBD",
          "tracks": [{"color":"##ffffff","name":"Cohort"}]
        },'  
    return jsonString;    
}

private function speakersAsJson(){
    var speakers = model("Conferenceinstructor").findAll(where="event='#getevent()#'", order="fname");
    var index = 0;
    var jsonString = "";
    var image = "";

    for (index = 1; index LE speakers.recordcount; index = index +1){
          if (len(#speakers.pic120x120[index]#)){
              image = "http://www.fgbc.org/images/conference/instructors/" & speakers.pic120x120[index];
          }
          else {
              image="";
          };
          jsonString = jsonString & '
              {
            "description": "#sanitizeDescription(speakers.bioweb[index])#",
            "email": "#speakers.email[index]#",
            "groups": [],
            "phone": "",
            "firstName": "#speakers.fname[index]#",
            "type": "speaker",
            "photo": "#image#",
            "id": "#speakers.id[index]#",
            "lastName": "#speakers.lname[index]#",
            "files": [],
            "position": "",
            "sessions": [],
            "company": ""
          },'
        };
    if (len(jsonString)) {
      jsonString = left(jsonString,len(jsonString)-1);
    };

    return jsonString;
    writeOutput(jsonString);abort;
}

private function personalitiesAsJson(){
  var jsonString =
              '{
            "description": "Keith has faithfully served at Grace Fellowship in Pickerington, Ohio, a growing congregation that integrates service and gospel in its community. Keith is a passionate and skilled communicator and leader, who loves seeing the power of the local church unleashed. He is married to Kelly, and they have four children, Kaden, Kaiya, Kooper, and Kamille. They reside just outside of Columbus, Ohio.",
            "email": "pastorbartblair@gmail.com",
            "groups": [],
            "phone": "",
            "firstName": "Keith",
            "type": "speaker",
            "photo": "http://www.fgbc.org/images/conference/instructors/minier120.jpg",
            "id": "990",
            "lastName": "Minier",
            "files": [],
            "position": "Conference Director",
            "sessions": [],
            "company": ""
          },
          {
            "description": "In 1990, Kevin came to Grace Community Church as an Assistant Youth Pastor/Custodian. Three years later, he became the Lead Pastor. Since 1993, Grace has grown to an average Sunday morning attendance of 1,824 in the small town of Fremont, Ohio. In addition to the Fremont main location, GCC also has campuses located in Northwood, Ohio (near Toledo) and Paulding, Ohio. Kevin and Pam, have three children; Pastor Zach (married to Kaitlynn), Brianne (married to Jacob Wukie), and Karissa (married to Calvin Spriggs) and three grandchildren. Kevin enjoys pointing people to our Savior, spending time with his family, exercise, football, being in the mountains, and traveling.",
            "email": "kpinkerton@ohiograce.com",
            "groups": [],
            "phone": "",
            "firstName": "Kevin",
            "type": "speaker",
            "photo": "http://www.fgbc.org/images/conference/instructors/pinkerton120.jpg",
            "id": "pinkerton",
            "lastName": "Pinkerton",
            "files": [],
            "position": "Host Pastor",
            "sessions": [],
            "company": ""
          },
          {
            "description": "Zach has served as Young Adult, Middle School, and currently as the High School Pastor since 2010. Pastor Zach earned a Bachelor of Science degree in Biblical studies from Liberty University, a Master of Arts in Religion in theology and apologetics from Liberty Baptist Theological Seminary in Lynchburg, Virginia, a Masters in Religious Education from Liberty, and a Masters of Arts in Ministry Studies from Grace College, as well as a Masters of Business Administration degree from Franklin University in Columbus, Ohio.Zach’s wife, Kaitlyn, is also a Liberty graduate with a degree in Graphic Arts.  Zach and Kait have a boy named Toby, and two dogs, Wrigley and Buckeye, named after each of their favorite teams.",
            "email": "zpinkerton@ohiograce.com",
            "groups": [],
            "phone": "",
            "firstName": "Zach",
            "type": "speaker",
            "photo": "http://www.fgbc.org/images/conference/instructors/pinkerton_z120-b.jpg",
            "id": "pinkerton_z",
            "lastName": "Pinkerton",
            "files": [],
            "position": "Host Contact",
            "sessions": [],
            "company": ""
          },
          {
            "description": "Forrest has served as Pastor of Administration and Pastoral Care at Grace Community since 2006.  Pastor Forrest graduated from Indiana Baptist College with a Bachelor of Science degree in Bible. He served as a youth pastor in New Washington, Indiana.  He also served 15 years in Christian education as a principal in Indiana, New York and Ohio. He joined the Grace Community staff in 2006.  He is responsible for hospital visitation, Wednesday Night Bible Study, Lay Counseling Ministry and administration. Forrest and his wife, Vickie, have four children, Clay (married to Crystal and father of Indy and Brody), Kyle (married to Katie), Holly (married to Jimmie) and Kelsey.  Forrest enjoys spending time with his family, watching sports (especially football and Indy racing), camping and playing the piano.",
            "email": "fkirchenbauer@ohiograce.com",
            "groups": [],
            "phone": "",
            "firstName": "Forrest",
            "type": "speaker",
            "photo": "http://www.fgbc.org/images/conference/instructors/kirchenbauer120.jpg",
            "id": "kirchenbauer",
            "lastName": "Kirchenbauer",
            "files": [],
            "position": "Host Contact",
            "sessions": [],
            "company": ""
          },
          {
            "description": "Tom has been the full-time Fellowship Coordinator since January 1998. He served as pastor at the Grace Brethren Church of Orlando, Fla., and as church administrator and pastor of church growth at the Grace Brethren Church of Lititz, Pa. He and his wife, Sandi, reside in Winona Lake, Ind. They have four adult children and seven grandchildren.",
            "email": "tomavey@fgbc.org",
            "groups": [],
            "phone": "574-527-6061",
            "firstName": "Tom",
            "type": "speaker",
            "photo": "http://www.fgbc.org/images/conference/instructors/avey120.jpg",
            "id": "1",
            "lastName": "Avey",
            "files": [],
            "position": "Fellowship Coordinator",
            "sessions": [],
            "company": ""
          },
          {
            "description": "Sandy serves as the Operations Manager for the Fellowship of Grace Brethren Churches. Many of the details including registration, meals, childcare staffing, exhibits, transportation, and general room use are coordinated by Sandy. You can see Sandy during conference at the Hospitality Center. Sandy and her husband, Steve, are members of the Winona Lake (Ind.) Grace Brethren Church. They have three married children and five grandchildren.",
            "email": "sandy@fgbc.org",
            "groups": [],
            "phone": "574-453-7043",
            "firstName": "Sandy",
            "type": "speaker",
            "photo": "http://www.fgbc.org/images/conference/instructors/barrett120.jpg",
            "id": "2",
            "lastName": "Barrett",
            "files": [],
            "position": "Operations Manager",
            "sessions": [],
            "company": ""
          },
          {
            "description": "Erica is the Director of NEXT, the Children’s Ministry of Grace Fellowship in Pickerington, Ohio, where she has served in a full-time capacity for the last five years. Erica leads a staff of three, nearly 200 volunteers, and more than 500 kids at Grace Fellowship. NEXT seeks to build relationships that point kids to Jesus while partnering with parents in a variety of ways. Kids can participate in camps, lock-ins, Mom’s day out, and FX (family experience), in addition to weekend programming. Erica is currently pursuing a Master’s degree in Religious Education from Liberty University. She enjoys spending time with those in her community group and with the teen girls she mentors. ",
            "email": "",
            "groups": [],
            "phone": "",
            "firstName": "Erica",
            "type": "speaker",
            "photo": "http://www.fgbc.org/images/conference/instructors/shelton120.jpg",
            "id": "3",
            "lastName": "Shelton",
            "files": [],
            "position": "Grace Kids Director",
            "sessions": [],
            "company": ""
          },
          {
            "description": "Jeremy Byng has been the Worship Pastor at Grace Community Church in Goshen Indiana for 9 years.  He grew up in the Sebring (FL) Grace Brethren Church and graduated from Grace College in 2004. While attending Grace he met his wife, Ginger (Ogden). They have been married for 15 years and have been blessed with 3 lively children; Lily, Riah, and Rhett. Jeremy has been playing guitar and leading worship for over 20 years in various settings. But his passion is to see hearts come alive in the local church as they worship our Savior in spirit and truth.",
            "email": "jbyng@gracecommunity-church.com",
            "groups": [],
            "phone": "",
            "firstName": "Jeremy",
            "type": "speaker",
            "photo": "http://www.fgbc.org/images/conference/instructors/byng2120.jpg",
            "id": "998",
            "lastName": "Byng",
            "files": [],
            "position": "Worship Leader/Coordinator",
            "sessions": [],
            "company": ""
          }
          ';
   return jsonString;
}

private function exhibitorsAsJson(){
 var exhibitors = model("Conferenceexhibit").findAll(where="event='#getevent()#' AND approved='yes' AND (type = 'Exhibit' OR type = 'Both' OR type IS NULL)");
 var index = 0;
 var jsonString = "";
 var logo = "";

   for (index = 1; index LE exhibitors.recordcount; index = index +1){
             if (len(#exhibitors.logo[index]#)){
              logo = "http://www.fgbc.org/images/conference/exhibitors/" & exhibitors.logo[index];
          }
          else {
              logo="";
          };
    jsonString = jsonString & '{
          "categories": [
            "exhibitor","sponsor"
          ],
          "address": "",
          "email": "",
          "logo": "#logo#",
          "phone": "",
          "booth": "",
          "type": "exhibitor",
          "id": "#exhibitors.id[index]#",
          "files": [#exhibitors.files[index]#],
          "website": "#exhibitors.website[index]#",
          "company": "#exhibitors.organization[index]#",
          "profile": "#sanitizeDescription(exhibitors.description[index])#"
        },';
 };

    if (len(jsonString)) {
      jsonString = left(jsonString,len(jsonString)-1);
    };

  return jsonString;
}

private function sponsorsAsJson(){
 var sponsors = model("Conferenceexhibit").findAll(where="event='#getevent()#' AND approved='yes' AND (type = 'Sponsor' OR type = 'Both')");
 var index = 0;
 var jsonString = "";
 var logo = "";

   for (index = 1; index LE sponsors.recordcount; index = index +1){
             if (len(#sponsors.logo[index]#)){
              logo = "http://www.fgbc.org/images/conference/exhibitors/" & sponsors.logo[index];
          }
          else {
              logo="";
          };
    jsonString = jsonString & '{
          "levels": [
            "gold"
          ],
          "address": "",
          "email": "",
          "logo": "#logo#",
          "phone": "",
          "booth": "",
          "type": "sponsor",
          "id": "#sponsors.id[index]#",
          "files": [#sponsors.files[index]#],
          "website": "#sponsors.website[index]#",
          "company": "#sponsors.organization[index]#",
          "profile": "#sanitizeDescription(sponsors.description[index])#"
        },';
 };

    if (len(jsonString)) {
      jsonString = left(jsonString,len(jsonString)-1);
    };

  return jsonString;
}

public function xsponsorsAsJson(){
  var  jsonString = '{
          "categories": [
            "sponsor"
          ],
          "address": "",
          "email": "",
          "logo": "",
          "phone": "",
          "type": "exhibitor",
          "id": "01",
          "files": [],
          "website": "http://www.fgbc.org",
          "company": "Fellowship of Grace Brethren Churches",
          "profile": "Fellowship of Grace Brethren Churches..."
        }';
  return jsonString;
}

<!---End of Methods to create json objects for the json array--->




<!---Private formatting Methods--->
private function sanitizeDescription(string){
  <!---
    string = replace(string,"<p>","","all");
    string = replace(string,'<p class="subsidynote">','','all');
    string = replace(string,"</p>"," ","all");
 --->   
    string = replace(string,'"','\"','all');
    string = reReplace(string, "[^\x20-\x7E]", "", "ALL");
    return string;
}

private function makeDateTime(date,time){
    var datetime = "";
    dateTime = dateformat(date,"yyyy-mm-dd");
    dateTime = datetime & "T";
    datetime = datetime & timeFormat(time,"HH:mm:ss") & "-0400";
    return dateTime;
}
<!---End of formatting Methods--->




<!---Private Getter Methods--->
private function getInstructors(eventid){
  var course = getCourseForEvent(eventid);
  var instructorsIdList = "";
  var index = 0;
  if (isObject(course)) {
    //Get instructors for courses(workshops)
    var courseinstructors = model("Conferencecourseinstructor").findall(where="courseid = #course.id#");
    for (index = 1; index LE courseinstructors.recordcount; index=index+1) {
      instructorsIdList = instructorsIdList & ',"' & courseinstructors.instructorID[index] & '"';
    };
  };
  //Get instructors for courses(workshops)
  eventinstructors = model("Conferenceeventinstructor").findall(where="eventid = #eventid#");
  if (eventinstructors.recordcount){
    for (index = 1; index LE eventinstructors.recordcount; index=index+1) {
      instructorsIdList = instructorsIdList & ',"' & eventinstructors.instructorID[index] & '"';
    };
  }
  instructorsIdList = replace(instructorsIdList,",","","one");
  return instructorsIdList;
}

private function removeDuplicates(list){
  var length = listLen(list);
  var newlist = "";
   for (var w = 1; w LE length; w = w+1) {
      wd(w);
    };
  abort;
  return removeDuplicatesFromList(newlist);
}

public function removeDuplicatesFromList(list,delimiter){
	var i = 0;
	var listitem = "";
	var newlist = "";

	if(!isDefined("delimiter")){delimiter=","};
	for (i=1; i LTE listLen(list,delimiter); i=i+1){
		listItem = listGetAt(list,i,delimiter);
		if (!listFind(newlist,listitem,delimiter)){
			newlist = newlist & delimiter & listitem;
			}
	};
  newlist = replace(newlist,',','','one');
	return newlist;
}

private function getCourseForEvent(eventid){
  var event = model("Conferenceevent").findOne(where="id=#eventid#");
  if (isObject(event) && isDefined("event.courseId") && val(event.courseid)){
    var course = model("Conferencecourse").findone(where="id = #event.courseid#");
  }
  else {
    var course = model("Conferencecourse").findone(where="eventid = #eventid#");
  }
  if (isObject(course)){
    return course;
  }
  else
  {
    return false;
  };
}

private function getOptionForEvent(eventid){
  var event = model("Conferenceevent").findone(where="id = #eventid#");
  if (isObject(event) && val(event.eventid)){
    var option = model("Conferenceoption").findone(where="id=#event.eventid#")
    if (isObject(option)){
      return option;
    }
    else
    {
    return false;
    }
  }
  else
  {
    return false;
  };
}

private function getTrackColor(track){
  if (track contains "celebration") {return "##0000FF";};//blue
  if (track contains "meal") {return "##A52A2A";};//brown
  if (track contains "workshop") {return "##FF00FF";};//magenta
  return "##ffffff";
}

private function getTracks(eventid){
  var event = model("Conferenceevent").findOne(where="id=#eventid#");
  var course = getCourseForEvent(eventid);
  var track = "";
  if (len(event.category)){
    track = event.category;
  }
  if (event.category is "Workshop" && isObject(course) && len(course.track)){
    track = track & "-" & course.track
  }
  track = '{"color":"#getTrackColor(track)#","name":"#track#"}';
  return track;
}

private function getCourseTitleForEvent(eventid){
  var course = getCourseForEvent(eventid);
  if (!isObject(course)) {
    return "";
  }
  else
  {
  return course.title;
  }
}

private function getrecordinglinkurl(recordinglink) {
  var recordinglinkurl = "";
    if(recordinglink contains 'http://' || recordinglink contains 'https://' ) {
      recordinglinkurl = recordinglink;
    }
    else {
      recordinglinkurl = 'http://www.fgbc.org/files/Audio/margins2016/#recordinglink#';
    };
    return recordinglinkurl;
}

private function getCourseDescriptionForEvent(eventid){
  var course = getCourseForEvent(eventid);
  if (!isObject(course)) {
    return "";
  }
  else
  {
  if (isDefined("course.recordinglink") && len(course.recordinglink)){
    course.descriptionlong = course.descriptionlong & "<br/><br/>(Audio recording: " & "<a href='#getrecordinglinkurl(course.recordinglink)#'>#course.recordinglink#</a>)";
  };
  return course.descriptionlong;
  }
}

private function getOptionDescriptionForEvent(eventid){
  var course = getOptionForEvent(eventid);
  if (isObject(course)) {
    return course.description;
  }
  else
  {
    return "";
  }
};

private function getDescriptionForEvent(eventid){
  var event = model("Conferenceevent").findOne(where="id=#eventid#");
  var addednote = "";
  if (event.category EQ "Meal") {addednote = " Tickets for this meal were sold online. Check at the Welcome Center to see if more are available."}
  var eventdescription = event.description;
  var eventdescriptionprogram = event.descriptionprogram;
  var optiondescription = getOptionDescriptionForEvent(eventid);
  var coursedescription = getCourseDescriptionForEvent(eventid);
    if (len(optiondescription)){
      eventdescription =  optiondescription;
    }
    elseif (len(coursedescription)){
      eventdescription =  coursedescription;
    }
    elseif (len(eventdescriptionprogram)){
      eventdescription = eventdescriptionprogram;
    };
    return eventdescription & addednote;
}

public function testgetOptionDescriptionForEvent(){
  var description = getOptionDescriptionForEvent(params.key);
  writeDump(description);abort;
}

public function testSponsorsAsJson(){
  var json = sponsorsAsJson();
  wo(json);abort;
}

public function testgetCourseDescriptionForEvent(){
  var description = getCourseDescriptionForEvent(params.key);
  writeDump(description);abort;
}

public function testgetCourseForEvent(){
  var course = getCourseForEvent(params.key);
  writeDump(course);abort;
}

private function getTitleForEvent(eventid, prefer="event"){
  var courseTitle = getCourseTitleForEvent(eventid);
  if (len(courseTitle) && (prefer is "course")){
    return courseTitle;
  }
  else
  {
    var event = model("Conferenceevent").findOne(where="id=#eventid#");
    if (isObject(event)){
      if (event.category EQ "meal") {event.description = event.description & "-Ticket Required"}
    return event.description;
    }
    else
    {
    return "No Title";
    }
  }
}

<!---End of Getter Methods--->






<!---Utilities for testing--->

public function getScheduledEvent(id){
    var event = model("Conferenceevent").findOne(where="id=#id#");
    return event;
}

public function list(){
    var events = model("Conferenceevent").findall(where="event='#getevent()#'", include="location,option");
    writeDump(events);abort;
}

private function write(text){
  writeOutput(text);abort;
};

private function wo(text){
  writeOutput(text);abort;
};

private function wd(text){
  writeDump(text);abort;
};



}