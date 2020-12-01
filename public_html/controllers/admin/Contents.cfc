component extends="Controller" output="false" {

	function config(){
		filters(through="isPageEditor", only="edit,index")
		filters(through="checkOffice", only="new,delete")
		filters(through="getAllRights", only="new,edit,create")
		filters(through="setReturn", only="show,index")
	}	

	<!---filters--->	
	function getAllRights(){
		rights = model("Authright").findAll(order="name")
	}

	
<!--------------------------------->
<!------------CRUD----------------->
<!--------------------------------->

	<!--- contents/index --->
	function index(){
		var whereString = ""
		if ( isDefined('params.category') ) {
			whereString = "category = '#params.category#'"
		}
		contents = model("Maincontent").findAll(where=whereString, order="createdAt DESC")
		categoriesList = removeDuplicatesFromList(ValueList(contents.category,","))
	}	

 	<!--- contents/show/key --->
	 function show(){
		if (isDefined("params.shortlink")){
			content = model("Maincontent").findOne(where="shortlink='#params.shortlink#'")
			params.key = params.shortlink			
		} else {
			content = model("Maincontent").findByKey(params.key)
		}
		if (!isObject(content)){
			flashInsert(error="Content #params.key# was not found")
			redirectTo(action="index")
		}
	}

	<!--- contents/new --->
	function new(){
		content = model("Maincontent").new()
		if ( isDefined("session.auth.email") ) {
			content.author = session.auth.email
		}
	}

	<!--- contents/edit/key --->
	function edit(){
		content = model("Maincontent").findByKey(params.key)
		if (!isObject(content)){
			flashInsert(error="Content #params.key# was not found")
			redirectTo(action="index")
		}
	}

	<!--- contents/create --->
	function create(){
		content = model("Maincontent").new(params.content)
		if (content.save()) {
			flashInsert(success="The content was created successfully.")
			returnBack()
		} else {
			flashInsert(error="There was an error creating the content.")
			renderView(action="new")
		}
	}

	<!--- contents/update --->
	function update(){
		content = model("Maincontent").findByKey(params.key)
		if(content.update(params.content)){
			flashInsert(success="The content was updated successfully.")
			returnBack()
		} else {
			flashInsert(error="There was an error updating the content.")
			renderView(action="edit")
		}
	}
	
	<!--- contents/delete/key --->
	function delete(){
		content = model("Maincontent").findByKey(params.key)
		if(content.delete()){
			flashInsert(success="The content was deleted successfully.")
			redirectTo(action="index")
		} else {
			flashInsert(error="There was an error deleting the content.")
			redirectTo(action="index")
		}
	}

	<!---- Special View Controllers--->

	function manualOfProcedure(){
		redirectTo(action="show", key=19)
	}

	function constitution(){
		redirectTo(action="show", key=18)
	}

	function statementoffaith(){
		redirectTo(action="show", key=30)
	}

}

