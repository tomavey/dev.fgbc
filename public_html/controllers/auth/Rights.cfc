component extends="Controller" output="false" {

<!-------------------------------------->
<!---------------Basic CRUD------------->
<!-------------------------------------->

	<!--- rights/index --->
	public function index() {
		rights = model("Authright").findAll(order="name")
	}
	
	<!--- rights/show/key --->
	public function show(key=params.key){
		right = model("Authright").findByKey(arguments.key)
		groups = model("Authgroupsright").findAll(where="auth_rightsId = '#arguments.key#'", include="group", order="name")
		if ( !IsObject(right) ) {
			flashInsert(error="Right #arguments.key# was not found")
			redirectTo(action="index")
		}
		renderPage(layout="/layoutadmin")
	}

	<!--- rights/new --->
	public function new(){
		right = model("Authright").new()
	}
	
	<!--- rights/edit/key --->
	public function edit(key=params.key) {
		right = model("Authright").findByKey(arguments.key)
		if ( !isObject(right) ) {
			flashInsert(error="Right #params.key# was not found")
			redirectTo(action="index")			
		}
		renderPage(layout="/layoutadmin")
	}
	
	<!--- rights/create --->
	public function create(right=params.right){
		right = model("Authright").new(arguments.right)
		if ( right.save() ) {
			flashInsert(success="The right was created successfully.")
			redirectTo(action="index")
		} else {
			flashInsert(error="There was an error creating the right.")
			renderPage(action="new")
		}
	}
	
	<!--- rights/update --->
	public function update(key=params.key) {
		right = model("Authright").findByKey(arguments.key)
		if ( right.update() ) {
			redirectTo(action="index")
		} else {
			flashInsert(error="There was an error updating the right.")
			renderPage(action="edit")
		}
	}
		
	<!--- rights/delete/key --->
	public function delete(key=params.key) {
		right = model("Authright").findByKey(arguments.key)
		if ( right.delete() ) {
			flashInsert(success="The right was deleted successfully.")
			groupsright = model("Authgroupsright").deleteAll(where="auth_rightsid=#params.key#")
			redirectTo(action="index")
		} else {
			flashInsert(error="There was an error deleting the right.")
			redirectTo(action="index")
		}
	}

}
