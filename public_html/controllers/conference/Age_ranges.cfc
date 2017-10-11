<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
		<cfset usesLayout("/conference/adminlayout")>
		<cfset filters("officeOnly")>
	</cffunction>

<!------------------------------>
<!----------CRUD---------------->
<!------------------------------>
	

	<!--- age_ranges/index --->
	<cffunction name="index">
		<cfset age_ranges = model("Conferenceage_range").findAll()>
	</cffunction>
	
	<!--- age_ranges/show/key --->
	<cffunction name="show">
		
		<!--- Find the record --->
    	<cfset age_range = model("Conferenceage_range").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(age_range)>
	        <cfset flashInsert(error="Conferenceage_range #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>
			
	</cffunction>
	
	<!--- age_ranges/new --->
	<cffunction name="new">
		<cfset age_range = model("Conferenceage_range").new()>
	</cffunction>
	
	<!--- age_ranges/edit/key --->
	<cffunction name="edit">
	
		<!--- Find the record --->
    	<cfset age_range = model("Conferenceage_range").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(age_range)>
	        <cfset flashInsert(error="Conferenceage_range #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>
		
	</cffunction>
	
	<!--- age_ranges/create --->
	<cffunction name="create">
		<cfset age_range = model("Conferenceage_range").new(params.age_range)>
		
		<!--- Verify that the age_range creates successfully --->
		<cfif age_range.save()>
			<cfset flashInsert(success="The age_range was created successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the age_range.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>
	
	<!--- age_ranges/update --->
	<cffunction name="update">
		<cfset age_range = model("Conferenceage_range").findByKey(params.key)>
		
		<!--- Verify that the age_range updates successfully --->
		<cfif age_range.update(params.age_range)>
			<cfset flashInsert(success="The age_range was updated successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the age_range.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- age_ranges/delete/key --->
	<cffunction name="delete">
		<cfset age_range = model("Conferenceage_range").findByKey(params.key)>
		
		<!--- Verify that the age_range deletes successfully --->
		<cfif age_range.delete()>
			<cfset flashInsert(success="The age_range was deleted successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the age_range.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>
	
</cfcomponent>
