component extends="Controller" output="false" {

	public function init() {
		filters(through="checkOffice", only="adminindex,edit,new,delete");
		filters(through="setReturn", only="index,show");
	}
	// ----
	// CRUD
	// ----
	// announcements/index

	public function index() {
		cfparam( default=1, name="params.page" );
		cfparam( default=20, name="params.perpage" );
		if ( isDefined("params.showall") ) {
			params.whereString = "";
			params.perpage = 10000000000000000;
		} else if ( isDefined("params.announcements") ) {
			params.whereString = "endAt > now() AND onhold = 'N' AND (type = 'Announcement Only' OR type = 'Both' OR type = '')";
			params.perpage = 10000000000000000;
		} else if ( isDefined("params.feeds") ) {
			params.whereString = "(type = 'News Feed Only' OR type = 'Both' OR type = '')";
			params.perpage = 10000000000000000;
		} else {
			params.whereString = "endAt > now() AND onhold = 'N'";
		}
		if ( isDefined("params.search") AND len(params.search) ) {
			params.whereString = params.whereString & " AND (title LIKE '%#params.search#%' OR content LIKE '%#params.search#%')";
		}
		announcements = model("Mainannouncement").findall(where=params.whereString, order="startAt DESC", page=params.page, perpage=params.perpage);
	}
	//  announcements/show/key 

	public function show() {
		//  Find the record 
		announcement = model("Mainannouncement").findByKey(params.key);
		//  Check if the record exists 
		if ( !IsObject(announcement) ) {
			flashInsert(error="Announcement #params.key# was !found");
			redirectTo(action="index");
		}
	}
	//  announcements/new 

	public function new() {
		announcement = model("Mainannouncement").new();
	}
	//  announcements/edit/key 

	public function edit() {
		//  Find the record 
		announcement = model("Mainannouncement").findByKey(params.key);
		//  Check if the record exists 
		if ( !IsObject(announcement) ) {
			flashInsert(error="Announcement #params.key# was !found");
			redirectTo(action="index");
		}
	}
	//  announcements/copy/key 

	public function copy() {
		//  Find the record 
		announcement = model("Mainannouncement").findByKey(params.key);
		//  Check if the record exists 
		if ( !IsObject(announcement) ) {
			flashInsert(error="Announcement #params.key# was !found");
			redirectTo(action="index");
		}
		renderPage(action="new");
	}
	//  announcements/create 

	public function create() {
		announcement = model("Mainannouncement").new(params.announcement);
		//  Verify that the announcement creates successfully 
		if ( announcement.save() ) {
			// cfset $uploadImage(params.announcement.image)
			flashInsert(success="The announcement was created successfully.");
			returnBack();
			redirectTo(action="index");
			//  Otherwise 
		} else {
			flashInsert(error="There was an error creating the announcement.");
			renderPage(action="new");
		}
	}
	//  announcements/update 

	public function update() {
		announcement = model("Mainannouncement").findByKey(params.key);
		//  Verify that the announcement updates successfully 
		if ( announcement.update(params.announcement) ) {
			// cfset $uploadImage(params.announcement.image)
			flashInsert(success="The announcement was updated successfully.");
			returnBack();
			redirectTo(action="index");
			//  Otherwise 
		} else {
			flashInsert(error="There was an error updating the announcement.");
			renderPage(action="edit");
		}
	}
	//  announcements/delete/key 

	public function delete() {
		announcement = model("Mainannouncement").findByKey(params.key);
		//  Verify that the announcement deletes successfully 
		if ( announcement.delete() ) {
			flashInsert(success="The announcement was deleted successfully.");
			redirectTo(action="index");
			//  Otherwise 
		} else {
			flashInsert(error="There was an error deleting the announcement.");
			redirectTo(action="index");
		}
	}
	// End of Crud


}
