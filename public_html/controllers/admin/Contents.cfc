<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
		<cfset filters(through="isSuperadmin", only="index,new,delete")>
		<cfset filters(through="isPageEditor", only="edit")>
		<cfset filters(through="getAllRights", only="new,edit")>
	</cffunction>


	<!---Filters--->
	<cffunction name="getAllRights">
		<cfset rights = model("Authright").findAll(order="name")>
	</cffunction>

<!--------------------------------->
<!------------CRUD----------------->
<!--------------------------------->

	<!--- contents/index --->
	<cffunction name="index">
		<cfset setreturn()>
		<cfset contents = model("Maincontent").findAll(order="createdAt DESC")>
	</cffunction>

 	<!--- contents/show/key --->
	<cffunction name="show">
		<cfset setreturn()>

		<!--- Find the record --->
		<cfif isDefined("params.shortlink")>
	    	<cfset content = model("Maincontent").findOne(where="shortlink='#params.shortlink#'")>
	    <cfelse>
	    	<cfset content = model("Maincontent").findByKey(params.key)>
	    </cfif>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(content)>
	        <cfset flashInsert(error="Content #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

	<!--- contents/new --->
	<cffunction name="new">
		<cfset content = model("Maincontent").new()>
	</cffunction>

	<!--- contents/edit/key --->
	<cffunction name="edit">

	<cfdump var="#params#"><cfabort>

		<!--- Find the record --->
    	<cfset content = model("Maincontent").findByKey(params.key)>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(content)>
	        <cfset flashInsert(error="Content #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

	<!--- contents/create --->
	<cffunction name="create">
		<cfset content = model("Maincontent").new(params.content)>

		<!--- Verify that the content creates successfully --->
		<cfif content.save()>
			<cfset flashInsert(success="The content was created successfully.")>
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the content.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>

	<!--- contents/update --->
	<cffunction name="update">
		<cfset content = model("Maincontent").findByKey(params.key)>

		<!--- Verify that the content updates successfully --->
		<cfif content.update(params.content)>
			<cfset flashInsert(success="The content was updated successfully.")>
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the content.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>

	<!--- contents/delete/key --->
	<cffunction name="delete">
		<cfset content = model("Maincontent").findByKey(params.key)>

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

<!---- Special View Controllers--->

	<cffunction name="conferenceInformationAsJson">
	    	<cfset data = model("Maincontent").findOne(where="shortlink='generalconferenceinfo'").content>
        	<cfset renderPage(template="/json", layout="/layout_json", hideDebugInformation=true)>
	</cffunction>

	<cffunction name="manualOfProcedure">
		<cfset redirectTo(action="show", key=19)>
	</cffunction>

	<cffunction name="constitution">
		<cfset redirectTo(action="show", key=18)>
	</cffunction>

	<cffunction name="statementoffaith">
		<cfset redirectTo(action="show", key=30)>
	</cffunction>

</cfcomponent>
