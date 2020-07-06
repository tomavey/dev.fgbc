component extends="Controller" output="false" {


	function init(){
		filters(through="setReturn", only="list,index,show")
	}

<!---------------------------------->
<!----------CRUD-------------------->
<!---------------------------------->

	function index(){
		jobs = model("Mainjob").findAll(order="createdAt DESC")
	}

	function show(){
		if (isDefined('params.key')){
			job = model("Mainjob").findAll(where="id=#params.key#")
		} elseif (gotrights("superadmin,office")) {
			job = model("Mainjob").findAll(order="id DESC")
		} else {
			job = model("Mainjob").findAll(where="expirationdate > now() AND approved='Y'", order="id DESC")
		}
	}

	function new(){
		job = model("Mainjob").new()
		strCaptcha = getcaptcha()
	}

	function edit(){
		job = model("Mainjob").findByKey(params.key)
		strCaptcha = getcaptcha()
		if (!IsObject(job)) {
			flashInsert(error="Job #params.key# was not found")
			redirectTo(action="index")
		}
	}

	function create(){
		if (len(params.captcha) AND params.captcha is decrypt(params.captcha_check,getSetting("passwordkey"),"CFMX_COMPAT","HEX")) {
			params.job.uuid = replace(CreateUUID(),"-","","all")
			job = model("Mainjob").new(params.job)
			if (job.save()) {
				flashInsert(success="The Job was created successfully.")
				redirectTo(action="sendnotice", key=job.id)
			} else {
				flashInsert(error=errorMessagesFor("job"))
				job = model("Mainjob").new(params.job)
				strCaptcha = getcaptcha()
				renderPage(action="new")
			}
		} else {
			flashInsert(error="Please try to enter the scrambled image again.")
			job = model("Mainjob").new(params.job)
			strCaptcha = getcaptcha()
			renderPage(action="new")
		}
	}

	function update() {
		job = model("Mainjob").findByKey(params.key)
		if(job.update(params.job)){
			flashInsert(success="The job was updated successfully.")
			redirectTo(action="index")
		} else {
			flashInsert(error="There was an error updating the job.")
			renderPage(action="edit")
		}
	}

	function delete(){
		job = model("Mainjob").findByKey(params.key)
		if (job.delete()){
			flashInsert(success="The job was deleted successfully.")
			redirectTo(action="index")
		} else {
			flashInsert(error="There was an error deleting the job.")
			redirectTo(action="index")
		}
	}
<!---------------------------------->
<!----------END OF CRUD------------->
<!---------------------------------->





<!-------------->
<!---Services--->
<!-------------->
function sendnotice() {
		job = model("Mainjob").findByKey(params.key)
		if(!isLocalMachine()){
			sendEmail(template="emailjob", from=job.email, to=sendJobNoticesTo(), subject="New Jobs Post", key=params.key, description=job.description)
		}
		redirectTo(action="thankyou", key=params.key)
	}

	function sendJobNoticesTo(){
		return getSetting("sendJobNoticesTo");
	}

	function sendnotice(){
		job = model("Mainjob").findByKey(params.key)
		if (!isLocalMachine()){
			sendEmail(template="emailjob", from=job.email, to=sendJobNoticesTo(), subject="New Jobs Post", key=params.key, description=job.description)
		}
		redirectTo(action="thankyou", key=params.key)
	}
	
	function approve(){
		job = model("Mainjob").findByKey(params.key)
		job.approved = "Y"
		job.update()
		job = model("Mainjob").findAll(where="id=#params.key#")
		renderPage(controller="jobs", action="show")
	}

	function rss(){
		jobs = model("Mainjob").findAll(where="approved='y' AND expirationDate > now()", order="createdAt DESC")
		title = "Charis Fellowship Jobs"
		description= "Ministry Positions posted by Charis Fellowship"
		renderPage(template="rss.cfm", layout="rsslayout")
	}

}