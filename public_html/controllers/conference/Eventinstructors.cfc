component extends="Controller" output="false" {

  public void function config(){
    usesLayout("/conference/adminlayout");
    filters(through="geteventsandinstructors", only="new,edit");
    filters(through="setreturn", only="index,show")
  }

  //Filters
  private function geteventsandinstructors(){
    events = model("Conferenceevent").findall(where="event='#getevent()#'", order="description");
    instructors = model("Conferenceinstructor").findall(where="event='#getevent()#'", order="lname");
  }

  // eventinstructors/index
  public void function index(){
    eventinstructors = model("Conferenceeventinstructor").findAll();
  }

  // eventinstructors/show/key
  public void function show(){
    eventinstructor = model("Conferenceeventinstructor").findByKey(params.key);

    if (!IsObject(eventinstructor)){
      flashInsert(error="Event/instructor #params.key# was not found");
      redirectTo(action="index");
    }
  }

  // eventinstructors/new
  public void function new(){
    eventinstructor = model("Conferenceeventinstructor").new();
    if (isDefined("params.eventid")){
      eventinstructor.eventid = params.eventid;
    }
  }

  //eventinstructors/edit/key
  public void function edit(){
    eventinstructor = model("Conferenceeventinstructor").findByKey(params.key);

    if (!IsObject(eventinstructor)){
	    flashInsert(error="Event/instructor #params.key# was not found");
			redirectTo(action="index");
	  }
  }

  // eventinstructors/create
  public void function create(){
    eventinstructor = model("Conferenceeventinstructor").new(params.eventinstructor);

		if (eventinstructor.save()){
			flashInsert(success="The Event/Instructor link was created successfully.");
                    returnBack();
		} else {
		  flashInsert(error="There was an error creating the Event/Instructor link.");
		  returnBack();
		}
  }

  // eventinstructors/update
  public void function update(){
    eventinstructor = model("Conferenceeventinstructor").findByKey(params.key);

		if (eventinstructor.update(params.eventinstructor)){
		  flashInsert(success="The Event/instructor link was updated successfully.");
              returnBack();
		} else {
		  flashInsert(error="There was an error updating the Event/instructor link.");
                returnBack();
		}
  }

  // eventinstructors/delete/key
  public void function delete(){
    eventinstructor = model("Conferenceeventinstructor").findByKey(params.key);

		if (eventinstructor.delete()){
			flashInsert(success="The event/instructor link was deleted successfully.");
                returnBack();
    } else {
      flashInsert(error="There was an error deleting the event/instructor link.");
                returnBack();
    }
  }

  public function getInstructorLName(instructorid){
    var instructor = model("Conferenceinstructor").findByKey(instructorid);
    return instructor.lname;
  }

  public function getEventName(eventid){
    var event = model("Conferenceevent").findByKey(eventid);
    return event.description;
  }

}
