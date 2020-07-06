<cfcomponent extends="Controller" output="false">
	
	<cffunction name="init">
		<cfset filters(through="setReturn", only="list,index,show")>
	</cffunction>

	<!--- jobs/show/key --->
	<cffunction name="index">
		
		<cfif isdefined("params.key")>
			<!--- Find the record --->
	    	<cfset job = model("Mainjob").findAll(where="id=#params.key#")>
	    	
		<cfelseif gotrights("superadmin,office")>
		
			<cfset job = model("Mainjob").findAll(order="createdAt DESC")>
	
		<cfelse>
		
			<cfset job = model("Mainjob").findAll(where="expirationdate > now() AND approved='Y'", order="createdAt DESC")>
	
		</cfif>	
    		
	</cffunction>

	<cffunction name="show">
		<cfset redirectTo(action="index", key=params.key)>
	</cffunction>

	<cffunction name="list">
		<cfset redirectTo("index")>
	</cffunction>
	
	
	<!--- jobs/new --->
	<cffunction name="new">
		<cfset job = model("Mainjob").new()>
		<cfset strCaptcha = getcaptcha()>
	</cffunction>
	
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
	
	<!--- jobs/create --->
	<cffunction name="create">
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
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>

	<cfscript>
		function sendJobNoticesTo(){
			return getSetting("sendJobNoticesTo");
		}
	</cfscript>
	
	<cffunction name="sendnotice">
		<!--- Find the record --->
    	<cfset job = model("Mainjob").findByKey(params.key)>
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
			<cfset renderPage(controller="admin.jobs", action="show")>
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
		<cfset renderPage(template="rss.cfm", layout="rsslayout")>
	</cffunction>

	
</cfcomponent>
