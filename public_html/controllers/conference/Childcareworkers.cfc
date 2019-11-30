component extends="Controller" output="false" {

	public function init() {
		usesLayout("/conference/layout");
		filters(through="getStates");
	}

	public function getStates() {
		states = model("Handbookstate").findall(order="state");
	}

// -----------------------------------
// CRUD
// -----------------------------------	

	//  Childcareworkers/index 
	public function index() {
		childcareworkers = model("Conferencechildcareworker").findAll();
	}

	//  Childcareworkers/show/key 
	public function show() {
		//  Find the record 
		childcareworkers = model("Conferencechildcareworker").findOne(where="id=#params.key#", include="State");
		//  Check if the record exists 
		if ( !IsObject(childcareworkers) ) {
			flashInsert(error="Childcareworkers #params.key# was !found");
			redirectTo(action="index");
		}
	}

	//  Childcareworkers/new 
	public function new() {
		childcareworkers = model("Conferencechildcareworker").new();
	}

	//  Childcareworkers/edit/key 
	public function edit() {
		//  Find the record 
		childcareworkers = model("Conferencechildcareworker").findByKey(params.key);
		//  Check if the record exists 
		if ( !IsObject(Childcareworkers) ) {
			flashInsert(error="Childcareworkers #params.key# was !found");
			redirectTo(action="index");
		}
	}

	//  Childcareworkers/create 
	public function create() {
		childcareworkers = model("Conferencechildcareworker").new(params.Childcareworkers);
		//  Verify that the Childcareworkers creates successfully 
		if ( childcareworkers.save() ) {
			flashInsert(success="The Childcareworkers was created successfully.");
			redirectTo(action="sendEmailNotification", key=childcareworkers.id);
			//  Otherwise 
		} else {
			flashInsert(error="There was an error creating the Childcareworkers.");
			renderPage(action="new");
		}
	}

	//  Childcareworkers/update 
	public function update() {
		childcareworkers = model("Conferencechildcareworker").findByKey(params.key);
		//  Verify that the Childcareworkers updates successfully 
		if ( childcareworkers.update(params.Childcareworkers) ) {
			flashInsert(success="The Childcareworkers was updated successfully.");
			redirectTo(action="index");
			//  Otherwise 
		} else {
			flashInsert(error="There was an error updating the Childcareworkers.");
			renderPage(action="edit");
		}
	}

	//  Childcareworkers/delete/key 
	public function delete() {
		childcareworkers = model("Conferencechildcareworker").findByKey(params.key);
		//  Verify that the Childcareworkers deletes successfully 
		if ( childcareworkers.delete() ) {
			flashInsert(success="The Childcareworkers was deleted successfully.");
			redirectTo(action="index");
			//  Otherwise 
		} else {
			flashInsert(error="There was an error deleting the childcareworker.");
			redirectTo(action="index");
		}
	}

// ----------------------------------
// END OF CRUD
// ----------------------------------




	public function sendEmailNotification() {
		childcareworkers = model("Conferencechildcareworker").findOne(where="id=#params.key#", include="State");
		SendToAddresses = application.wheels.childcarenotifications;
		if ( isDefined("childcareworkers.email") ) {
			SendToAddresses = SendToAddresses & "," & childcareworkers.email;
		}
		if ( isDefined("childcareworkers.parentsemail") ) {
			SendToAddresses = SendToAddresses & "," & childcareworkers.parentsemail;
		}
		sendEmail(to=sendtoaddresses, from="flinch@fgbc.org", subject="New Childcare Worker Application", template="sendemailnotification", layout="/layout_for_email");
	}

}
