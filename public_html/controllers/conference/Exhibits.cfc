<cfcomponent extends="Controller" output="false">

	<cffunction name="config">
		<cfset usesLayout("/conference/adminlayout")>
		<cfset filters(through="officeOnly", only="edit,delete")>
		<cfset filters(through="isExhibitsOpen", only="new,info")>
		<cfset filters(through="setReturn", only="list,index")>
	</cffunction>

<!---Filters--->

	<cffunction name="isExhibitsOpen">
		<cfif getSetting('exhibitorsIsOpen') || gotrights("office")>
			<cfreturn true>
		<cfelse>
			<cfset renderText("<h2 style='text-align:center'>#getEventAsText()# is just around the corner! Exhibits are all set.  Check back next year.</h2>")>
		</cfif>
	</cffunction>



<!----------->
<!---CRUD---->
<!----------->

	<!--- exhibits/index --->
	<cffunction name="index">
	<cfset orderby = "organization">
	<cfif isDefined("params.event")>
		<cfset whereString = "event='#params.event#'">
	<cfelse>
		<cfset whereString = "event='#getEvent()#'">
	</cfif>
	<cfif isDefined("params.history")>
		<cfset whereString = "">
	</cfif>
	<cfif isDefined("params.sortby")>
		<cfset orderby = params.sortby>
	</cfif>
		<cfset exhibits = model("Conferenceexhibit").findAll(where=whereString, order=orderby)>
	</cffunction>


	<!--- exhibits/show/key --->
	<cffunction name="show">

		<!--- Find the record --->
    	<cfset exhibit = model("Conferenceexhibit").findByKey(params.key)>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(exhibit)>
	        <cfset flashInsert(error="Exhibit #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

	<!--- exhibits/new --->
	<cffunction name="new">
		<cfset exhibit = model("Conferenceexhibit").new()>
		<cfset introTitle = "Exhibitors Request Form">
		<cfset renderView(layout="/conference/layout2018")>
	</cffunction>

	<!--- exhibits/create --->
	<cffunction name="create">
		<cfset params.exhibit.event = getEvent()>
		<cfset exhibit = model("Conferenceexhibit").create(params.exhibit)>

		<cfif exhibit.hasErrors()>
			<cfset flashInsert(error="There was an error creating the exhibit.")>
			<cfset renderView(action="new")>
		<cfelse>
			<cfset flashInsert(success="The exhibit was created successfully.")>
			<cfif !isLocalMachine()>
				<cfset sendemail(from=exhibit.email, to=getSetting("registraremail"), template="email", subject="A Vision Conference Exhibitors request has been submitted", layout="/conference/layout_for_email")>
			</cfif>
      <cfset redirectTo(action="thankyou",key=exhibit.id)>
		</cfif>
	</cffunction>

	<!--- exhibits/edit/key --->
	<cffunction name="edit">

		<!--- Find the record --->
    	<cfset exhibit = model("Conferenceexhibit").findByKey(params.key)>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(exhibit)>
	        <cfset flashInsert(error="Exhibit #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

	<!--- exhibits/update --->
	<cffunction name="update">
		<cfset exhibit = model("Conferenceexhibit").findByKey(params.key)>

		<!--- Verify that the exhibit updates successfully --->
		<cfif exhibit.update(params.exhibit)>
			<cfset flashInsert(success="The exhibit was updated successfully.")>
      <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the exhibit.")>
			<cfset renderView(action="edit")>
		</cfif>
	</cffunction>

	<!--- exhibits/delete/key --->
	<cffunction name="delete">
		<cfset exhibit = model("Conferenceexhibit").findByKey(params.key)>

		<!--- Verify that the exhibit deletes successfully --->
		<cfif exhibit.delete()>
			<cfset flashInsert(success="The exhibit was deleted successfully.")>
            <cfset redirectTo(action="index")>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the exhibit.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>



<!--------------------->	
<!---- MISC REPORTS---->
<!--------------------->	

	<cffunction name="thankyou">
		<cfset exhibit = Model("Conferenceexhibit").findByKey(params.key)>
		<cfset introTitle = "Thank you!">
		<cfset renderView(layout="/conference/layout2018")>
	</cffunction>

	<cffunction name="info">
		<cfset introTitle = "Exhibitors Information">
		<cfset renderView(layout="/conference/layout2017")>
	</cffunction>

	<cfscript>
		<!--- exhibits/list --->
		public function list(){
			var orderBy = "organization";
			var whereString = "event='#getEvent()#'";
			if (isDefined('params.event')) { whereString = "event='#params.event#'" };
			if (isDefined('params.type') && params.type is "exhibit") { whereString = whereString & " AND type IN ('exhibit', 'both')" };
			if (isDefined("params.type") && (params.type is "sponsor")) { whereString = whereString & " AND type IN ('sponsor', 'both')" };
			if (isDefined("params.sortby")) { orderBy = params.sortby };
			exhibits = model("Conferenceexhibit").findAll(where=whereString, order=orderby);
			renderView(layout="/conference/layout2017");
		}

		// public function history(){
		// 	writeDump(params);abort;
		// 	if ( isDefined("params.orderby") ) { arguments.orderby = params.orderby }
		// 	exhibits = model("Conferenceexhibit").findAll(order=arguments.orderby)
		// 	writeDump(exhibits);abort;
		// }

	<!--- Exhibits/json--->
		public function json () {
			var orderBy = "organization";
			var whereString = "event='#getEvent()#' AND approved = 'Yes'";
			data = model("Conferenceexhibit").findAll(where=whereString, order=orderby);
			data = queryToJson(data);
			renderJson();
		}

	</cfscript>

</cfcomponent>
