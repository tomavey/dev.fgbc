component extends="Controller" output="false" {

	public function config() {
		filters(through="logview", type="after");
	}

<!------------------------->
<!------CRUD--------------->
<!------------------------->

	//  resources/index 
	public function index() {
		resources = model("Mainresource").findAll();
		setReturn();
	}

	public function list() {
		resources = model("Mainresource").findAll(order="description");
	}

	//  resources/show/key 
	public function show() {
		if ( isdefined("params.key") ) {
			//  Find the record 
			resource = model("Mainresource").findByKey(params.key);
			//  Check if the record exists 
			if ( !IsObject(resource) ) {
				flashInsert(error="Resource #params.key# was !found");
				redirectTo(action="index");
			}
		} else {
			resource = model("Mainresource").findAll();
		}
	}

	//  resources/new 
	public function new() {
		resource = model("Mainresource").new();
	}

	//  resources/edit/key 
	public function edit() {
		//  Find the record 
		resource = model("Mainresource").findByKey(params.key);
		//  Check if the record exists 
		if ( !IsObject(resource) ) {
			flashInsert(error="Resource #params.key# was !found");
			redirectTo(action="index");
		}
	}

	//  resources/create 
	public function create() {
		resource = model("Mainresource").new(params.resource);
		//  Verify that the resource creates successfully 
		if ( resource.save() ) {
			flashInsert(success="The resource was created successfully.");
			returnback();
			//  Otherwise 
		} else {
			flashInsert(error="There was an error creating the resource.");
			renderView(action="new");
		}
	}

	//  resources/update 
	public function update() {
		resource = model("Mainresource").findByKey(params.key);
		//  Verify that the resource updates successfully 
		if ( resource.update(params.resource) ) {
			flashInsert(success="The resource was updated successfully.");
			returnback();
			//  Otherwise 
		} else {
			flashInsert(error="There was an error updating the resource.");
			renderView(action="edit");
		}
	}

	//  resources/delete/key 
	public function delete() {
		resource = model("Mainresource").findByKey(params.key);
		//  Verify that the resource deletes successfully 
		if ( resource.delete() ) {
			flashInsert(success="The resource was deleted successfully.");
			redirectTo(action="index");
			//  Otherwise 
		} else {
			flashInsert(error="There was an error deleting the resource.");
			redirectTo(action="index");
		}
	}

}
