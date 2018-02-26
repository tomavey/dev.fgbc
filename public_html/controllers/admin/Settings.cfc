component extends="Controller" output="false" {
  
  public void function init(){
  }
  
  // fgbc_metas/index
  public void function index(){
    settings = model("Fgbcsetting").findAll();
  }
  
  // fgbc_metas/show/key
  public void function show(){
    setting = model("Fgbcsetting").findByKey(params.key);
    	
    if (!IsObject(setting)){
      flashInsert(error="Setting at #params.key# was not found");
      redirectTo(action="index");
    }
  }
  
  // fgbc_metas/new
  public void function new(){
    setting = model("Fgbcsetting").new();
  }
  
  //fgbc_metas/edit/key
  public void function edit(){
    setting = model("Fgbcsetting").findByKey(params.key);
    	
    if (!IsObject(setting)){
	    flashInsert(error="Setting for #params.key# was not found");
			redirectTo(action="index");
	  }
  }
  
  // fgbc_metas/create
  public void function create(){
    setting = model("Fgbcsetting").new(params.setting);
		
		if (setting.save()){
			flashInsert(success="The setting was created successfully.");
      redirectTo(action="index");
		} else {
		  flashInsert(error="There was an error creating the setting.");
		  renderPage(action="new");
		}
  }
  
  // fgbc_metas/update
  public void function update(){
    setting = model("Fgbcsetting").findByKey(params.key);
		
		if (setting.update(params.setting)){
		  flashInsert(success="The segtting was updated successfully.");
      redirectTo(action="index");
		} else {
		  flashInsert(error="There was an error updating the setting.");
			renderPage(action="edit");
		}
  }
  
  // fgbc_metas/delete/key
  public void function delete(){
    setting = model("Fgbcsetting").findByKey(params.key);

		if (setting.delete()){
			flashInsert(success="The setting was deleted successfully.");
      redirectTo(action="index");
    } else {
      flashInsert(error="There was an error deleting the setting.");
			redirectTo(action="index");
    }
  }
  
}
