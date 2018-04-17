<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
		<cfset usesLayout("/conference/adminlayout")>
		<cfset filters(through="setreturn", only="index,show")>
	</cffunction>

	<!--- -instructors/index --->
	<cffunction name="index">
	<cfargument name="event" default="#getevent()#">
	<cfif isDefined("params.event")>
		<cfset arguments.event = params.event>
	</cfif>
		<cfset instructors = model("Conferenceinstructor").findAll(order="lname, fname", where="event='#arguments.event#'")>
	</cffunction>

	<!--- -instructors/list --->
	<cffunction name="list">
	<cfargument name="event" default="#getevent()#">
		<cfset instructors = model("Conferenceinstructor").findAll(order="lname, fname", where="event='#arguments.event#'")>
		<cfset headerSubTitle = "Speakers">
		<cfset renderPage(layout="/conference/layout2017")>
	</cffunction>

	<!--- -instructors/show/key --->
	<cffunction name="show">

		<!--- Find the record --->
    	<cfset instructor = model("Conferenceinstructor").findByKey(params.key)>
    	<cfset courses = model("Conferencecourseinstructor").findAll(where="instructorId = #params.key# AND event = '#getevent()#'", include="CourseInfo")>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(instructor)>
	        <cfset flashInsert(error="instructor #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

	<!--- -instructors/new --->
	<cffunction name="new">
		<cfset instructor = model("Conferenceinstructor").new()>
		<cfset instructor.event = getEvent()>
	</cffunction>

	<!--- -instructors/edit/key --->
	<cffunction name="edit">

		<!--- Find the record --->
    	<cfset instructor = model("Conferenceinstructor").findByKey(params.key)>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(instructor)>
	        <cfset flashInsert(error="instructor #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>

	<!--- -instructors/edit/key --->
	<cffunction name="copy">

		<!--- Find the record --->
	    	<cfset instructor = model("Conferenceinstructor").findByKey(params.key)>
		<cfset instructor.event = getEvent()>

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(instructor)>
	        <cfset flashInsert(error="instructor #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    </cfif>

	</cffunction>
	
	<!--- Instructors/copyAllToCurrentEvent --->

	<cfscript>
		public function copyAllToCurrentEvent(){
			super.copyAllToCurrentEvent( tableName = "Conferenceinstructor" );
			returnBack();
		}
	</cfscript>


	<!--- -instructors/create --->
	<cffunction name="create">
		<cfset instructor = model("Conferenceinstructor").new(params.instructor)>

		<!--- Verify that the instructor creates successfully --->
		<cfif instructor.save()>
			<cfset flashInsert(success="The instructor was created successfully.")>
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the instructor.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>

	<!--- -instructors/update --->
	<cffunction name="update">
		<cfset instructor = model("Conferenceinstructor").findByKey(params.key)>

		<!--- Verify that the instructor updates successfully --->
		<cfif instructor.update(params.instructor)>
			<cfset flashInsert(success="The instructor was updated successfully.")>
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the instructor.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>

	<!--- -instructors/delete/key --->
	<cffunction name="delete">
		<cfset instructor = model("Conferenceinstructor").findByKey(params.key)>

		<!--- Verify that the instructor deletes successfully --->
		<cfif instructor.delete()>
			<cfset flashInsert(success="The instructor was deleted successfully.")>
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the instructor.")>
            <cfset returnBack()>
		</cfif>
	</cffunction>

	<cffunction name="listInstructorsAsJson">
		<cfset data = model("Conferenceinstructor").findInstructorsAsJson(params)>
	        	<cfset renderPage(template="/json", layout="/layout_json", hideDebugInformation=true)>
	</cffunction>

	<cffunction name="listspeakersAsJson">
		<cfset data = model("Conferenceinstructor").findSpeakersAsJson(params)>
	        	<cfset renderPage(template="/json", layout="/layout_json", hideDebugInformation=true)>
	</cffunction>



</cfcomponent>
