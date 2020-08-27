component extends="Controller" output="false" {

	public function init() {
		filters(through="checkOffice", only="index,edit");
	}


<!----------------------------->
<!-----------CRUD-------------->
<!----------------------------->
	//  menus/index 
	public function index() {
		menus=model("Mainmenu").findAll(order="category,name");
	}

	//  menus/show/key 
	public function show() {
		//  Find the record 
		menu = model("Mainmenu").findByKey(params.key);
		//  Check if the record exists 
		if ( !IsObject(menu) ) {
			flashInsert(error="Menu #params.key# was !found");
			redirectTo(action="index");
		}
	}
	//  menus/new 

	public function new() {
		menu = model("Mainmenu").new();
	}
	//  menus/edit/key 

	public function edit() {
		//  Find the record 
		menu = model("Mainmenu").findByKey(params.key);
		//  Check if the record exists 
		if ( !IsObject(menu) ) {
			flashInsert(error="Menu #params.key# was !found");
			redirectTo(action="index");
		}
	}
	//  menus/create 

	public function create() {
		menu = model("Mainmenu").new(params.menu);
		//  Verify that the menu creates successfully 
		if ( menu.save() ) {
			flashInsert(success="The menu was created successfully.");
			redirectTo(action="index");
			//  Otherwise 
		} else {
			flashInsert(error="There was an error creating the menu.");
			renderPage(action="new");
		}
	}
	//  menus/update 

	public function update() {
		menu = model("Mainmenu").findByKey(params.key);
		//  Verify that the menu updates successfully 
		if ( menu.update(params.menu) ) {
			flashInsert(success="The menu was updated successfully.");
			redirectTo(action="index");
			//  Otherwise 
		} else {
			flashInsert(error="There was an error updating the menu.");
			renderPage(action="edit");
		}
	}
	//  menus/delete/key 

	public function delete() {
		menu = model("Mainmenu").findByKey(params.key);
		//  Verify that the menu deletes successfully 
		if ( menu.delete() ) {
			flashInsert(success="The menu was deleted successfully.");
			redirectTo(action="index");
			//  Otherwise 
		} else {
			flashInsert(error="There was an error deleting the menu.");
			redirectTo(action="index");
		}
	}
<!----------------------------->
<!-----------END OF CRUD------->
<!----------------------------->




<!------------------------------>
<!-----------UNUSED??----------->
<!------------------------------>
	// public function XmoveUp(category="office") {
	// 		menus= model('menu').findall(where="category = '#arguments.category#'", order="category,sortorder,name");
	// 		cfoutput( query="menus" ) {
	// 			menu = model('menu').findOne(menus.id);
	// 			menu.sortorder = menus.currentRow;
	// 			menu.update(sortorder=menus.currentRow);
	// 		}
	// 		redirectTo(controller="menus", action="index");
	// 	}

	// public function XfellowshipCouncil() {
	// 	location( "http://www.charisfellowship.us/fc?code=fellowshipcouncil&email=#session.auth.email#" );
	// }

	// public function XfellowshipCouncilDev() {
	// 	location( "http://www.charisfellowship.us/fc?code=fellowshipcouncil&email=#session.auth.email#" );
	// }

	// public function Xhandbookadmin() {
	// 	unlockKey = getKey(session.auth.email);
	// 	location( "http://www.charisfellowship.us/handbook/adm?key=#unlockKey#" );
	// }

	// public function XhandbookadmiDev() {
	// 	unlockKey = getKey(session.auth.email);
	// 	location( "http://www.charisfellowship.us/handbook/adm?key=#unlockKey#" );
	// }

	// public function Xmyfgbc() {
	// 	unlockKey = getKey(session.auth.email);
	// 	location( "http://my.charisfellowship.us/data?key=#unlockKey#" );
	// }

	// public function Xmyfgbc() {
	// 	location( "http://www.charisfellowship.us/data?unlock=charis" );
	// }

}
