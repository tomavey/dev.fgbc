component extends="Controller" output="false" {

	function config(){
		filters(through="setReturn", only="list,index,show")
	}

	<!----------CRUD---------------->	
	<!----------CRUD---------------->	
	<!----------CRUD---------------->	

	<!--- jobs/index/key --->
	function index(){
		if ( isDefined("params.key") ) {
			job = model("Mainjob").findAll(where="id=#params.key#")
		} else if ( gotrights("superadmin,office") ) {
			job = model("Mainjob").findAll(order="createdAt DESC")
		} else {
			job = model("Mainjob").findAll(where="expirationdate > now() AND approved='Y'", order="createdAt DESC")
		}
	}

	function show(){
		job = model("Mainjob").findAll(where="id=#params.key#")
	}

	<!--- jobs/new --->
	function new(){
		job = model("Mainjob").new()
		strCaptcha = getcaptcha()
		formAction="create"
	}

	<!--- jobs/create --->
	function create(){
		if ( len(params.captcha) && params.captcha is decrypt(params.captcha_check,getSetting("passwordkey"),"CFMX_COMPAT","HEX") ) {
			params.job.uuid = CreateUUID()
			params.job.uuid = replace(params.job.uuid,"-","","all")
			job = model("Mainjob").new(params.job)

			if ( job.save() ) {
				flashInsert(success="The Job was created successfully.")
				redirectTo(action="sendnotice", key=job.id)
			} else {
				flashInsert(error=errorMessagesFor("job"))
				strCaptcha = getcaptcha()
				renderView(action="new")
			}
		} else {
			flashInsert(error="Please try to enter the scrambled image again.")
			job = model("Mainjob").new(params.job)
			strCaptcha = getcaptcha()
			renderView(action="new")
		}
	}

	<!--- jobs/edit/key --->
	function edit(){
		<!--- Find the record by uuid --->
		job = model("Mainjob").findOne(where="uuid='#params.id#'")

		if ( isObject(job) ) {
			params.key = job.id
			strCaptcha = getcaptcha()
		} else {
			flashInsert(error="This position opportunity was (#params.id#) was not found")
			redirectTo(action="index")
		}
	}
	
	<!--- jobs/update --->
	function update(){
		job = model("Mainjob").findByKey(params.key)
		if ( job.update(params.job) ){
			flashInsert(success="The job was updated successfully.")
			redirectTo(action="thankyou", key=job.uuid)
		} else {
			flashInsert(error="There was an error updating the job.")
			renderView(action="edit")
		}
	}

	<!--- jobs/delete/key --->
	function delete(){
		job = model("Mainjob").findByKey(params.key)
		if ( job.delete() ){
			flashInsert(success="The job was deleted successfully.")
			redirectTo(action="index")
		} else {
			flashInsert(error="There was an error deleting the job.")
			redirectTo(action="index")
		}
	}

	<!----------OTHER REPORTS---------------->	
	<!----------OTHER REPORTS---------------->	
	<!----------OTHER REPORTS---------------->	

	function thankyou(){
		job = model("Mainjob").findOne(where ="uuid='#params.key#'")
		if ( !job.approved == 'n' ) {
			thankyouMessage = 'We will review and approve the posting as soon as possible.'
		} else {
			thankyouMessage = 'We will review your changes and let you know if there are any problems.'
		}
	}


	<!----------FUNCTIONS METHODS - NO VIEW---------------->
	<!----------FUNCTIONS METHODS - NO VIEW---------------->
	<!----------FUNCTIONS METHODS - NO VIEW---------------->

	//approve a job posting using the link in email notification sent to admin
	function approve(){
		job = model("Mainjob").findByKey(params.key)
		job.approved = "Y"
		job.update()
		job = model("Mainjob").findAll(where="id=#params.key#")
		renderView(controller="admin.jobs", action="show")
	}

	function sendnotice(){
		job = model("Mainjob").findByKey(params.key)
		if ( !isLocalMachine() ){
			sendEmail(template="emailjob", from=job.email, to=getSetting("sendJobNoticesTo"), subject="New Jobs Post", key=params.key, description=job.description)
		} 
		redirectTo(action="thankyou", key=job.uuid)
	}

}