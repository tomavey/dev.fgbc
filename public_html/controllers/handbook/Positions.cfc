component extends="Controller" output="false" {

	public function init() {
		usesLayout(template="/handbook/layout_handbook", except="download");
		filters(through="gotBasicHandbookRights");
	}
	//  handbook-positions/index 

	public function index() {
		handbookpositions = model("HandbookPosition").findAll();
	}
	//  handbook-positions/show/key 

	public function show() {
		//  Find the record 
		handbookposition = model("HandbookPosition").findByKey(params.key);
		//  Check if the record exists 
		if ( !IsObject(handbookposition) ) {
			flashInsert(error="HandbookPosition #params.key# was !found");
			redirectTo(action="index");
		}
	}
	//  handbook-positions/new 

	public function new() {
		handbookposition = model("Handbookposition").new();
		handbookposition.personid = params.key;
		if ( isDefined("params.organizationid") ) {
			handbookposition.organizationid = params.organizationid;
			thisOrganization = model("Handbookorganization").findOne(where="id=#params.organizationid#", include="State");
		}
		if ( isDefined("params.position") ) {
			handbookposition.position = urlDecode(params.position);
		}
		if ( isDefined("params.sortorder") ) {
			handbookposition.p_sortorder = params.sortorder;
		}
		if ( isDefined("params.positiontypeid") ) {
			handbookposition.positiontypeid = params.positiontypeid;
		}
		thisperson = model("Handbookperson").findByKey(key=params.key, include="Handbookstate");
		organizations = model("Handbookorganization").findall(where="show_in_handbook = 'yes'", include="handbookstate,handbookstatus", order="selectNameCity");
		positionTypes = model("HandbookpositionType").findall(order="position");
	}
	//  handbook-positions/edit/key 

	public function edit() {
		//  Find the record 
		handbookposition = model("HandbookPosition").findByKey(params.key);
		//  Check if the record exists 
		if ( !IsObject(handbookposition) ) {
			flashInsert(error="HandbookPosition #params.key# was !found");
			redirectTo(action="index");
		}
	}
	//  handbook-positions/create 

	public function create() {
		handbookposition = model("HandbookPosition").new(params.handbookposition);
		//  Verify that the handbookposition creates successfully 
		if ( handbookposition.save() ) {
			flashInsert(success="The handbookposition was created successfully.");
			returnBack();
			// cfset redirectTo(controller="handbookpeople", action="show", key=handbookPosition.personid)
			//  Otherwise 
		} else {
			flashInsert(error="There was an error creating the handbookposition.");
			renderPage(action="new");
		}
	}
	//  handbook-positions/update 

	public function update() {
		handbookposition = model("HandbookPosition").findByKey(params.key);
		//  Verify that the handbookposition updates successfully 
		if ( handbookposition.update(params.handbookposition) ) {
			flashInsert(success="The handbookposition was updated successfully.");
			redirectTo(action="index");
			//  Otherwise 
		} else {
			flashInsert(error="There was an error updating the handbookposition.");
			renderPage(action="edit");
		}
	}
	//  handbook-positions/delete/key 

	public function delete() {
		handbookposition = model("HandbookPosition").findByKey(params.key);
		//  Verify that the handbookposition deletes successfully 
		if ( handbookposition.delete() ) {
			flashInsert(success="The handbookposition was deleted successfully.");
			returnback();
			//  Otherwise 
		} else {
			flashInsert(error="There was an error deleting the handbookposition.");
			returnback();
		}
	}

	public function listpeople() {
		var whereString = "p_sortorder < 500 AND personid <> 1 AND fname <> 'No'";
		if ( isDefined("params.positionTypeId") && params.positionTypeId ) {
			whereString = whereString & " AND id=#params.positionTypeId#";
		}
		positions = model("Handbookpositiontype").findall(where=whereString, include="Handbookpositions(Handbookperson(Handbookstate),Handbookorganization)", order="position,lname,fname");
		if ( isDefined("params.plain") ) {
			renderPage(layout="/layout_naked");
		}
	}

	public function orphanedPositions(){
		orphanedPositions = model("Handbooktag").findOrphanedPositions()
	}


	public function orphanedpositions(){

	}

	function deleteOrphanedPositions(){
		orphanedTags = model("Handbooktag").findOrphanedTags()
		queryEach(orphanedTags, function(el){
			var tag = model("Handbooktag").findOne(where="id=#el.id#")
			tag.delete()
		})
		redirectTo(action="orphanedTags")
	}



}
