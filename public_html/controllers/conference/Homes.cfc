component extends="Controller" output="false" {
  
  public void function init(){
    usesLayout("/conference/adminlayout")
    filters(through="isOffice", except="new,show,list,create,sendEmailNoticeToOffice,thankyou")
    filters(through="setReturn", only="index,show,list,new,thankyou")
  }




//-------------------
//---CRUD------------  
//-------------------
  
  // Conferencehomes/index
  public void function index(){
    sortby = "createdAt"
    direction = "DESC"
    if ( isDefined("params.sortby") ) { sortby = params.sortby }
    if ( isDefined("params.direction") ) { direction = params.direction }
    var orderString = sortby & " " & direction
    var whereString = ""
    Homes = model("Conferencehome").findAll(where = whereString, order=orderString);
  }
  
  // Conferencehomes/show/key
  public void function show(){
    Home = model("Conferencehome").findByKey(key=params.key, returnAs="query");
    	
    if (!Home.recordcount){
      flashInsert(error="Conferencehome #params.key# was not found");
      redirectTo(action="index");
    }
  }
  
  // Conferencehomes/list/key
  public void function list(){
    var whereString = "approved='yes'"
    if ( isDefined('params.showAll') ) { whereString = "" }
    if ( isDefined('params.status') ) { whereString = whereString & " AND status='#params.status#'"}
    Homes = model("Conferencehome").findAll(where=whereString);
    if (!Homes.recordcount){
      flashInsert(error="Conferencehome #params.key# was not found");
      redirectTo(action="index");
    }
    var instructionsObj  = model('Maincontent').findOne(where="shortLink='AccessHostRequestInstructions'")
    if ( isObject(instructionsObj) ) {
      instructions = instructionsObj.content
      instructionsId = instructionsObj.id
    }
    if ( !gotRights('office') ) {
      renderPage(layout="/conference/layout2019invoice")
    }
  }
  
  // Conferencehomes/new
  public void function new(){
    Home = model("Conferencehome").new()
    formaction="create"
    var instructionsObj  = model('Maincontent').findOne(where="shortLink='AccessHostInstructions'")
    if ( isObject(instructionsObj) ) {
      instructions = instructionsObj.content
      instructionsId = instructionsObj.id
    }
    if ( !gotRights('office') ) {
      renderPage(layout="/conference/layout2019invoice")
    }
  }
  
  //Conferencehomes/edit/key
  public void function edit(){
    Home = model("Conferencehome").findByKey(params.key);
    	
    if (!IsObject(Home)){
	    flashInsert(error="Conferencehome #params.key# was not found");
			redirectTo(action="index");
	  }
    formaction="update"
  }
  
  // Conferencehomes/create
  public void function create(){
    // writeDump(params);abort;
    Home = model("Conferencehome").new(params.home);
    // writeDump(home.properties());abort;
		
		if (Home.save()){
      flashInsert(success="The Conferencehome was created successfully.");
      if ( gotRights("office") ) {
        redirectTo(action="Index")
      } else {
        sendEmailNoticeToOffice(home.id)
        redirectTo(action="ThankYou")
      }
		} else {
		  flashInsert(error="There was an error creating the Conferencehome.");
		  renderPage(action="new");
    }
  }
  
  // Conferencehomes/update
  public void function update(){
    Home = model("Conferencehome").findByKey(params.key);
		
		if (Home.update(params.home)){
		  flashInsert(success="The host home was updated successfully.");
      returnBack()
		} else {
		  flashInsert(error="There was an error updating the home.");
			renderPage(action="edit");
		}
  }
  
  // Conferencehomes/delete/key
  public void function delete(){
    Home = model("Conferencehome").findByKey(params.key);

		if (Home.delete()){
			flashInsert(success="The Home was deleted successfully.");
      redirectTo(action="index");
    } else {
      flashInsert(error="There was an error deleting the Home.");
			redirectTo(action="index");
    }
  }
//----END OF CRUD-------
  


//--------------------
//---PROCESSES--------
//--------------------

  public void function approve(id=params.key){
    Home = model("Conferencehome").findByKey(arguments.id);
    if ( home.approved == "Yes") { 
      home.approved = "No"
      home.update()
      sendEmailNoticeToHost(home.id)
      returnBack()
     }
     if ( home.approved == "No") { 
      home.approved = "Yes"
      home.update()
      returnBack()
     }
  }

  public void function thankYou(){
    var thankyouObj = model('Maincontent').findOne(where="shortLink='AccessHostThankYou'")
    if ( isObject(thankyouObj) ) {
      thankyouMessage = thankyouObj.content
      thankyouId = thankyouObj.id
    }
    if ( !gotRights('office') ) {
      renderPage(layout="/conference/layout2019invoice")
    }
  }

  public function sendEmailNoticeToOffice(required numeric id) {
    home = model("Conferencehome").findByKey(arguments.id)
    // writeDump(home.properties());abort;
    if ( isObject(home) ) {
      var subjectText = "#getEventAsText()# Host Home Application"
      if ( !isLocalMachine() ) {
        // sendEmail(from=home.email, to=getSetting('registrarEmail'), bcc=getSetting('registrarEmailBackup'), subject=subjectText, template='sendEmailNoticeToOffice')
        sendEmail(from=home.email, to=getSetting('registrarEmailBackup'), bcc=getSetting('registrarEmailBackup'), subject=subjectText, template='sendEmailNoticeToOffice')
      } else {
        renderText("An Email would have been sent")
      }
    } else {
      renderText("Oops. Something went wrong!")
    }
  }

  public function sendEmailNoticeToHost(required numeric id) {
    home = model("Conferencehome").findByKey(arguments.id)
    // writeDump(home.properties());abort;
    if ( isObject(home) ) {
      var subjectText = "Your #getEventAsText()# Host Home Application Has Been Approved"
      if ( !isLocalMachine() ) {
        // sendEmail(from=home.email, to=getSetting('registrarEmail'), bcc=getSetting('registrarEmailBackup'), subject=subjectText, template='sendEmailNoticeToOffice')
        sendEmail(from=home.email, to=getSetting('registrarEmailBackup'), bcc=getSetting('registrarEmailBackup'), subject=subjectText, template='sendEmailNoticeToHost')
      } else {
        renderText("An Email would have been sent")
      }
    } else {
      renderText("Oops. Something went wrong!")
    }
  }

}
