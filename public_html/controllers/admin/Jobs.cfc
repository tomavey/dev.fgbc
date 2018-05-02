<cfcomponent extends="Controller" output="false">
	
	<cffunction name="init">
		<cfset filters(through="setReturn", only="list,index,show")>
	</cffunction>

	<!--- jobs/index --->
	<cffunction name="index">
		<cfset jobs = model("Mainjob").findAll(order="createdAt DESC")>
	</cffunction>
	
	<!--- jobs/show/key --->
	<cffunction name="show">
		
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
	<cffunction name="new">
		<cfset job = model("Mainjob").new()>
		<cfset strCaptcha = getcaptcha()>
	</cffunction>
	
	<!--- jobs/edit/key --->
	<cffunction name="edit">
	
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
	<cffunction name="create">
		<cfif len(params.captcha) AND params.captcha is decrypt(params.captcha_check,application.wheels.passwordkey,"CFMX_COMPAT","HEX")>

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
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the job.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>
	
	<cffunction name="sendnotice">
		<!--- Find the record --->
    	<cfset job = model("Mainjob").findByKey(params.key)>
		<cfif !isLocalMachine()>
			<cfset sendEmail(template="emailjob", from=job.email, to="tomavey@comcast.net", subject="New Jobs Post", key=params.key, description=job.description)>
		</cfif>
		<cfset redirectTo(action="thankyou", key=params.key)>
	</cffunction>
	
	<cffunction name="approve">
	    	<cfset job = model("Mainjob").findByKey(params.key)>
			<cfset job.approved = "Y">
			<cfset job.update()>
	    	<cfset job = model("Mainjob").findAll(where="id=#params.key#")>
			<cfset renderPage(controller="jobs", action="show")>
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

	<cffunction name="addUuids">
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
