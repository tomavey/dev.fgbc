<cfcomponent extends="Controller" output="false">

<cfscript>
	function config(){
		filters(through="setReturn", only="list,index,show")
	}

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



</cfscript>


	
	<!--- jobs/edit/key --->
	<cffunction name="edit">
	
		<!--- Find the record --->
		<cfif isDefined("params.id")>
			<cfset job = model("Mainjob").findOne(where="uuid='#params.id#'")>
			<cfset params.key = job.id>
		<cfelse>
	    	<cfset job = model("Mainjob").findByKey(params.key)>
		</cfif>

		<cfset strCaptcha = getcaptcha()>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(job)>
	        <cfset flashInsert(error="Job #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>
		
	</cffunction>
	
	<!--- jobs/update --->
	<cffunction name="update">
		<cfset job = model("Mainjob").findByKey(params.key)>
		
		<!--- Verify that the job updates successfully --->
		<cfif job.update(params.job)>
			<cfset flashInsert(success="The job was updated successfully.")>	
			<cfif isDefined("job.uuid")>
				<cfset redirectTo(action="thankyou", key=job.uuid)>
			<cfelse>
				<cfset redirectTo(action="thankyou")>
			</cfif>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the job.")>
			<cfset renderView(action="edit")>
		</cfif>
	</cffunction>

	<cfscript>
		function sendJobNoticesTo(){
			return getSetting("sendJobNoticesTo");
		}
	</cfscript>
	
	<cffunction name="sendnotice">
		<!--- Find the record --->
		<cfif len(params.key) LTE 10>
			<cfset job = model("Mainjob").findByKey(params.key)>
		<cfelse>	
			<cfset job = model("Mainjob").findOne(where="uuid='#params.key#'")>
		</cfif>
		<cfif !isLocalMachine()>
			<cfset sendEmail(template="emailjob", from=job.email, to=sendJobNoticesTo(), subject="New Jobs Post", key=params.key, description=job.description)>
		</cfif>
		<cfif isDefined("job.uuid")>
			<cfset redirectTo(action="thankyou", key=job.uuid)>
		<cfelse>
			<cfset redirectTo(action="thankyou")>
		</cfif>
	</cffunction>
	
	<cffunction name="approve">
	    	<cfset job = model("Mainjob").findByKey(params.key)>
			<cfset job.approved = "Y">
			<cfset job.update()>
	    	<cfset job = model("Mainjob").findAll(where="id=#params.key#")>
			<cfset renderView(controller="admin.jobs", action="show")>
	</cffunction>

	
	<!--- jobs/delete/key --->
	<cffunction name="delete">
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
	
	<cffunction name="rss">
		<cfset jobs = model("Mainjob").findAll(where="approved='y' AND expirationDate > now()", order="createdAt DESC")>
		
		<cfset title = "FGBC Jobs">
		<cfset description= "Ministry Positions posted by Grace Brethren Churches">
		<cfset renderView(template="rss.cfm", layout="rsslayout")>
	</cffunction>

	
</cfcomponent>
