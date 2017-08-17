<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
		<cfset usesLayout("/conference/layout")>
		<cfset filters(through="getStates")>
	</cffunction>

	<cffunction name="getStates">
		<cfset states = model("Handbookstate").findall(order="state")>
	</cffunction>
	
	<!--- Childcareworkers/index --->
	<cffunction name="index">
		<cfset childcareworkers = model("Conferencechildcareworker").findAll()>
	</cffunction>
	
	<!--- Childcareworkers/show/key --->
	<cffunction name="show">
		
		<!--- Find the record --->
    	<cfset childcareworkers = model("Conferencechildcareworker").findOne(where="id=#params.key#", include="State")>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(childcareworkers)>
	        <cfset flashInsert(error="Childcareworkers #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>
			
	</cffunction>
	
	<!--- Childcareworkers/new --->
	<cffunction name="new">
		<cfset childcareworkers = model("Conferencechildcareworker").new()>
	</cffunction>
	
	<!--- Childcareworkers/edit/key --->
	<cffunction name="edit">
	
		<!--- Find the record --->
    	<cfset childcareworkers = model("Conferencechildcareworker").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(Childcareworkers)>
	        <cfset flashInsert(error="Childcareworkers #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>
		
	</cffunction>
	
	<!--- Childcareworkers/create --->
	<cffunction name="create">
		<cfset childcareworkers = model("Conferencechildcareworker").new(params.Childcareworkers)>
		
		<!--- Verify that the Childcareworkers creates successfully --->
		<cfif childcareworkers.save()>
			<cfset flashInsert(success="The Childcareworkers was created successfully.")>
            <cfset redirectTo(action="sendEmailNotification", key=childcareworkers.id)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the Childcareworkers.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>
	
	<!--- Childcareworkers/update --->
	<cffunction name="update">
		<cfset childcareworkers = model("Conferencechildcareworker").findByKey(params.key)>
		
		<!--- Verify that the Childcareworkers updates successfully --->
		<cfif childcareworkers.update(params.Childcareworkers)>
			<cfset flashInsert(success="The Childcareworkers was updated successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the Childcareworkers.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- Childcareworkers/delete/key --->
	<cffunction name="delete">
		<cfset childcareworkers = model("Conferencechildcareworker").findByKey(params.key)>
		
		<!--- Verify that the Childcareworkers deletes successfully --->
		<cfif childcareworkers.delete()>
			<cfset flashInsert(success="The Childcareworkers was deleted successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the childcareworker.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>

	<cffunction name="sendEmailNotification">
    	<cfset childcareworkers = model("Conferencechildcareworker").findOne(where="id=#params.key#", include="State")>
    	<cfset SendToAddresses = application.wheels.childcarenotifications>
    	<cfif isDefined("childcareworkers.email")>
    		<cfset SendToAddresses = SendToAddresses & "," & childcareworkers.email>
    	</cfif>
    	<cfif isDefined("childcareworkers.parentsemail")>
    		<cfset SendToAddresses = SendToAddresses & "," & childcareworkers.parentsemail>
    	</cfif>
    	<cfset sendEmail(to=sendtoaddresses, from="flinch@fgbc.org", subject="New Childcare Worker Application", template="sendemailnotification", layout="/layout_for_email")>
	</cffunction>
	
</cfcomponent>
