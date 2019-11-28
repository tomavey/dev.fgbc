component extends="Controller" output="false" {

	public function init() {
		filters(through="setReturn", only="show,index");
		/* 
		<cfset filters(through="logview", type="after")>
		*/
	}

<!------------------------->
<!------CRUD--------------->
<!------------------------->

	//  ministries/index 
	public function index() {
		ministries = model("Mainministry").findAll(order="category,name");
	}

	//  ministries/list 
	public function list() {
		if ( isdefined("params.key") ) {
			wherestring = "id=#params.key#";
		} else if ( isDefined("params.category") ) {
			wherestring = "category='#params.category#'";
		} else {
			wherestring = "";
		}
		ministry = model("Mainministry").findAll(where=whereString, order="category,name");
		categories = model("Mainministry").findAll(where="category <> 'none'", order="category,name");
	}

	//  ministries/new 
	public function new() {
		ministry = model("Mainministry").new();
	}

	<!--- ministries/edit/key --->
	function edit( key=params.key ) {
		ministry = model("Mainministry").findByKey(params.key)
		if ( !isObject(ministry) ) {
			redirectTo(action="index", error="ministry #params.key# was not found")
		}
	}

	//  ministries/create 
	public function create() {
		ministry = model("Mainministry").new(params.ministry);
		//  Verify that the ministry creates successfully 
		if ( ministry.save() ) {
			flashInsert(success="The ministry was created successfully.");
			redirectTo(action="index");
			//  Otherwise 
		} else {
			flashInsert(error="There was an error creating the ministry.");
			renderPage(action="new");
		}
	}

	//  ministries/show 
	public function show() {
		wherestring = "id=#params.key#";
		ministry = model("Mainministry").findAll(where=whereString, order="category,name");
	}

	//  ministries/update 
	public function update() {
		ministry = model("Mainministry").findByKey(params.key);
		//  Verify that the ministry updates successfully 
		if ( ministry.update(params.ministry) ) {
			flashInsert(success="The ministry was updated successfully.");
			returnBack();
			//  Otherwise 
		} else {
			flashInsert(error="There was an error updating the ministry.");
			renderPage(action="edit");
		}
	}

	//  ministries/delete/key 
	public function delete() {
		ministry = model("Mainministry").findByKey(params.key);
		//  Verify that the ministry deletes successfully 
		if ( ministry.delete() ) {
			flashInsert(success="The ministry was deleted successfully.");
			redirectTo(action="index");
			//  Otherwise 
		} else {
			flashInsert(error="There was an error deleting the ministry.");
			redirectTo(action="index");
		}
	}
<!------------------------->
<!------END OF CRUD-------->
<!------------------------->



	private function includeInFooterToBinary(required string includeInFooter) {
		if ( includeInFooter is "Yes" ) { return 1 } else { return 0}
	}

	// Get Settings
	function getministryCategories(){
		var activeMinistries = model("Mainministry").findAll(where="status <>'inactive'")
		var categories = listSort(valueList(activeMinistries.category,","),"text")
		categories = removeDuplicatesFromList(categories)
		return categories;
	}

	public function simpleList() {
		// used for insider cover of handbook
		wherestring = "status <>'inactive' && category in ('Church Planting Ministries','Doing Good', 'Communication', 'Leadership Training Ministries') && name !LIKE 'Camp%'";
		ministries = model("Mainministry").findAll(where=whereString, order="name");
	}


}
