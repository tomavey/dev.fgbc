<cfcomponent extends="Controller" output="false">
	<cffunction name="init">
		<cfset filters(through="setReturn", only="show,index")>
		<!---
		<cfset filters(through="logview", type="after")>
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
		<cfset wherestring = "status <>'inactive' AND category in ('Church Planting Ministries','Doing Good', 'Communication', 'Leadership Training Ministries') AND name NOT LIKE 'Camp%'">
    	<cfset ministries = model("Mainministry").findAll(where=whereString, order="name")>
	</cffunction>

	<!--- ministries/new --->
	<cffunction name="new">
		<cfset ministry = model("Mainministry").new()>
	</cffunction>

<cfscript>

	<!--- ministries/edit/key --->
	function edit( key=params.key ) {
		ministry = model("Mainministry").findByKey(params.key)
		if ( !isObject(ministry) ) {
			redirectTo(action="index", error="ministry #params.key# was not found")
		}
	}

</cfscript>

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

<cfscript>
	private function includeInFooterToBinary(required string includeInFooter) {
		if ( includeInFooter is "Yes" ) { return 1 } else { return 0}
	}
</cfscript>	

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
      <cfset returnBack()>
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
		var activeMinistries = model("Mainministry").findAll(where="status <>'inactive'")
		var categories = listSort(valueList(activeMinistries.category,","),"text")
		categories = removeDuplicatesFromList(categories)
		return categories;
	}
</cfscript>	

</cfcomponent>
