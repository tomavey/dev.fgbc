<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
		<cfset usesLayout("/conference/adminlayout")>
		<cfset filters(through="setreturn", only="index,show,list")>
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

		<cfset var whereString = "event='#arguments.event#'">
		<cfif isDefined("params.tag")>
			<cfset whereString = whereString & " AND tags LIKE '%#params.tag#%'">
		</cfif>
		<cfif isDefined("params.lname")>
			<cfset whereString = whereString & " AND lname LIKE '%#params.lname#%'">
		</cfif>
		<cfif isDefined("params.key")>
			<cfset whereString = whereString & " AND id = #params.key#">
		</cfif>
		<cfset var orderString = "lname, fname">
		<cfif isDefined("params.tag") && params.tag == "speaker">
			<cfset var orderString = "sortOrder, lname, fname">
		</cfif>
		<cfset instructors = model("Conferenceinstructor").findAll(order=orderString, where=whereString)>
		<cfset headerSubTitle = "Speakers">

		<cfif isDefined("params.tag")>
			<cfif params.tag is "speaker">
				<cfset headerSubTitle = "Speakers">
			</cfif>
			<cfif params.tag is "staff">
				<cfset headerSubTitle = "Staff">
			</cfif>
		</cfif>
		<cfset renderPage(layout="/conference/layout2018")>
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

	<!--- <cffunction name="listSpeakersAsJson">
		<cfdump var="listspeakersAsJson"><cfabort>
		<cfset data = model("Conferenceinstructor").findSpeakersAsJson(params)>
		<cfdump var="#params#"><cfabort>
   	<cfset renderPage(template="/json", layout="/layout_json", hideDebugInformation=true)>
	</cffunction> --->
	
<cfscript>

	function speakersAsJson(){
		var params.orderby = "sortOrder, lname, fname"
		data = model("Conferenceinstructor").findSpeakersAsJson(params)
		renderPage(template="/json", layout="/layout_json", hideDebugInformation=true)
	}

	function listStaffAsJson(){
		data = model("Conferenceinstructor").findStaffAsJson(params)
		renderPage(template="/json", layout="/layout_json", hideDebugInformation=true)		
	}
</cfscript>

<cfscript>
	public function testListToList () {
		var result = model("Conferenceinstructor").commaListToQuoteList("1,2,3");
		writeDump(result);abort;
	}
</cfscript>


</cfcomponent>
