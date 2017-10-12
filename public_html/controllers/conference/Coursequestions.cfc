<cfcomponent extends="Controller" output="false"><cfscript>
  
  function init(){
    usesLayout("/conference/adminlayout");
    filters(through="getCourses", include="new,edit");
    filters(through="getRegisteredPeople", include="new,edit");
  }

  //Filters//
  function getCourses(){
      courses = model("Conferencecourse").findAll(where="event='#getEvent()#'");
  }

  function getRegisteredPeople(){
  		registrations = model("Conferenceperson").findAllPeopleRegistered();
  }

  // Coursequestions/index
  function index(){
    Coursequestions = model("Conferencecoursequestion").findAll(include="person(family),course");
  }
  
//---------------------------------------
//-----------CRUD------------------------
//---------------------------------------

  // Coursequestions/show/key
  function show(){
    Coursequestion = model("Conferencecoursequestion").findByKey(key=params.key);
    Person = model("Conferenceperson").findByKey(key=coursequestion.personid, include="family");
    Course = model("Conferencecourse").findByKey(coursequestion.courseid);	
    if (!IsObject(Coursequestion)){
      flashInsert(error="Coursequestion #params.key# was not found");
      redirectTo(action="index");
    }
  }
  
  // Coursequestions/new
  function new(){
    Coursequestion = model("Conferencecoursequestion").new();

    if (isDefined("params.personid") && params.personid){
      Coursequestion.personid = params.personid;
      person = model("Conferenceperson").findByKey(key=Coursequestion.personid, include="family");
    } else {
    }

    if (isDefined("params.courseid") && params.courseid){
      Coursequestion.courseid = params.courseid;
      course = model("Conferencecourse").findByKey(key=Coursequestion.courseid);
    } else {
    }
    renderPage(layout="/conference/layout2017");
  }
  
  //Coursequestions/edit/key
  function edit(){
    Coursequestion = model("Conferencecoursequestion").findByKey(params.key);
    	
    if (!IsObject(Coursequestion)){
	    flashInsert(error="Coursequestion #params.key# was not found");
			redirectTo(action="index");
	  }
    renderPage(layout="/conference/layout2017");
  }
  
  // Coursequestions/create
  function create(){
    Coursequestion = model("Conferencecoursequestion").new(params.Coursequestion);
		
		if (Coursequestion.save()){
			flashInsert(success="The Coursequestion was created successfully.");
      returnBack();
		} else {
		  flashInsert(error="There was an error creating the Coursequestion.");
		  renderPage(action="new");
		};
  }
  
  // Coursequestions/update
  function update(){
    Coursequestion = model("Conferencecoursequestion").findByKey(params.key);
		
		if (Coursequestion.update(params.Coursequestion)){
		  flashInsert(success="The Coursequestion was updated successfully.");
      returnBack();
		} else {
		  flashInsert(error="There was an error updating the Coursequestion.");
			renderPage(action="edit");
		}
  }
  
  // Coursequestions/delete/key
  function delete(){
    Coursequestion = model("Conferencecoursequestion").findByKey(params.key);

		if (Coursequestion.delete()){
			flashInsert(success="The Coursequestion was deleted successfully.");
      redirectTo(action="index");
    } else {
      flashInsert(error="There was an error deleting the Coursequestion.");
			redirectTo(action="index");
    }
  }

//-------------Other View Controllers-------------------

  // Coursequestions/list
  function list(){
    var whereString = "id > 0";
    if (isDefined("params.courseid")){
      whereString = whereString & " AND courseid = #params.courseid#";
      courseTitle = model("Conferencecourse").findOne(where="id=#params.courseid#").title;
    }
    Coursequestions = model("Conferencecoursequestion").findAll(where=whereString, include="person(family),course", order="createdAt DESC");
    headerSubTitle = "Cohort Questions";
    renderPage(layout="/conference/layout2017");
  }

</cfscript></cfcomponent>
