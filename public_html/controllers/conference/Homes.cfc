component extends="Controller" output="false" {
  
  public void function init(){
    usesLayout("/conference/adminlayout")
    // filters(through="isOffice", except="new,newAccessHost,newAccessGuest,show,list,create,sendEmailNoticeToOffice,sendEmailNoticeToHost, thankyou")
    // filters(through="setReturn", only="index,show,list,new,thankyou")
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
    var whereString = $getWhereStringForIndex()
    Homes = model("Conferencehome").findAll(where = whereString, order=orderString);
    }
  
  // Conferencehomes/show/key
  public void function show(){
    Home = model("Conferencehome").findByKey(key=params.key, returnAs="query");
    	
    if (!Home.recordcount){
      flashInsert(error="Conferencehome #params.key# was not found");
      redirectTo(action="index");
    }
    showType="show#home.type#"
  }

  // Conferencehomes/list/key/
  public void function list(){
    var orderString = "homeid"
    var whereString = $getWhereStringForList()
    writeDump(whereString);abort;
    Homes = model("Conferencehome").findAll(where = whereString, order=orderString);
    // writeDump(homes);abort;
    if (!Homes.recordcount){
      flashInsert(error="Conferencehome #params.key# was not found");
      redirectTo(action="index");
    }
    type="host"
    $setInstructions(type)
    setLayout()
  }

  private function $getWhereStringForList(whereString = "approved='yes' AND type='Host' AND homeid IS NOT NULL"){
    return $getWhereStringForIndex(arguments.whereString)
  }

  private function $getWhereStringForIndex(whereString = "type='Host'"){
    if ( isDefined('params.type') && params.type == "guest" ) { 
      arguments.whereString = "type='guest'" 
    }
    if ( isDefined('params.showAll') ) { 
      arguments.whereString = "" 
    }
    if ( isDefined('params.status') ) { 
      arguments.whereString = arguments.whereString & " AND status='#params.status#'"
    }
    if ( isDefined("params.search") ) { 
      arguments.whereString = "name LIKE '%#params.search#%'" 
    }
    return arguments.whereString
  }
  
  // Conferencehomes/new
  public void function newAccessHost(){
    redirectTo(action="new", params="type=host")
  }

  public void function newAccessGuest(){
    redirectTo(action="new", params="type=guest")
  }

  public void function new(){
    Home = model("Conferencehome").new()
    home.type = params.type
    if ( isDefined("params.requestedHomeId") ) {
      home.requestedHomeId=params.requestedHomeId
    } ELSE {
      hostHomes = model("Conferencehome").findAll(where ="homeId IS NOT NULL", order="homeId")
    }
    formType="formFor#home.type#" 
    formaction="create"
    $setInstructions(home.type)
    setLayout()
  }
  
  //Conferencehomes/edit/key
  public void function edit(){
    Home = model("Conferencehome").findByKey(params.key);
    	
    if (!IsObject(Home)){
	    flashInsert(error="Conferencehome #params.key# was not found");
			redirectTo(action="index");
    }

    type=home.type
    formType="formFor#home.type#"
    formaction="update"
  }
  
  // Conferencehomes/create
  public void function create(){
    Home = model("Conferencehome").new(params.home);
    // writeDump(home.properties());abort;
		
		if (Home.save()){
      flashInsert(success="The Conferencehome was created successfully.");
      if ( gotRights("office") ) {
        if ( getSetting('isConferenceHomesTesting') ) {
          sendEmailNoticeToOffice(home.id,home.type)
          redirectTo(action="ThankYou", params="type=#home.type#")
        }
        redirectTo(action="Index")
      } else {
        sendEmailNoticeToOffice(home.id,home.type)
        redirectTo(action="ThankYou", params="type=#home.type#")
      }
		} else {
		  flashInsert(error="There was an error creating the Conferencehome.");
      formType="formFor#home.type#"
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
      if (!IsObject(Home)){
        flashInsert(error="Conferencehome #params.key# was not found");
        redirectTo(action="index");
      }
  
      formType="formFor#home.type#"
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
      returnBack()
     }
     if ( home.approved == "No") { 
      home.approved = "Yes"
      home.update()
      flashInsert(success="Host Homes won't show on the public list untill they have a home id.");
      if ( !len(home.approvedAt) ) {
        sendEmailNoticeToHost(home.id)
        setApprovedAt(home.id)
      }
      returnBack()
     }
  }

  public void function thankYou(type=params.type){
    var thankyouObj = model('Maincontent').findOne(where="shortLink='Access#arguments.type#ThankYou'")
    if ( isObject(thankyouObj) ) {
      thankyouMessage = thankyouObj.content
      thankyouId = thankyouObj.id
    }
    if ( !gotRights('office') ) {
      renderPage(layout="/conference/layout2019invoice")
    }
  }

  private function sendEmailNoticeToOffice(required numeric id, required string type) {
    home = model("Conferencehome").findByKey(arguments.id)
    // writeDump(home.properties());abort;
    if ( isObject(home) ) {
      var subjectText = "#getEventAsText()# #arguments.type# Home Application"
      if ( !isLocalMachine() ) {
        if ( getSetting('isConferenceHomesTesting') ) {
          subjectText = subjectText & " --TEST--"
        } 
        sendEmail(from=home.email, to=getSetting('registrarEmail'), bcc=getSetting('registrarEmailBackup'), subject=subjectText, template='sendEmailNoticeToOfficeAbout#arguments.type#')
      } else {
        renderText("An Email would have been sent")
      }
    } else {
      renderText("Oops. Something went wrong!")
    }
  }

  private function sendEmailNoticeToHost(required numeric id) {
    //sends when the host has been approved
    home = model("Conferencehome").findByKey(arguments.id)
    // writeDump(home.properties());abort;
    if ( isObject(home) ) {
      var subjectText = "Your #getEventAsText()# Host Home Application Has Been Approved"
      if ( !isLocalMachine() ) {
        if ( getSetting('isConferenceHomesTesting') ){
          subjectText = subjectText & "--TESTING--"
          sendEmail(from=getSetting('registrarEmail'), to=getSetting('registrarEmail'), bcc=getSetting('registrarEmailBackup'),subject=subjectText, template="sendEmailNoticeToHost")
        } ELSE {
          sendEmail(from=getSetting('registrarEmail'), to=home.email, bcc=getSetting('registrarEmailBackup'), subject=subjectText, template="sendEmailNoticeToHost")
        }
      } else {
        writeOutPut("An Email would have been sent");abort;
      }
    } else {
      renderText("Oops. Something went wrong!")
    }
  }

  private function $createArgsForsendEmailNoticeToHost(){
    //notworking correctly
    var subjectText = "Your #getEventAsText()# Host Home Application Has Been Approved"
    if ( getSetting('isConferenceHomesTesting') ) { 
      var args = {
        Subject: subjectText & " --TEST--", 
        From: getSetting('registrarEmail'),
        Bcc: getSetting('registrarEmailBackup'),
        Template: 'sendEmailNoticeToHost'
      }
      if ( gotRights("superadmin") ) { 
        From = getSetting('registrarEmailBackup')
        Subject= subjectText & " --TEST--SUPERADMIN--" 
      }
    } ELSE {
      var args = {
        Subject: subjectText, 
        Email: home.email,
        Bcc = getSetting('registrarEmailBackup'),
        From = getSetting('registrarEmail'),
        Template: 'sendEmailNoticeToHost'
      }
    }
    writeDump(args);abort;
    return args
  }

  private void function setApprovedAt(required numeric id) {
    var home = model("Conferencehome").findByKey(arguments.id);
    home.approvedAt = now()
    home.update()
  }

  //Used by view/conference/homes/index
  private function approvedText(required string approved, required string approvedAt){    
    if ( len(approvedAt) && approved ) {
      return dateFormat(approvedAt)
    } ELSE {
      return approved
    }
  }

  private function setLayout(){
    if ( !gotRights('office') ) {
      renderPage(layout="/conference/layout2019invoice")
    }
  }

  private function $setInstructions(required string type) {
    var shortlink = "Access#arguments.type#Instructions"
    var instructionsObj  = model('Maincontent').findOne(where="shortLink='#shortlink#'")
    if ( isObject(instructionsObj) ) {
      instructions = instructionsObj.content
      instructionsId = instructionsObj.id
    }
  }

  private function getHostSelectNameFromRequestedHomeId(required string requestedHomeId){
    var selectName = model("Conferencehome").findOne(where="HomeId = '#arguments.requestedHomeId#'")
    if ( isObject(selectName) ) {
      return selectName.selectNameId
    }
    return "None"
  }

}
