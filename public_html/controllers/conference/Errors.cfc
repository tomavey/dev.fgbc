<cfcomponent extends="Controller" output="false">
	
	<!--- errors/index --->
	<cffunction name="index">
		<cfif not isDefined("params.showall")>
			<cfset errors = model("Conferenceerror").findAll(maxrows="25", order="createdAt DESC")>
		<cfelse>	
			<cfset errors = model("Conferenceerror").findAll(order="createdAt DESC")>	
		</cfif>
		<cfset usesLayout("/layout_naked")>
	</cffunction>
	
	<!--- errors/show/key --->
	<cffunction name="show">
		
		<!--- Find the record --->
    	<cfset error = model("Conferenceerror").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(error)>
	        <cfset flashInsert(error="Error #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>
			
	</cffunction>
	
	<!--- errors/new --->
	<cffunction name="new">
		<cfset error = model("Conferenceerror").new()>
	</cffunction>
	
	<!--- errors/edit/key --->
	<cffunction name="edit">
	
		<!--- Find the record --->
    	<cfset error = model("Conferenceerror").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(error)>
	        <cfset flashInsert(error="Error #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>
		
	</cffunction>
	
	<!--- errors/create --->
	<cffunction name="create">
		<cfset error = model("Conferenceerror").new(params.error)>
		
		<!--- Verify that the error creates successfully --->
		<cfif error.save()>
			<cfset flashInsert(success="The error was created successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the error.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>
	
	<!--- errors/update --->
	<cffunction name="update">
		<cfset error = model("Conferenceerror").findByKey(params.key)>
		
		<!--- Verify that the error updates successfully --->
		<cfif error.update(params.error)>
			<cfset flashInsert(success="The error was updated successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the error.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- errors/delete/key --->
	<cffunction name="delete">
		<cfset error = model("Conferenceerror").findByKey(params.key)>
		
		<!--- Verify that the error deletes successfully --->
		<cfif error.delete()>
			<cfset flashInsert(success="The error was deleted successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the error.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>

</cfcomponent>
