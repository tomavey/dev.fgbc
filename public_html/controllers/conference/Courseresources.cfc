component extends="Controller" output="false" {
  
  public void function init(){
    usesLayout("/layoutadmin");
  }
  
  // Conferencecourseresources/index
  public void function index(){
    Resources = model("Conferencecourseresource").findAll();
  }
  
  // Conferencecourseresources/show/key
  public void function show(){
    Resource = model("Conferencecourseresource").findByKey(params.key);
    	
    if (!IsObject(Resource)){
      flashInsert(error="Resource #params.key# was not found");
      redirectTo(action="index");
    }
  }
  
  // Conferencecourseresources/new
  public void function new(){
    Resource = model("Conferencecourseresource").new();
  }
  
  //Conferencecourseresources/edit/key
  public void function edit(){
    Resource = model("Conferencecourseresource").findByKey(params.key);
    	
    if (!IsObject(Resource)){
	    flashInsert(error="Resource #params.key# was not found");
			redirectTo(action="index");
	  }
  }
  
  // Conferencecourseresources/create
  public void function create(){
    Resource = model("Conferencecourseresource").new(params.resource);
		
		if (Resource.save()){
			flashInsert(success="The resource was created successfully.");
      redirectTo(action="index");
		} else {
		  flashInsert(error="There was an error creating the resource.");
		  renderPage(action="new");
		}
  }
  
  // Conferencecourseresources/update
  public void function update(){
    Resource = model("Conferencecourseresource").findByKey(params.key);
		
		if (Resource.update(params.resource)){
		  flashInsert(success="The resource was updated successfully.");
      redirectTo(action="index");
		} else {
		  flashInsert(error="There was an error updating the resource.");
			renderPage(action="edit");
		}
  }
  
  // Conferencecourseresources/delete/key
  public void function delete(){
    Resource = model("Conferencecourseresource").findByKey(params.key);

		if (Resource.delete()){
			flashInsert(success="The resource was deleted successfully.");
      redirectTo(action="index");
    } else {
      flashInsert(error="There was an error deleting the resource.");
			redirectTo(action="index");
    }
  }
  
}
