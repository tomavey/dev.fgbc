<cfcomponent extends="Controller" output="false">
	
	<!--- equipannouncements/index --->
	<cffunction name="index">
		<cfset equipannouncements = model("Equipannouncement").findAll()>
	</cffunction>
	
	<!--- equipannouncements/show/key --->
	<cffunction name="show">
		
		<!--- Find the record --->
    	<cfset equipannouncement = model("Equipannouncement").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(equipannouncement)>
	        <cfset flashInsert(error="Equipannouncement #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>
			
	</cffunction>
	
	<!--- equipannouncements/new --->
	<cffunction name="new">
		<cfset equipannouncement = model("Equipannouncement").new()>
	</cffunction>
	
	<!--- equipannouncements/edit/key --->
	<cffunction name="edit">
	
		<!--- Find the record --->
    	<cfset equipannouncement = model("Equipannouncement").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(equipannouncement)>
	        <cfset flashInsert(error="Equipannouncement #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>
		
	</cffunction>
	
	<!--- equipannouncements/create --->
	<cffunction name="create">
		<cfset equipannouncement = model("Equipannouncement").new(params.equipannouncement)>
		
		<!--- Verify that the equipannouncement creates successfully --->
		<cfif equipannouncement.save()>
			<cfset flashInsert(success="The equipannouncement was created successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the equipannouncement.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>
	
	<!--- equipannouncements/update --->
	<cffunction name="update">
		<cfset equipannouncement = model("Equipannouncement").findByKey(params.key)>
		
		<!--- Verify that the equipannouncement updates successfully --->
		<cfif equipannouncement.update(params.equipannouncement)>
			<cfset flashInsert(success="The equipannouncement was updated successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the equipannouncement.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- equipannouncements/delete/key --->
	<cffunction name="delete">
		<cfset equipannouncement = model("Equipannouncement").findByKey(params.key)>
		
		<!--- Verify that the equipannouncement deletes successfully --->
		<cfif equipannouncement.delete()>
			<cfset flashInsert(success="The equipannouncement was deleted successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the equipannouncement.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>
	
</cfcomponent>
