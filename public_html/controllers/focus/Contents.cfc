<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
		<cfset usesLayout('/focus/layout')>
		<cfset filters(through='checkOffice', only="edit")>
		<cfset filters(through="getRetreats")>
		<cfset filters(through="getRetreatRegions")>
		<cfset filters(through="setKeyToKeyy")>
	</cffunction>

<!---Filters--->

<cfscript>
	function setKeyToKeyy() {
		if (isDefined("params.id")) { params.key = params.id}
	}
</cfscript>


<!------------------------------->
<!--------CRUD------------------->
<!------------------------------->

	<!--- -contents/index --->
	<cffunction name="index">
		<cfset contents = model("Focuscontent").findAll()>
		<cfset renderPage(layout="/focus/layoutadmin")>
	</cffunction>

	<!--- -contents/show/key --->
	<cffunction name="show">

		<!--- Find the record --->
    	<cfset content = model("Focuscontent").findByKey(params.key)>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(content)>
	        <cfset flashInsert(error="Content #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>

	    <cfset renderPage(action="show", layout="/focus/layout2")>

	</cffunction>


	<!--- -contents/new --->
	<cffunction name="new">
		<cfset content = model("Focuscontent").new()>
		<cfset renderPage(layout="/focus/layoutadmin")>
	</cffunction>

	<!--- -contents/edit/key --->
	<cffunction name="edit">

		<!--- Find the record --->
    	<cfset content = model("Focuscontent").findByKey(params.key)>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(content)>
	        <cfset flashInsert(error="Content #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>

		<cfset renderPage(layout="/focus/layoutadmin")>
	</cffunction>

	<!--- -contents/create --->
	<cffunction name="create">
		<cfset content = model("Focuscontent").new(params.content)>

		<!--- Verify that the content creates successfully --->
		<cfif content.save()>
			<cfset flashInsert(success="The content was created successfully.")>
            		<cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the content.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>

	<!--- -contents/update --->
	<cffunction name="update">

		<cfset content = model("Focuscontent").findByKey(params.key)>

		<!--- Verify that the content updates successfully --->
		<cfif content.update(params.content)>
			<cfset flashInsert(success="The content was updated successfully.")>
		            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the content.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>

	<!--- -contents/delete/key --->
	<cffunction name="delete">
		<cfset content = model("Focuscontent").findByKey(params.key)>

		<!--- Verify that the content deletes successfully --->
		<cfif content.delete()>
			<cfset flashInsert(success="The content was deleted successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the content.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>

</cfcomponent>
