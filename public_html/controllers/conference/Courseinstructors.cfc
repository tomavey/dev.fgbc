component extends="controller" {

	public function config() {
		usesLayout("/conference/adminlayout");
	}

// --------------------------------------
// ----------CRUD------------------------
// --------------------------------------

	public function new() {
		newcourse = false;
		newinstructor = false;
		courseinstructor = model("Conferencecourseinstructor").new();
		if ( isDefined("params.courseid") ) {
			courseinstructor.courseid = params.courseid;
			newInstructor = true;
			instructors = model("Conferenceinstructor").findAll(where="event='#getEvent()#'", order="fname, lname");
		} else if ( isDefined("params.instructorid") ) {
			courseinstructor.instructorid = params.instructorid;
			newCourse = true;
			courses = model("Conferencecourse").findAll(where="event='#getevent()#'", order="title");
		}
	}

	//  -instructors/create 
	public function create() {
		courseInstructor = model("Conferencecourseinstructor").new(params.courseInstructor);
		//  Verify that the instructor creates successfully 
		if ( courseInstructor.save() ) {
			flashInsert(success="The course was connected successfully.");
			returnBack();
			//  Otherwise 
		} else {
			flashInsert(error="There was an error creating the connection.");
			renderView(action="new");
		}
	}

	//  -instructors/delete/key 
	public function delete() {
		model("Conferencecourseinstructor").delete(params.courseid,params.instructorid);
		returnBack();
	}

	//  Courses/copyAllToCurrentEvent 
	public function copyAllToCurrentEvent(){
			super.copyAllToCurrentEvent( tableName = "Conferenceinstructor" );
			returnBack();
		}

}
