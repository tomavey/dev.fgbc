<cfcomponent extends="Controller" output="false">
	

<cfscript>

	function init(){
		filters(through="setReturn", only="list,index,show")
	}

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


	<!---Services--->
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



</cfscript>	

	<cffunction name="Xinit">
		<cfset filters(through="setReturn", only="list,index,show")>
	</cffunction>

	<!--- jobs/index --->
	<cffunction name="Xindex">
		<cfset jobs = model("Mainjob").findAll(order="createdAt DESC")>
	</cffunction>
	
	<!--- jobs/show/key --->
	<cffunction name="Xshow">
		
		<cfif isdefined("params.key")>
			<!--- Find the record --->
	    	<cfset job = model("Mainjob").findAll(where="id=#params.key#")>

		<cfelseif gotrights("superadmin,office")>
		
			<cfset job = model("Mainjob").findAll(order="id DESC")>
	
		<cfelse>
		
			<cfset job = model("Mainjob").findAll(where="expirationdate > now() AND approved='Y'", order="id DESC")>
	
		</cfif>	
    		
	</cffunction>
	
	<!--- jobs/new --->
	<cffunction name="Xnew">
		<cfset job = model("Mainjob").new()>
		<cfset strCaptcha = getcaptcha()>
	</cffunction>
	
	<!--- jobs/edit/key --->
	<cffunction name="Xedit">
	
		<!--- Find the record --->
    	<cfset job = model("Mainjob").findByKey(params.key)>
		<cfset strCaptcha = getcaptcha()>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(job)>
	        <cfset flashInsert(error="Job #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>
		
	</cffunction>
	
	<!--- jobs/create --->
	<cffunction name="Xcreate">
		<cfif len(params.captcha) AND params.captcha is decrypt(params.captcha_check,getSetting("passwordkey"),"CFMX_COMPAT","HEX")>

			<cfset params.job.uuid = CreateUUID()>
			<cfset params.job.uuid = replace(params.job.uuid,"-","","all")>

			<cfset job = model("Mainjob").new(params.job)>
			
			<!--- Verify that the message creates successfully --->
			<cfif job.save()>
				<cfset flashInsert(success="The Job was created successfully.")>
	            <cfset redirectTo(action="sendnotice", key=job.id)>
			<!--- Otherwise --->
			<cfelse>
				<cfset flashInsert(error=errorMessagesFor("job"))>
				<cfset job = model("Mainjob").new(params.job)>
				<cfset strCaptcha = getcaptcha()>
				<cfset renderPage(action="new")>
			</cfif>
			
		<cfelse>
			<cfset flashInsert(error="Please try to enter the scrambled image again.")>	
			<cfset job = model("Mainjob").new(params.job)>
			<cfset strCaptcha = getcaptcha()>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>
	
	<!--- jobs/update --->
	<cffunction name="Xupdate">
		<cfset job = model("Mainjob").findByKey(params.key)>
		
		<!--- Verify that the job updates successfully --->
		<cfif job.update(params.job)>
			<cfset flashInsert(success="The job was updated successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the job.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>

	<cfscript>
		function XsendJobNoticesTo(){
			return getSetting("sendJobNoticesTo");
		}
	</cfscript>
	
	<cffunction name="Xsendnotice">
		<!--- Find the record --->
    	<cfset job = model("Mainjob").findByKey(params.key)>
		<cfif !isLocalMachine()>
			<cfset sendEmail(template="emailjob", from=job.email, to=sendJobNoticesTo(), subject="New Jobs Post", key=params.key, description=job.description)>
		</cfif>
		<cfset redirectTo(action="thankyou", key=params.key)>
	</cffunction>
	
	<cffunction name="Xapprove">
	    	<cfset job = model("Mainjob").findByKey(params.key)>
			<cfset job.approved = "Y">
			<cfset job.update()>
	    	<cfset job = model("Mainjob").findAll(where="id=#params.key#")>
			<cfset renderPage(controller="jobs", action="show")>
	</cffunction>

	
	<!--- jobs/delete/key --->
	<cffunction name="Xdelete">
			<cfset job = model("Mainjob").findByKey(params.key)>
			
			<!--- Verify that the job deletes successfully --->
			<cfif job.delete()>
				<cfset flashInsert(success="The job was deleted successfully.")>	
	            <cfset redirectTo(action="index")>
			<!--- Otherwise --->
			<cfelse>
				<cfset flashInsert(error="There was an error deleting the job.")>
				<cfset redirectTo(action="index")>
			</cfif>
	</cffunction>
	
	<cffunction name="Xrss">
		<cfset jobs = model("Mainjob").findAll(where="approved='y' AND expirationDate > now()", order="createdAt DESC")>
		
		<cfset title = "Charis Fellowship Jobs">
		<cfset description= "Ministry Positions posted by Grace Brethren Churches">
		<cfset renderPage(template="rss.cfm", layout="rsslayout")>
	</cffunction>

	<cffunction name="XaddUuids">
	<cfargument name="jobs" required="true" type="query">
	<cfset var loc = arguments>
		<cfloop query="loc.jobs">
			<cfif !len(uuid)>
				<cfset loc.job = model("Mainjob").findOne(where="id=#id#")>
				<cfset loc.job.uuid = CreateUUID()>
				<cfset loc.job.uuid = replace(loc.job.uuid,"-","","all")>
				<cfset loc.job.update(loc.job)>
			</cfif>
		</cfloop>
		<cfset loc.newjobs = model("Mainjob").findAll()>
		<cfreturn loc.newjobs>
	</cffunction>
	
</cfcomponent>
