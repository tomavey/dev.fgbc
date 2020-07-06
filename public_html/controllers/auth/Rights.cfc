component extends="Controller" output="false" {

<!-------------------------------------->
<!---------------Basic CRUD------------->
<!-------------------------------------->

	<!--- rights/index route="authRightsIndex"--->
	public function index() {
		rights = model("Authright").findAll(order="name")
	}
	
	<!--- rights/show/key route="authRightShow"--->
	public function show(key=params.key){
		right = model("Authright").findByKey(arguments.key)
		groups = model("Authgroupsright").findAll(where="auth_rightsId = '#arguments.key#'", include="group", order="name")
		if ( !IsObject(right) ) {
			flashInsert(error="Right #arguments.key# was not found")
			redirectTo(action="index")
		}
	}

	<!--- rights/new route="authRightNew"--->
	public function new(){
		right = model("Authright").new()
	}
	
	<!--- rights/edit/key route="authRightEdit"--->
	public function edit(key=params.key) {
		right = model("Authright").findByKey(arguments.key)
		if ( !isObject(right) ) {
			flashInsert(error="Right #params.key# was not found")
			redirectTo(action="index")			
		}
	}
	
	<!--- rights/create route="authRightCreate"--->
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
	
	<!--- rights/update route="authRightUpdate"--->
	public function update(key=params.key) {
		right = model("Authright").findByKey(arguments.key)
		if ( right.update(params.right) ) {
			redirectTo(action="index")
		} else {
			flashInsert(error="There was an error updating the right.")
			renderPage(action="edit")
		}
	}
		
	<!--- rights/delete/key route="authRightDelete"--->
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
