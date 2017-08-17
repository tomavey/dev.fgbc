<cfcomponent extends="Controller" output="false">
	
	<cffunction name="init">
		<cfset useslayout('/layoutadmin')>
		<cfset filters('checkOffice')>
		<cfset filters(through="setReturn", only="index,show")>
		<cfset filters(through="getRetreatRegions")>
	</cffunction>
	
	<!--- -registrants/index --->
	<cffunction name="index">
	<cfset var local = structNew()>	
		<cfset local.year = year(now())>
		<cfset local.month = month(now())>
		<cfif local.month LTE 9>
			<cfset local.month = 9>
			<cfset local.year = year + 1>
		<cfelse>
			<cfset local.month = 9>
		</cfif>	
		
		<cfset local.date = createDate(local.year,local.month,1)>

		<cfset registrants = model("Focusregistrant").findAll(where="createdAt > '#local.date#'")>
		<cfset registrantsSince = local.date>
	</cffunction>
	
	<!--- -registrants/show/key --->
	<cffunction name="show">
		
		<!--- Find the record --->
    	<cfset registrant = model("Focusregistrant").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(registrant)>
	        <cfset flashInsert(error="Registrant #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>
			
	</cffunction>
	
	<!--- -registrants/new --->
	<cffunction name="new">
		<cfset registrant = model("Focusregistrant").new()>
	</cffunction>
	
	<!--- -registrants/edit/key --->
	<cffunction name="edit">
	
		<!--- Find the record --->
    	<cfset registrant = model("Focusregistrant").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(registrant)>
	        <cfset flashInsert(error="Registrant #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>
		
	</cffunction>
	
	<!--- -registrants/create --->
	<cffunction name="create">
		<cfset registrant = model("Focusregistrant").new(params.registrant)>
		
		<!--- Verify that the registrant creates successfully --->
		<cfif registrant.save()>
			<cfset flashInsert(success="The registrant was created successfully.")>
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the registrant.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>
	
	<!--- -registrants/update --->
	<cffunction name="update">
		<cfset registrant = model("Focusregistrant").findByKey(params.key)>
		
		<!--- Verify that the registrant updates successfully --->
		<cfif registrant.update(params.registrant)>
			<cfset flashInsert(success="The registrant was updated successfully.")>	
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the registrant.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- -registrants/delete/key --->
	<cffunction name="delete">
		<cfset registrant = model("Focusregistrant").findByKey(params.key)>
		
		<!--- Verify that the registrant deletes successfully --->
		<cfif registrant.delete()>
			<cfset flashInsert(success="The registrant was deleted successfully.")>	
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the registrant.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>
	
</cfcomponent>
