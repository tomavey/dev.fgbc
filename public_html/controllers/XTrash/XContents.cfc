component extends="Controller" output="false" {

	public function init() {
		usesLayout("/conference/adminlayout");
		filters("officeOnly");
	}

// ------------------------------------
// -------------CRUD-------------------
// ------------------------------------

	//  contents/index 
	public function index() {
		contents = model("Conferencecontent").findAll();
	}

	//  contents/show/key 
	public function show() {
		//  Find the record 
		content = model("Conferencecontent").findByKey(params.key);
		//  Check if the record exists 
		if ( !IsObject(content) ) {
			flashInsert(error="content #params.key# was !found");
			redirectTo(action="index");
		}
	}

	//  contents/new 
	public function new() {
		content = model("Conferencecontent").new();
	}

	//  contents/edit/key 
	public function edit() {
		//  Find the record 
		content = model("Conferencecontent").findByKey(params.key);
		//  Check if the record exists 
		if ( !IsObject(content) ) {
			flashInsert(error="content #params.key# was !found");
			redirectTo(action="index");
		}
	}

	//  contents/create 
	public function create() {
		content = model("Conferencecontent").new(params.content);
		//  Verify that the content creates successfully 
		if ( content.save() ) {
			flashInsert(success="The content was created successfully.");
			redirectTo(action="index");
			//  Otherwise 
		} else {
			flashInsert(error="There was an error creating the content.");
			renderPage(action="new");
		}
	}

	//  contents/update 
	public function update() {
		content = model("Conferencecontent").findByKey(params.key);
		//  Verify that the content updates successfully 
		if ( content.update(params.content) ) {
			flashInsert(success="The content was updated successfully.");
			redirectTo(action="index");
			//  Otherwise 
		} else {
			flashInsert(error="There was an error updating the content.");
			renderPage(action="edit");
		}
	}

	//  contents/delete/key 
	public function delete() {
		content = model("Conferencecontent").findByKey(params.key);
		//  Verify that the content deletes successfully 
		if ( content.delete() ) {
			flashInsert(success="The content was deleted successfully.");
			redirectTo(action="index");
			//  Otherwise 
		} else {
			flashInsert(error="There was an error deleting the content.");
			redirectTo(action="index");
		}
	}

}
