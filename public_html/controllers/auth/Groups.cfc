component extends="Controller" output="false" {

	function init(){
		filters(through="isSuperadmin", only="index,edit,show,new,delete")
	}

<!-------------------------------------->
<!---------------Basic CRUD------------->
<!-------------------------------------->

	<!--- -groups/index --->
	public function index(){
		groups = model("Authgroup").findAll(order="name")
	}
	
	<!--- -groups/show/key --->
	public function show() {
		group = model("Authgroup").findByKey(key=params.key)
		rights = model("Authgroupsright").findAll(where="auth_groupsId = #params.key#", include="right", order="name")
		allrights = model("Authright").findAll(order="name")
		if ( !isObject(group) ) {
			redirectTo(action="index", error="Group #params.key# was not found")
		}
	}
	
	<!--- -groups/new --->
	public function new(){
		group = model("Authgroup").new()
	}	

	<!--- -groups/edit/key --->
	public function edit(key=params.key) {
		group = model("Authgroup").findByKey(arguments.key)
		if ( !IsObject(group) ) {
			redirectTo(action="index", error="Group #arguments.key# was not found")
		}
	}
	
	<!--- -groups/create --->
	public function create(group=params.group) {
		group = model("Authgroup").new(arguments.group)
		if ( group.save() ) {
			redirectTo(action="index", success="The group was created successfully.")
		} else {
			renderPage(action="new", error="There was an error creating the group.")
		}
	}

	<!--- -groups/update --->
	private function update(key=params.key) {
		group = model("Authgroup").findByKey(arguments.key)
		if ( group.update(params.group) ) {
			redirectTo(action="index", success="The group was updated successfully.")
		} else {
			renderPage(action="edit", error="There was an error updating the group.")
		}
	}
	
	<!--- -groups/delete/key --->
	public function delete(key=params.key) {
		group = model("Authgroup").findByKey(arguments.key)
		if ( group.delete() ) {
			groupsright = model("Authgroupsright").deleteAll(where="auth_groupsid=#arguments.key#")
			usergroups = model("Authusersgroup").deleteAll(where="auth_groupsid=#params.key#")
			redirectTo(action="index", success="The group was deleted successfully.")
		}
	}

<!------------END of CRUD---------------->	
	
	private function addARight(rightId=params.rightid, groupId=params.key) {
		var check = model("Authgroupsright").findAll(where="auth_rightsId = #arguments.rightID# AND auth_groupsId = #arguments.groupId#")
		if ( !check.recordcount ) {
			Groupsright = model("Authgroupsright").new()
			Groupsright.auth_rightsid = arguments.rightid
			Groupsright.auth_groupsid = arguments.groupid
			if ( Groupsright.save() ) {
				redirectTo(back=true)
			}
			renderText("Not saved - something went wrong!")
		}
		renderText("This group already has this right")
	}

	public function removeRight(rightId=params.rightid, groupId=params.groupid) {
		model("Authgroupsright").deleteAll(where="auth_rightsid='#arguments.rightid#' AND auth_groupsid='#arguments.groupid#'")>
		redirectTo(back=true)
	}

}
	
