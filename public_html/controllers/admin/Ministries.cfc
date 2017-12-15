<cfcomponent extends="Controller" output="false">
	<cffunction name="init">
		<cfset filters(through="setReturn", only="show,index")>
		<!---
		<cfset filters(through="logview")>
		--->
	</cffunction>

	<!--- ministries/index --->
	<cffunction name="index">
		<cfset ministries = model("Mainministry").findAll(order="category,name")>
	</cffunction>

	<!--- ministries/list --->
	<cffunction name="list">

		<cfif isdefined("params.key")>
			<cfset wherestring = "id=#params.key#">
		<cfelseif isDefined("params.category")>
			<cfset wherestring = "category='#params.category#'">
		<cfelse>
			<cfset wherestring = "">
		</cfif>

    	<cfset ministry = model("Mainministry").findAll(where=whereString, order="category,name")>
    	<cfset categories = model("Mainministry").findAll(where="category <> 'none'", order="category,name")>

	</cffunction>

	<cffunction name="simpleList">
	<!---used for insider cover of handbook--->
		<cfset wherestring = "status='active' AND category in ('Church Planting Ministries','Doing Good', 'Communication', 'Leadership Training Ministries')">
    	<cfset ministries = model("Mainministry").findAll(where=whereString, order="category,name")>
	</cffunction>

	<!--- ministries/new --->
	<cffunction name="new">
		<cfset ministry = model("Mainministry").new()>
	</cffunction>

	<!--- ministries/edit/key --->
	<cffunction name="edit">

		<!--- Find the record --->
    	<cfset ministry = model("Mainministry").findByKey(params.key)>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(ministry)>
	        <cfset flashInsert(error="ministry #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

	<!--- ministries/create --->
	<cffunction name="create">
		<cfset ministry = model("Mainministry").new(params.ministry)>

		<!--- Verify that the ministry creates successfully --->
		<cfif ministry.save()>
			<cfset flashInsert(success="The ministry was created successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the ministry.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>

	<cffunction name="show">
		<cfset wherestring = "id=#params.key#">
	   	<cfset ministry = model("Mainministry").findAll(where=whereString, order="category,name")>
	</cffunction>

	<!--- ministries/update --->
	<cffunction name="update">
		<cfset ministry = model("Mainministry").findByKey(params.key)>

		<!--- Verify that the ministry updates successfully --->
		<cfif ministry.update(params.ministry)>
			<cfset flashInsert(success="The ministry was updated successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the ministry.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>

	<!--- ministries/delete/key --->
	<cffunction name="delete">
		<cfset ministry = model("Mainministry").findByKey(params.key)>

		<!--- Verify that the ministry deletes successfully --->
		<cfif ministry.delete()>
			<cfset flashInsert(success="The ministry was deleted successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the ministry.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>

<!---Get Settings--->

<cfscript>
	function getministryCategories(){
		return application.wheels.ministryCategories;
	}
</cfscript>	

</cfcomponent>
