component extends="Controller" output="false" {
  
  public void function init(){
    filters(through="isAuthorized");
    filters(through="getCategories", only="index");
    filters(through="setReturn", only="index,show");
  }
  
  public void function isAuthorized(){
    if (!gotRights("office")){
      rendertext("you do not have permission to view this page");
    }
  }

  public function getCategories(){
    categories =  model("Fgbcsetting").findAll(where="category IS NOT NULL");
    categories = ValueList(categories.category);
    categories = listRemoveDuplicates(categories,",",true);
    categories = listSort(categories,"TextNoCase");
  }

  // settings/index
  public void function index(){
    whereString = "";
    orderString = 'name';
    if (isDefined("params.category") && params.category is "conference"){
      showGetSettingFor = "registrationIsOpen,groupregistrationIsOpen,convertGroupRegistrationIsOpen, monitoring,mealsregistrationIsOpen,optionsregistrationIsOpen,preregistrationIsOpen,ccareregistrationIsOpen,exhibitorsIsOpen,regAccountIsOpen,workshopsRegIsOpen,workshopsEventsAreSet,workshopNotificationsOpen,showFacilitatorsWithCourse,showSubTypesOfCourses,delegatesSubmitIsOpen,regOpenPromiseDate";
    }
    if (isDefined("params.clearSessionSettings")){
        structDelete(session, "settings");
        structDelete(session, "settings");
    }
    if (isDefined("params.category")){
      whereString = "category = '#params.category#'";
    }
    if (isDefined("params.orderby")){
      orderString = params.orderby;
    }
    settings = model("Fgbcsetting").findAll(where=whereString, order=orderString);
    applicationSettingsList = getApplicationSettingsList();
    if(isDefined("params.category") && params.category is "conference"){
      renderPage(layout="/conference/adminlayout");
    }
  }

  private function getApplicationSettingsList(){
    var newlist = "";
    var oldlist = structKeyList(application.wheels);
    oldlist = listSort(oldlist, "textNoCase");
    for (var i = 1; i LTE listLen(oldlist); i=i+1){
      var listItem = listGetAt(oldlist,#i#);
      if (listItem NEQ "password" && asc(mid(listItem,2,1)) GTE 97){
        newlist = newlist & #listItem# & ",";
      }
    };
    return newlist;
  }
  
  // settings/show/key
  public void function show(){
    setting = model("Fgbcsetting").findByKey(params.key);
    	
    if (!IsObject(setting)){
      flashInsert(error="Setting at #params.key# was not found");
      redirectTo(action="index");
    }
  }
  
  // settings/new
  public void function new(){
    setting = model("Fgbcsetting").new();
    if (isDefined("params.name")){setting.name = params.name};
  }
  
  //fgbc_metas/edit/key
  public void function edit(){
    setting = model("Fgbcsetting").findByKey(params.key);
    	
    if (!IsObject(setting)){
	    flashInsert(error="Setting for #params.key# was not found");
			redirectTo(action="index");
	  }
  }
  
  // settings/create
  public void function create(){
    setting = model("Fgbcsetting").new(params.setting);
		
		if (setting.save()){
			flashInsert(success="The setting was created successfully.");
      returnBack();
		} else {
		  flashInsert(error="There was an error creating the setting.");
		  renderPage(action="new");
		}
  }
  
  // settings/update
  public void function update(){
// writeDump(params);abort;
    setting = model("Fgbcsetting").findByKey(params.key);
		
		if (setting.update(params.setting)){
		  flashInsert(success="The setting was updated successfully.");
      returnBack();
		} else {
		  flashInsert(error="There was an error updating the setting.");
			renderPage(action="edit");
		}
  }

  // settings/copy
  public void function copy(){
    setting = model("Fgbcsetting").findByKey(params.key);
		
		if (!isObject(setting)){
		  flashInsert(error="Setting #paraams.key# was not found.");
      returnBack();
		}
			renderPage(action="new");
		}
  }

  // settings/delete/key
  public void function delete(){
    setting = model("Fgbcsetting").findByKey(params.key);

		if (setting.delete()){
			flashInsert(success="The setting was deleted successfully.");
      returnBack();
    } else {
      flashInsert(error="There was an error deleting the setting.");
			redirectTo(action="index");
  }
  
}
