component extends="Controller" output="false" {

	public function config() {
		usesLayout("/conference/adminlayout");
		filters(through="officeOnly", only="edit,delete");
		filters(through="isExhibitsOpen", only="new,info");
		filters(through="setReturn", only="list,index");
	}
	// Filters

	public function isExhibitsOpen() {
		if ( getSetting('exhibitorsIsOpen') || gotrights("office") ) {
			return true;
		} else {
			renderText("<h2 style='text-align:center'>#getEventAsText()# == just around the corner! Exhibits are all set.  Check back next year.</h2>");
		}
	}
	// -----
	// CRUD-
	// -----
	//  exhibits/index 

	public function index() {
		orderby = "organization";
		if ( isDefined("params.event") ) {
			whereString = "event='#params.event#'";
		} else {
			whereString = "event='#getEvent()#'";
		}
		if ( isDefined("params.history") ) {
			whereString = "";
		}
		if ( isDefined("params.sortby") ) {
			orderby = params.sortby;
		}
		exhibits = model("Conferenceexhibit").findAll(where=whereString, order=orderby);
	}
	//  exhibits/show/key 

	public function show() {
		//  Find the record 
		exhibit = model("Conferenceexhibit").findByKey(params.key);
		//  Check if the record exists 
		if ( !IsObject(exhibit) ) {
			flashInsert(error="Exhibit #params.key# was !found");
			redirectTo(action="index");
		}
	}
	//  exhibits/new 

	public function new() {
		exhibit = model("Conferenceexhibit").new();
		introTitle = "Exhibitors Request Form";
		renderView(layout="/conference/layout2018");
	}
	//  exhibits/create 

	public function create() {
		params.exhibit.event = getEvent();
		exhibit = model("Conferenceexhibit").create(params.exhibit);
		if ( exhibit.hasErrors() ) {
			flashInsert(error="There was an error creating the exhibit.");
			renderView(action="new");
		} else {
			flashInsert(success="The exhibit was created successfully.");
			if ( !isLocalMachine() ) {
				sendemail(from=exhibit.email, to=getSetting("registraremail"), template="email", subject="A Vision Conference Exhibitors request has been submitted", layout="/conference/layout_for_email");
			}
			redirectTo(action="thankyou",key=exhibit.id);
		}
	}
	//  exhibits/edit/key 

	public function edit() {
		//  Find the record 
		exhibit = model("Conferenceexhibit").findByKey(params.key);
		//  Check if the record exists 
		if ( !IsObject(exhibit) ) {
			flashInsert(error="Exhibit #params.key# was !found");
			redirectTo(action="index");
		}
	}
	//  exhibits/update 

	public function update() {
		exhibit = model("Conferenceexhibit").findByKey(params.key);
		//  Verify that the exhibit updates successfully 
		if ( exhibit.update(params.exhibit) ) {
			flashInsert(success="The exhibit was updated successfully.");
			returnBack();
			//  Otherwise 
		} else {
			flashInsert(error="There was an error updating the exhibit.");
			renderView(action="edit");
		}
	}
	//  exhibits/delete/key 

	public function delete() {
		exhibit = model("Conferenceexhibit").findByKey(params.key);
		//  Verify that the exhibit deletes successfully 
		if ( exhibit.delete() ) {
			flashInsert(success="The exhibit was deleted successfully.");
			redirectTo(action="index");
			//  Otherwise 
		} else {
			flashInsert(error="There was an error deleting the exhibit.");
			redirectTo(action="index");
		}
	}
	// ---------------
	// - MISC REPORTS-
	// ---------------

	public function thankyou() {
		exhibit = Model("Conferenceexhibit").findByKey(params.key);
		introTitle = "Thank you!";
		renderView(layout="/conference/layout2018");
	}

	public function info() {
		introTitle = "Exhibitors Information";
		renderView(layout="/conference/layout2017");
	}

	<!--- exhibits/list --->
		public function list(){
			var orderBy = "organization";
			var whereString = "event='#getEvent()#'";
			if (isDefined('params.event')) { whereString = "event='#params.event#'" };
			if (isDefined('params.type') && params.type is "exhibit") { whereString = whereString & " AND type IN ('exhibit', 'both')" };
			if (isDefined("params.type") && (params.type is "sponsor")) { whereString = whereString & " AND type IN ('sponsor', 'both')" };
			if (isDefined("params.sortby")) { orderBy = params.sortby };
			exhibits = model("Conferenceexhibit").findAll(where=whereString, order=orderby);
			renderView(layout="/conference/layout2017");
		}

		// public function history(){
		// 	writeDump(params);abort;
		// 	if ( isDefined("params.orderby") ) { arguments.orderby = params.orderby }
		// 	exhibits = model("Conferenceexhibit").findAll(order=arguments.orderby)
		// 	writeDump(exhibits);abort;
		// }

	<!--- Exhibits/json--->
		public function json () {
			var orderBy = "organization";
			var whereString = "event='#getEvent()#' AND approved = 'Yes'";
			data = model("Conferenceexhibit").findAll(where=whereString, order=orderby);
			data = queryToJson(data);
			renderJson();
		}

}
