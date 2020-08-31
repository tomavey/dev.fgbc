component extends="Controller" output="false" {

	public function init() {
		usesLayout("/handbook/layout_handbook1");
		filters(through="setreturn", only="index,show,new");
		filters(through="logview", type="after");
	}
	// Basic CRUD
	//  handbookpictures/index 

	public function index() {
		handbookpictures = model("Handbookpicture").findAllPicturesSorted(params);
	}
	//  handbookpictures/show/key 

	public function show() {
		//  Find the record 
		handbookpicture = model("Handbookpicture").findByKey(params.key);
		//  Check if the record exists 
		if ( !IsObject(handbookpicture) ) {
			flashInsert(error="Handbookpicture #params.key# was !found");
			redirectTo(action="index");
		}
	}
	//  handbookpictures/new 

	public function new() {
		if ( !isDefined("params.personid") ) {
			setReturn();
			redirectTo(action="getperson");
		}
		handbookpicture = model("Handbookpicture").new();
		handbookpictures = model("Handbookpicture").findall(where="personid=#params.personid#");
		handbookpicture.personid = params.personid;
		handbookperson = model("Handbookperson").findOne(where="id=#params.personid#", include="Handbookstate");
		try {
			handbookpicture.createdby = session.auth.email;
		} catch (any cfcatch) {
			handbookpicture.createdby = "tomavey@fgbc.org";
		}
		renderPage(layout="/handbook/layout_handbook");
	}
	//  handbookpictures/edit/key 

	public function edit() {
		//  Find the record 
		handbookpicture = model("Handbookpicture").findByKey(params.key);
		//  Check if the record exists 
		if ( !IsObject(handbookpicture) ) {
			flashInsert(error="Handbookpicture #params.key# was !found");
			redirectTo(action="index");
		}
	}
	//  handbookpictures/create 

	public function create() {
		handbookpicture = model("Handbookpicture").new(params.handbookpicture);
		//  Verify that the handbookpicture creates successfully 
		if ( handbookpicture.save() ) {
			model("Handbookpicture").setAsDefault(handbookpicture.id);
			flashInsert(success="The handbookpicture was created successfully.");
			thumbnail(handbookpicture.file);
			webimage(handbookpicture.file);
			returnback();
			//  Otherwise 
		} else {
			flashInsert(error="There was an error creating the handbookpicture.");
			renderPage(action="new");
		}
	}
	//  handbookpictures/update 

	public function update() {
		handbookpicture = model("Handbookpicture").findByKey(params.key);
		//  Verify that the handbookpicture updates successfully 
		if ( handbookpicture.update(params.handbookpicture) ) {
			flashInsert(success="The handbookpicture was updated successfully.");
			thumbnail(handbookpicture.file);
			returnback();
			//  Otherwise 
		} else {
			flashInsert(error="There was an error updating the handbookpicture.");
			renderPage(action="edit");
		}
	}
	//  handbookpictures/delete/key 

	public function delete() {
		handbookpicture = model("Handbookpicture").findByKey(params.key);
		//  Verify that the handbookpicture deletes successfully 
		if ( handbookpicture.delete() ) {
			flashInsert(success="The handbookpicture was deleted successfully.");
			returnBack();
			//  Otherwise 
		} else {
			flashInsert(error="There was an error deleting the handbookpicture.");
			returnBack();
		}
	}
	// Image manipulation methods

	public function thumbnail(required string file) {
		cfimage( height="", source=expandpath('.')#/images/handbookpictures/#arguments.file, width=75, name="thumb", overwrite=true, destination=expandpath('.')#/images/handbookpictures/thumb_#arguments.file, action="resize" );
	}

	public function webimage(required string file) {
		cfimage( height="", source=expandpath('.')#/images/handbookpictures/#arguments.file, width=600, name="thumb", overwrite=true, destination=expandpath('.')#/images/handbookpictures/web_#arguments.file, action="resize" );
	}
	// Misc Methods

	public function setpictureasdefault(id="#params.key#") {
		model("Handbookpicture").setAsDefault(arguments.id);
		returnBack();
	}
	// Requests a user id before displaying a new form

	public function getPerson() {
		people = model("Handbookperson").findAll(include="Handbookstate", order="lname,fname");
	}
	// 142 lines

	public function pictureExists(file){
	var fileToCheck = GetBaseTemplatePath();
	fileToCheck = replace(filetocheck,"index.cfm","");
	fileToCheck = replace(filetocheck,"rewrite.cfm","");
	fileToCheck = fileToCheck & "images\handbookpictures\thumb_" & file;
	return fileExists(fileToCheck);
}

}
