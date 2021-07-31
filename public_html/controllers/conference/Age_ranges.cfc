component extends="Controller" output="false" {

	public function config() {
		usesLayout("/conference/adminlayout");
		filters("officeOnly");
	}
	// ------------------------
	// -------CRUD-------------
	// ------------------------

	//  age_ranges/index 
	public function index() {
		age_ranges = model("Conferenceage_range").findAll();
	}
	//  age_ranges/show/key 

	public function show() {
		//  Find the record 
		age_range = model("Conferenceage_range").findByKey(params.key);
		//  Check if the record exists 
		if ( !IsObject(age_range) ) {
			flashInsert(error="Conferenceage_range #params.key# was !found");
			redirectTo(action="index");
		}
	}

	//  age_ranges/new 
	public function new() {
		age_range = model("Conferenceage_range").new();
	}
	//  age_ranges/edit/key 

	public function edit() {
		//  Find the record 
		age_range = model("Conferenceage_range").findByKey(params.key);
		//  Check if the record exists 
		if ( !IsObject(age_range) ) {
			flashInsert(error="Conferenceage_range #params.key# was !found");
			redirectTo(action="index");
		}
	}

	//  age_ranges/create 
	public function create() {
		age_range = model("Conferenceage_range").new(params.age_range);
		//  Verify that the age_range creates successfully 
		if ( age_range.save() ) {
			flashInsert(success="The age_range was created successfully.");
			redirectTo(action="index");
			//  Otherwise 
		} else {
			flashInsert(error="There was an error creating the age_range.");
			renderView(action="new");
		}
	}

	//  age_ranges/update 
	public function update() {
		age_range = model("Conferenceage_range").findByKey(params.key);
		//  Verify that the age_range updates successfully 
		if ( age_range.update(params.age_range) ) {
			flashInsert(success="The age_range was updated successfully.");
			redirectTo(action="index");
			//  Otherwise 
		} else {
			flashInsert(error="There was an error updating the age_range.");
			renderView(action="edit");
		}
	}

	//  age_ranges/delete/key 
	public function delete() {
		age_range = model("Conferenceage_range").findByKey(params.key);
		//  Verify that the age_range deletes successfully 
		if ( age_range.delete() ) {
			flashInsert(success="The age_range was deleted successfully.");
			redirectTo(action="index");
			//  Otherwise 
		} else {
			flashInsert(error="There was an error deleting the age_range.");
			redirectTo(action="index");
		}
	}

}
