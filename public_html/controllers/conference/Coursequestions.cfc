<cfcomponent extends="Controller" output="false">

<cfscript>
  
  function init(){
    usesLayout(template="/conference/adminlayout", only="index");
		usesLayout(template="/conference/layout2018", only="list,new,edit")
    filters(through="getCourses", include="new,edit");
    filters(through="getRegisteredPeople", include="new,edit");
    filters(through="isAuthorized", only="index");
  }

  //Filters//
  function getCourses(){
      courses = model("Conferencecourse").findAll(where="event='#getEvent()#'", order="title");
  }

  function getRegisteredPeople(){
  		registrations = model("Conferenceperson").findAllPeopleRegistered();
  }

  function isAuthorized() {
    if (!gotRights('office')) { renderText("Please close this browser window! Thanks so much")}
  }

//---------------------------------------
//-----------CRUD------------------------
//---------------------------------------

  // Coursequestions/index
  function index(){
    Coursequestions = model("Conferencecoursequestion").findAll(where="event='#getEvent()#'", include="person(family),course", order="title");
    renderPage(layout="/conference/adminlayout")
  }
  

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
    if (isMobile()){
      renderPage(layout="/conference/layout_mobile")
    }
  }
  
  //Coursequestions/edit/key
  function edit(){
    Coursequestion = model("Conferencecoursequestion").findByKey(params.key);
    	
    if (!IsObject(Coursequestion)){
	    flashInsert(error="Coursequestion #params.key# was not found");
			redirectTo(action="index");
	  }
    if (isMobile()){
      renderPage(layout="/conference/layout_mobile")
    }
  }
  
  // Coursequestions/create
  function create(){
    Coursequestion = model("Conferencecoursequestion").new(params.Coursequestion);
		
		if (Coursequestion.save()){
			flashInsert(success="The Coursequestion was created successfully.");
      if (isMobile()) { redirectTo(action="thankyou") };
      returnBack();
		} else {
		  flashInsert(error="There was an error creating the Coursequestion.");
		  renderPage(action="new");
		};
  }

  // mobile Thank you
  function thankyou() {
    renderPage(layout="/conference/layout_mobile")
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
  function list(orderBy='title'){
    var whereString = "id > 0 AND event='#getEvent()#'";
    if (isDefined("params.courseid")){
      whereString = whereString & " AND courseid = #params.courseid#";
      courseTitle = model("Conferencecourse").findOne(where="id=#params.courseid#").title;
    }
    Coursequestions = model("Conferencecoursequestion").findAll(where=whereString, include="person(family),course", order=orderBy);
    headerSubTitle = "Cohort Questions";
  }
  
  // Coursequestions/json
  function json(){
    Coursequestions = model("Conferencecoursequestion").findAll(where="event='#getEvent()#'", include="person(family),course", order="title");
    data = queryToJson(Coursequestions);
		renderPage(layout="/layout_json", template="/json", hideDebugInformation=true)
  }
  
</cfscript></cfcomponent>
