<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
		<!---cfset filters(through="logview")--->
	</cffunction>

	<!--- resources/index --->
	<cffunction name="index">
		<cfset resources = model("Mainresource").findAll()>
		<cfset setReturn()>
	</cffunction>

	<cffunction name="list">
		<cfset resources = model("Mainresource").findAll(order="description")>
	</cffunction>

	<!--- resources/show/key --->
	<cffunction name="show">
		<cfif isdefined("params.key")>

			<!--- Find the record --->
	    	<cfset resource = model("Mainresource").findByKey(params.key)>

	    	<!--- Check if the record exists --->
		    <cfif NOT IsObject(resource)>
		        <cfset flashInsert(error="Resource #params.key# was not found")>
		        <cfset redirectTo(action="index")>
		    </cfif>

	    <cfelse>
	    	<cfset resource = model("Mainresource").findAll()>
	    </cfif>

	</cffunction>

	<!--- resources/new --->
	<cffunction name="new">
		<cfset resource = model("Mainresource").new()>
	</cffunction>

	<!--- resources/edit/key --->
	<cffunction name="edit">

		<!--- Find the record --->
    	<cfset resource = model("Mainresource").findByKey(params.key)>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(resource)>
	        <cfset flashInsert(error="Resource #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

	<!--- resources/create --->
	<cffunction name="create">
		<cfset resource = model("Mainresource").new(params.resource)>

		<!--- Verify that the resource creates successfully --->
		<cfif resource.save()>
			<cfset flashInsert(success="The resource was created successfully.")>
			<cfset returnback()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the resource.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>

	<!--- resources/update --->
	<cffunction name="update">
		<cfset resource = model("Mainresource").findByKey(params.key)>

		<!--- Verify that the resource updates successfully --->
		<cfif resource.update(params.resource)>
			<cfset flashInsert(success="The resource was updated successfully.")>
			<cfset returnback()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the resource.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>

	<!--- resources/delete/key --->
	<cffunction name="delete">
		<cfset resource = model("Mainresource").findByKey(params.key)>

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
