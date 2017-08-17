<cfcomponent extends="controller">

	<cffunction name="init">
		<cfset usesLayout("/conference/adminlayout")>
	</cffunction>

	<cffunction name="new">
		<cfset newcourse = false>
		<cfset newinstructor = false>
		<cfset courseinstructor = model("Conferencecourseinstructor").new()>
		<cfif isDefined("params.courseid")>
			<cfset courseinstructor.courseid = params.courseid>
			<cfset newInstructor = true>
			<cfset instructors = model("Conferenceinstructor").findAll(where="event='#getEvent()#'", order="fname, lname")>
		<cfelseif isDefined("params.instructorid")>
			<cfset courseinstructor.instructorid = params.instructorid>
			<cfset newCourse = true>
			<cfset courses = model("Conferencecourse").findAll(where="event='#getevent()#'", order="title")>
		</cfif>
	</cffunction>

	<!--- -instructors/create --->
	<cffunction name="create">

		<cfset courseInstructor = model("Conferencecourseinstructor").new(params.courseInstructor)>

		<!--- Verify that the instructor creates successfully --->
		<cfif courseInstructor.save()>
			<cfset flashInsert(success="The course was connected successfully.")>
            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the connection.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>

	<!--- -instructors/delete/key --->
	<cffunction name="delete">

		<cfset model("Conferencecourseinstructor").delete(params.courseid,params.instructorid)>
        <cfset returnBack()>

	</cffunction>


</cfcomponent>