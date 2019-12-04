component extends="Controller" output="false" {
  
  public void function init(){
    usesLayout("/conference/adminlayout")
    filters(through="officeOnly", except="new,show,list")
    filters(through="setReturn", only="index,show,list")
  }
  
  // Conferencehomes/index
  public void function index(){
    Homes = model("Conferencehome").findAll();
  }
  
  // Conferencehomes/show/key
  public void function show(){
    Home = model("Conferencehome").findByKey(params.key);
    	
    if (!IsObject(Home)){
      flashInsert(error="Conferencehome #params.key# was not found");
      redirectTo(action="index");
    }
  }
  
  // Conferencehomes/new
  public void function new(){
    Home = model("Conferencehome").new()
    formaction="create"
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
      returnBack()
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
  
}
