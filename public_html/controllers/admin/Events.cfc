component extends="Controller" output="false" {
	
	<!--- Initialize --->
	function init(){
		filters(through="isSuperadmin", only="index,edit,show,new,delete")
		filters(through="setReturn", only="list,index,show")
		filters(through="getEvent", only="copy,edit,update")
	}	

	<!--- filters --->
	function getEvent(){
		event = model("Mainevent").findByKey(params.key)
	}

<!--------------------------------->
<!------------CRUD----------------->
<!--------------------------------->

	<!--- events/index --->
	function index(){
		var orderString = 'begin DESC,end';
		if(isDefined('params.sortby')){
			if (params.sortBy is 'ascendingDates') { orderString = "begin,end"}
			if (params.sortBy is 'sponsor') { orderString = "sponsor"}
			if (params.sortBy is 'event') { orderString = "event"}
		}
		events = model("Mainevent").findAll(order=orderString);
	}

	<!--- events/show --->
	function show(){
		if (!isDefined('params.key')){ writeOutput("No event selected"); abort; }
		event = model("Mainevent").findAll(where="id=#params.key#")
	}

	<!--- events/new --->
	function new() {
		event = model("Mainevent").new()
	}

	<!--- events/copy/key ---->
	function copy(){
		if (!isObject(event)) {
			flashInsert(error="Event #params.key# was not found")
			returnBack()
		}
		renderPage(action="new")
	}

	<!--- events/edit/key --->
	function edit(){
		event.begin = dateformat(event.begin,"yyyy-mm-dd")
		event.end = dateformat(event.end,"yyyy-mm-dd")
		if (!isObject(event)) {
			flashInsert(error="event #params.key# was not found")
			redirectTo(action="index")
		}
	}

	<!--- events/create --->
	function create(){
		event = model("Mainevent").new(params.event)
		if (event.save()) {
			flashInsert(success="The Charis Fellowsip event was created successfully.")
			redirectTo(action="index")
		} else {
			flashInsert(error="There was an error creating the event.")
			renderPage(action="new")
		}
	}

	<!--- events/update --->
	function update() {
		if (event.update(params.event)){
			flashInsert(success="The Charis Fellowship event was updated successfully.")
			returnBack()
		} else {
			flashInsert(error="There was an error updating the event.")
			renderPage(action="edit")
		}
	}

	<!--- events/delete/key --->
	function delete(){
		event = model("Mainevent").findByKey(params.key)
		if (event.delete()) {
			flashInsert(success="The event was deleted successfully.")
			redirectTo(action="index")
		} else {
			flashInsert(error="There was an error deleting the event.")
			redirectTo(action="index")
		}
	}

}