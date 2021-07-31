<cfcomponent extends="Controller" output="false">
	
	<cffunction name="config">
		<cfset usesLayout(template="/conference/adminlayout", except="new,thankyou")>
	</cffunction>	

	<!--- resources/index --->
	<cffunction name="index">
		<cfset resources = model("Resource").findAll()>
	</cffunction>
	
	<!--- resources/show/key --->
	<cffunction name="show">
		
		<!--- Find the record --->
    	<cfset resource = model("Resource").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(resource)>
	        <cfset flashInsert(error="Resource #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>
			
	</cffunction>
	
	<!--- resources/new --->
	<cffunction name="new">
		<cfset resource = model("Resource").new()>
		<cfif isdefined("params.key") and params.key is "DVD">
			<cfset title = "Request the Vision2020 Promo DVD">
			<cfset commenttext = "When and where will you show this video?">
			<cfset showQuantity=false>
		</cfif>	
		<cfif isdefined("params.key") and params.key is "poster">
			<cfset title = "Request the Vision2020 Poster">
			<cfset commenttext = "Where will you place this poster?">
		</cfif>	
	</cffunction>
	
	<!--- resources/edit/key --->
	<cffunction name="edit">
	
		<!--- Find the record --->
    	<cfset resource = model("Resource").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(resource)>
	        <cfset flashInsert(error="Resource #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>
		
	</cffunction>
	
	<!--- resources/create --->
	<cffunction name="create">
		<cfset resource = model("Resource").create(params.resource)>
		
		<!--- Verify that the resource creates successfully --->
		<cfif resource.hasErrors()>
			<cfset flashInsert(error="There was an error creating the resource.")>
			<cfset renderView(action="new")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(success="The resource was created successfully.")>
			<cfset sendemail(from="#application.wheels.registraremail#", to="#application.wheels.registraremail#", template="email", subject="Vision2020 Video Promo", layout="/layout_for_email", type="html")>
            <cfset redirectTo(action="ThankYou")>
		</cfif>
	</cffunction>
	
	<!--- resources/update --->
	<cffunction name="update">
		<cfset resource = model("Resource").findByKey(params.key)>
		
		<!--- Verify that the resource updates successfully --->
		<cfif resource.update(params.resource)>
			<cfset flashInsert(success="The resource was updated successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the resource.")>
			<cfset renderView(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- resources/delete/key --->
	<cffunction name="delete">
		<cfset resource = model("Resource").findByKey(params.key)>
		
		<!--- Verify that the resource deletes successfully --->
		<cfif resource.delete()>
			<cfset flashInsert(success="The resource was deleted successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the resource.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>
	
</cfcomponent>
