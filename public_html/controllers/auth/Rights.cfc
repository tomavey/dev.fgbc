<cfcomponent extends="Controller" output="false">
	
	<!--- rights/index --->
	<cffunction name="index">
		<cfset rights = model("Authright").findAll(order="name")>
		<cfset usesLayout("/layoutadmin")>
	</cffunction>
	
<!-------------------------------------->
<!---------------Basic CRUD------------->
<!-------------------------------------->


	<!--- rights/show/key --->
	<cffunction name="show">
		
		<!--- Find the record --->
    	<cfset right = model("Authright").findByKey(params.key)>
		<cfset groups = model("Authgroupsright").findAll(where="auth_rightsId = '#params.key#'", include="group", order="name")>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(right)>
	        <cfset flashInsert(error="Right #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>
		<cfset renderPage(layout="/layoutadmin")>
			
	</cffunction>
	
	<!--- rights/new --->
	<cffunction name="new">
		<cfset right = model("Authright").new()>
	</cffunction>
	
	<!--- rights/edit/key --->
	<cffunction name="edit">
	
		<!--- Find the record --->
    	<cfset right = model("Authright").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(right)>
	        <cfset flashInsert(error="Right #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>
		<cfset renderPage(layout="/layoutadmin")>
	</cffunction>
	
	<!--- rights/create --->
	<cffunction name="create">
		<cfset right = model("Authright").new(params.right)>
		
		<!--- Verify that the right creates successfully --->
		<cfif right.save()>
			<cfset flashInsert(success="The right was created successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the right.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>
	
	<!--- rights/update --->
	<cffunction name="update">
		<cfset right = model("Authright").findByKey(params.key)>
		
		<!--- Verify that the right updates successfully --->
		<cfif right.update(params.right)>
			<cfset flashInsert(success="The right was updated successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the right.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- rights/delete/key --->
	<cffunction name="delete">
		<cfset right = model("Authright").findByKey(params.key)>
		
		<!--- Verify that the right deletes successfully --->
		<cfif right.delete()>
			<cfset flashInsert(success="The right was deleted successfully.")>	
			<cfset groupsright = model("Authgroupsright").deleteAll(where="auth_rightsid=#params.key#")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the right.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>
	
</cfcomponent>
