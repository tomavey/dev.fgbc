//TODO - Convert to cfscript
<cfcomponent extends="Controller" output="false">

	<cffunction name="config">
		<cfset usesLayout(template="/handbook/layout_handbook2")>
	</cffunction>

	<!--- handbooktasks/index --->
	<cffunction name="index">
		<cfset handbooktasks = model("Handbooktask").findAll(order="createdAt DESC")>
	</cffunction>

	<!--- handbooktasks/show/key --->
	<cffunction name="show">

		<!--- Find the record --->
    	<cfset handbooktask = model("Handbooktask").findByKey(params.key)>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(handbooktask)>
	        <cfset flashInsert(error="Handbooktask #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

	<!--- handbooktasks/new --->
	<cffunction name="new">
		<cfset handbooktask = model("Handbooktask").new()>
		<cfset handbooktask.assignedto = "Janelle">
		<cfset handbooktask.assignedby = "Tom">
	</cffunction>

	<!--- handbooktasks/edit/key --->
	<cffunction name="edit">

		<!--- Find the record --->
    	<cfset handbooktask = model("Handbooktask").findByKey(params.key)>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(handbooktask)>
	        <cfset flashInsert(error="Handbooktask #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

	<!--- handbooktasks/create --->
	<cffunction name="create">
		<cfset handbooktask = model("Handbooktask").new(params.handbooktask)>

		<!--- Verify that the handbooktask creates successfully --->
		<cfif handbooktask.save()>
			<cfset flashInsert(success="The handbooktask was created successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the handbooktask.")>
			<cfset renderView(action="new")>
		</cfif>
	</cffunction>

	<!--- handbooktasks/update --->
	<cffunction name="update">
		<cfset handbooktask = model("Handbooktask").findByKey(params.key)>

		<!--- Verify that the handbooktask updates successfully --->
		<cfif handbooktask.update(params.handbooktask)>
			<cfset flashInsert(success="The handbooktask was updated successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the handbooktask.")>
			<cfset renderView(action="edit")>
		</cfif>
	</cffunction>

	<!--- handbooktasks/delete/key --->
	<cffunction name="delete">
		<cfset handbooktask = model("Handbooktask").findByKey(params.key)>

		<!--- Verify that the handbooktask deletes successfully --->
		<cfif handbooktask.delete()>
			<cfset flashInsert(success="The handbooktask was deleted successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the handbooktask.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>

</cfcomponent>
