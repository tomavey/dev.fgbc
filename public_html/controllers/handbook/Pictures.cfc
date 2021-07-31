component extends="Controller" output="true" {

	public function config() {
		usesLayout("/handbook/layout_handbook1");
		filters(through="setreturn", only="index,show,new");
		filters(through="logview", type="after");
	}

	// Basic CRUD
	//  handbookpictures/index 

	public function index() {
		handbookpictures = model("Handbookpicture").findAllPicturesSorted(params);
		handbookpictures = handbookpictures.filter( (el) => pictureExists(el.file) ) 
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
		handbookpictures = handbookpictures.filter( (el) => pictureExists(el.file) ) 
		handbookpicture.personid = params.personid;
		handbookperson = model("Handbookperson").findOne(where="id=#params.personid#", include="Handbookstate");
		try {
			handbookpicture.createdby = session.auth.email;
		} catch (any cfcatch) {
			handbookpicture.createdby = "tomavey@fgbc.org";
		}
		renderView(layout="/handbook/layout_handbook");
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
			renderView(action="new");
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
			renderView(action="edit");
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


	//Misc Reports

	public function notlist(){
		var people = model("Handbookperson").findAll(include="state", order="selectName")
		people = people.filter(function(person){
			if ( getSortOrder(person.id) >= 500 ) { return false } else { return true }
		})
		peopleWithoutPictures = people.filter(function(person){
			picture = model("Handbookpicture").findOne(where="personId = #person.id#")
			if ( 
				isObject(picture) && 
				!find("Pastor, No",person.selectName)
				) {return false}
			return true
		})
	}

	private function getSortOrder(personId){
		person = model("Handbookposition").findAll(where="personId = #personId#", order="p_sortorder")
		// ddd(person)
		if ( person.recordCount ) { return person.p_sortorder }
		return false
	}

	// Image manipulation methods

	private function thumbnail(required string file) {
		var imageFile = expandpath('.') & '/images/handbookpictures/' & arguments.file
		var thumbFile = expandpath('.') & '/images/handbookpictures/thumb_' & arguments.file
		cfimage( height="", source=imageFile, width=75, name="thumb", overwrite=true, destination=thumbFile, action="resize" );
	}

	private function webimage(required string file) {
		var imageFile = expandpath('.') & '/images/handbookpictures/' & arguments.file
		var webFile = expandpath('.') & '/images/handbookpictures/web_' & arguments.file
		cfimage( height="", source=imageFile, width=600, name="thumb", overwrite=true, destination=webFile, action="resize" );
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


}
