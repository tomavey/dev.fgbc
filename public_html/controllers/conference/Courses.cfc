<cfcomponent extends="Controller" output="false">

	<cffunction name="init">
		<cfset usesLayout(template="/conference/layout2018/")>
		<cfset filters(through="getevents", only="edit,new,copy")>
		<cfset filters(through="setreturn", only="index,show,showallselectedworkshops,showallselectedcohorts,list")>
		<cfset filters(through="openWorkshops")>
		<cfset filters(through="getCourses", only="list,listCohorts")>
		<cfset filters(through="getSubtypes", only="list,listCohorts,selectcohorts,showSelectedWorkshops,sendSelectedWorkshops")>
		<cfset filters(through="setPublicLayout")>
		<cfset filters(through="isAuthorized", only="copy,create,update,copyAllToCurrentEvent")>
	</cffunction>

<!------------->
<!---Filters--->
<!------------->

	<cffunction name="setPublicLayout">
		<cfset publicLayout = "/conference/layout2018">
	</cffunction>

	<cffunction name="isAuthorized">
		<cfif !gotRights('office')>
			<cfset renderText("You do have permission to view this page")>
		</cfif>
	</cffunction>

	<cffunction name="getEvents">
		<cfset var inCategory = "">
		<cfset var i = 0>
		<cfset var whereString = "">
		<cfloop list="#typesOfCoursesForDropdown()#" index="i">
			<cfset inCategory = "#inCategory# OR category = '#i#'" >
		</cfloop>
		<cfset inCategory = replace(inCategory,"OR","")>
		<cfset whereString = "event='#getEvent()#' AND (#inCategory#)">

		<cfset events = model("Conferenceevent").findAll(where=whereString, include="Location", order="selectName")>
	</cffunction>

	<cffunction name="openWorkshops">
		<cfif isDefined("params.opeworkshops") || isDefined("params.openCohorts")>
			<cfset session.auth.openWorkshops = true>
		</cfif>
		<cfreturn>
	</cffunction>

	<cffunction name="getCourses">
	<cfargument name="type" default="all">
	<cfargument name="orderBy" default="date,title,lname">
	<cfargument name="recorded" default="no">
	<cfargument name="courseid" default=0>


		<!---Overwrite argument defaults based on params--->
		<cfif isDefined("params.key")>
			<cfset arguments.type = params.key>
		</cfif>
		<cfif isDefined("params.type")>
			<cfset arguments.type = params.type>
		</cfif>
		<cfif isDefined("params.orderBy")>
			<cfset arguments.orderBy = params.orderBy>
		</cfif>
		<cfif isDefined("params.recorded")>
			<cfset arguments.recorded = "yes">
		</cfif>
		<cfif isDefined("params.event")>
			<cfset arguments.event = params.event>
		<cfelse>
			<cfset arguments.event = getEvent()>
		</cfif>	
		<cfif isDefined("params.courseid")>
			<cfset arguments.courseid = params.courseid>
		</cfif>	
		<cfif isDefined("params.NoQ")>
			<cfset showQuestionsPostLink = false>
		<cfelse>
			<cfset showQuestionsPostLink = false>
		</cfif>

		<cfset introTitle = "Cohorts">

		<cfset courses = model("Conferencecourse").findList(order=arguments.orderby, type="#arguments.type#", recorded="#arguments.recorded#", event=arguments.event, courseid=arguments.courseid)>
	<!---cfdump var="#courses#"><cfabort--->
	</cffunction>

	<cffunction name="getSubtypes">
		<cfset subtypes = structNew()>
		<cfset subtypes.A = "Tuesday, July 24">
		<cfset subtypes.B = "Wednesday, July 25">
		<cfset subtypes.C = "Repeated Tue & Wed">
		<cfset subtypes.D = "Two Days Long: Tuesday and Wednesday">
	</cffunction>	

<!---End of Filters--->


<!--------------->
<!--- C.R.U.D.--->
<!--------------->

	<!--- Courses/index --->
	<cffunction name="index">
		<cfset courses = model("Conferencecourse").findAllCourses(params)>
		<cfset renderPage(layout="/conference/adminlayout")>
	</cffunction>

	<!--- Courses/show/key --->
	<cffunction name="show">

		<!--- Find the record --->
	    	<cfset course = model("Conferencecourse").findOne(where="id=#params.key#", include="Agenda")>
	    	<cfset instructors = model("Conferencecourseinstructor").findAll(where="courseId = #params.key#", include="InstructorInfo")>

	    	<!--- Check if the record exists --->
		    <cfif NOT IsObject(course)>
		        <cfset flashInsert(error="Course/Workshop #params.key# was not found")>
		        <cfset redirectTo(action="index")>
		    </cfif>

		<cfset renderPage(layout="/conference/adminlayout")>

	</cffunction>

	<!--- Courses/create --->
	<cffunction name="create">
		<cfset course = model("Conferencecourse").new(params.course)>

		<!--- Verify that the Conferencecourse creates successfully --->
		<cfif course.save()>
			<cfset flashInsert(success="The Course was created successfully.")>
	            <cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the Conferencecourse.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>

	<!--- Courses/update --->
	<cffunction name="update">
		<cfset course = model("Conferencecourse").findByKey(params.key)>

		<!--- Verify that the Conferencecourse updates successfully --->
		<cfif course.update(params.course)>
			<cfset flashInsert(success="The Conferencecourse was updated successfully.")>
            		<cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the Conferencecourse.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>

	<!--- Courses/delete/key --->
	<cffunction name="delete">
    	<cfset course = model("Conferencecourse").findOne(where="id=#params.key#")>

		<!--- Verify that the Conferencecourse deletes successfully --->
		<cfif course.delete()>
			<cfset flashInsert(success="The course was deleted successfully.")>
            		<cfset returnBack()>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the course.")>
			<cfset redirectTo(action="index")>
		</cfif>
	</cffunction>

	<!--- Courses/new --->
	<cffunction name="new">
		<cfset course = model("Conferencecourse").new()>
		<cfset course.event = getEvent()>
		<cfset renderPage(layout="/conference/adminlayout")>
	</cffunction>

	<!--- Courses/edit/key --->
	<cffunction name="edit">

		<!--- Find the record --->
		<cfset course = model("Conferencecourse").findByKey(params.key)>

		<!--- Check if the record exists --->
		<cfif NOT IsObject(course)>
				<cfset flashInsert(error="Course #params.key# was not found")>
		<cfset redirectTo(action="index")>
		</cfif>

		<cfset renderPage(layout="/conference/adminlayout")>

	</cffunction>

	<!--- Courses/copy/key --->
	<cffunction name="copy">

		<!--- Find the record --->
    		<cfset course = model("Conferencecourse").findByKey(params.key)>

    		<!--- Check if the record exists --->
	    	<cfif NOT IsObject(course)>
	        		<cfset flashInsert(error="Course #params.key# was not found")>
			<cfset redirectTo(action="index")>
	    	</cfif>

	    <cfset renderPage(controller="conference.courses", action="new")>

	</cffunction>
	

	<!--- Courses/copyAllToCurrentEvent --->
	<!--- Turned off for now - 6/5/18 --->
	<cfscript>
		public function copyAllToCurrentEventX(){
			super.copyAllToCurrentEvent( tableName = "Conferencecourse" );
			returnBack();
		}
	</cfscript>

<!---END OF CRUD--->


<!------------------>
<!---Public Pages--->
<!------------------>

	<!--- Courses/view/key route="conferenceCoursesView"--->
	<cffunction name="view">

		<!--- Find the record --->
    	<cfset course = model("Conferencecourse").findOne(where="id=#params.key# AND event='#getEvent()#'", include="Agenda")>
    	<cfset instructors = model("Conferencecourseinstructor").findAll(where="courseId = #params.key#", include="InstructorInfo")>
		<cfset questions = model("Conferencecoursequestion").findAll(where="courseid=#params.key#", order="createdAt DESC", include="person(family)")>

		<cfset introTitle = "Workshop...">

    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(course)>
	        <cfset flashInsert(error="Course/Workshop #params.key# was not found")>
	        <cfset redirectTo(action="index")>
	    </cfif>
	</cffunction>

	<!--- Courses/list route="conferenceCoursesList"--->
	<cffunction name="list">

		<cfif isDefined("params.print")>
			<cfset renderPage(layout="/conference/layout_naked", template="listprint")>
		<cfelse>
			<cfset setreturn()>
		</cfif>

	</cffunction>

	<!---Courses/select-workshops route="conferenceCoursesSelectWorkshops"--->
	<cffunction name="selectWorkshops">
	<cfargument name="type" default="cohort">
		<!---over write default arguments based on params--->
		<cfif isDefined("params.type")>
			<cfset arguments.type = params.type>
		</cfif>

		<!---if a personid is not provide go to the select person page--->
		<cfif not isDefined("params.personid") or not len(params.personid)>
			<cfset redirectTo(route="conferenceCoursesSelectPersonToSelectCohorts", params="type=#arguments.type#")>
		</cfif>

		<!---Get Workshops--->
		<cfset workshops = model("Conferencecourse").findAll(where="event='#getEvent()#' AND category = '#translateType(arguments.type)#'", include="Agenda", order="radioButtonGroup,eventDate,title")>

		<!--- get this person - not sure why I need to check for personid--->
		<cfif isDefined("params.personid")>
			<cfset person = model("Conferenceperson").findOne(where="id=#params.personid#", include="family")>
		</cfif>
		<!---Set action to be used in the form--->
		<cfset formaction = "saveSelectedWorkshops">

	</cffunction>

	<!---Courses/select-cohorts route="conferenceCoursesSelectCohorts"--->
	<cffunction name="selectCohorts">
	<cfargument name="type" default="cohort">
	<cfset var loc=arguments>

	<cfif isDefined("params.type")>
		<cfset loc.type = params.type>
	</cfif>	 

		<cfset cohorts = model("Conferencecourse").findAll(where="event='#getEvent()#' AND type IN ('#loc.type#')", order="title")>

		<cfif isDefined("params.personid")>
			<cfset selectedcohorts = model("Conferenceregistration").findAll(where="equip_peopleid=#params.personid# AND equip_optionsid = #getOptionIdFromName(translatetype(arguments.type))#")>
			<cfset coursesIdList = "">
			<cfloop query="selectedCohorts">
				<cfset coursesIdList = coursesIdList & "," & equip_coursesid>
			</cfloop>
			<cfset coursesIdList = replace(coursesIdList,",","")>

			<cfset headerSubTitle = "Select Cohorts or Workshops for #getPersonFromId(params.personid)# Here">

		<cfset formaction = "saveSelectedCohorts">

		<cfelse>	

			<cfset redirectTo(route="conferenceCoursesSelectPersonToSelectCohorts", params="type=#arguments.type#")>

		</cfif>
		
	</cffunction>

	<cffunction name="showAllSelectedWorkshops">
		<cfset whereString = "event='#getEvent()#' AND type='workshop'">
		<cfif isDefined("params.key")>
			<cfset whereString = whereString & " AND id = #params.key#">
		</cfif>
		<cfset workshops = model("Conferenceregistration").findAll(where=whereString, include="Workshop(Agenda),person(family)", order="eventDate")>
		<cfset countpeopleregistered = countPeopleRegistered()>
	</cffunction>

	<cffunction name="showAllSelectedCohorts">
		<cfset var orderby = "title">
		<cfset var loc = StructNew()>
		<cfif isDefined("params.orderby")>
			<cfset orderBy = params.orderby>
		</cfif>
		<cfset whereStringAll = "event='#getEvent()#' AND type='cohort'">
		<cfif isDefined("params.key")>
			<cfset whereString = whereStringAll & " AND equip_coursesid = #params.key#">
		<cfelse>
			<cfset whereString = whereStringAll>	
		</cfif>
		<cfset workshops = model("Conferenceregistration").findAll(where=whereString, include="Workshop(Agenda),person(family)", order=orderby)>
		<cfset loc.workshopsSignedUPFor = ValueList(workshops.title)>
		<cfset allWorkshops = model("Conferencecourse").findAll(where=whereStringAll)>
		<cfset emptyWorkshops = "">
		<cfloop query="allWorkshops">
			<cfif !listFind(loc.workshopsSignedUPFor,title)>
				<cfset emptyWorkshops = emptyWorkshops & "," & title>
			</cfif>
		</cfloop>
		<cfset emptyWorkshops = replace(emptyWorkshops,",","","one")>
		<cfset countpeopleregistered = countPeopleRegistered()>
		<cfset renderPage(action="showAllSelectedWorkshops")>
	</cffunction>

	<!---Courses/select-person-to-select-cohorts/--->
	<cffunction name="selectPersonToSelectCohorts">
	<cfset var loc=structNew()>
		<cfif !isDefined("params.type")>
			<cfset params.type = 'cohort'>
		</cfif>	
		<cfset loc.datelimit = createDateTime(year(now())-1,10,01,01,01,01)>
		<cfset registrations = model("Conferenceperson").findAllPeopleRegistered()>
		<cfset formaction = "ConferenceCoursesSelectCohorts">
		<cfset headerSubTitle = "Sign up for a Cohort">
		<cfset renderPage(template="selectPersonToSelectWorkshops")>
	</cffunction>

	<!---Courses/select-person-to-select-cohorts/--->
	<cffunction name="selectPersonToShowCohorts">
	<cfset var loc=structNew()>
		<cfset loc.datelimit = createDateTime(year(now())-1,10,01,01,01,01)>
		<cfset registrations = model("Conferenceperson").findAllPeopleRegistered()>
		<cfset formaction = "showSelectedWorkshops">
		<cfset headerSubTitle = "Show My Cohorts">
		<cfset instructions = "">
		<cfset renderPage(template="selectPersonToSelectWorkshops")>
	</cffunction>

	<cffunction name="showAllSelectedExcursions">
		<cfset whereString = "event='#getEvent()#' AND type='excursion'">
		<cfif isDefined("params.key")>
			<cfset whereString = whereString & " AND equip_coursesid = #params.key#">
		</cfif>
		<cfset workshops = model("Conferenceregistration").findAll(where=whereString, include="Workshop(Agenda),person(family)", order="eventDate")>
		<cfset renderPage(action="showAllSelectedWorkshops")>
	</cffunction>

	<!--- Courses/table --->
	<cffunction name="table">
	<cfargument name="type" default="all">
	<cfargument name="orderBy" default="room,date">

		<cfset introTitle = "Workshops">

		<!---Overwrite argument defaults based on params--->
		<cfif isDefined("params.key")>
			<cfset arguments.type = params.key>
		</cfif>
		<cfif isDefined("params.type")>
			<cfset arguments.type = params.type>
		</cfif>
		<cfif isDefined("params.orderby")>
			<cfset arguments.orderby = params.orderby>
			<cfif params.orderby is "track">
				<cfset arguments.orderBy = "track,date">
			</cfif>
			<cfset firstcolumnname = "Track">
			<cfset firstlevelgroup = "track">
		</cfif>

		<cfset courses = model("Conferencecourse").findList(order=arguments.orderby, type="#arguments.type#")>
	</cffunction>


<!---End of Public Pages--->


<!-------------------------->
<!---Get Text for Content--->
<!-------------------------->

	<cffunction name="getSubtypeDesc">
	<cfargument name="subtype" required="true" type="string">
		<cfif subtype is "A">
			<cfreturn "This cohort meets on Tuesday, July 24 from 11:00 am - 12:15 pm and 2:00 pm - 3:30 pm.">
		</cfif>
		<cfif subtype is "B">
			<cfreturn "This cohort meets on Wednesday, July 25 from 11:00 am - 12:15 pm and 2:00 pm - 3:30 pm.">
		</cfif>
		<cfif subtype is "C">
			<cfreturn "Signup for this cohort is very high so we are offering it twice.<br/><br/>You can choose either the Tuesday or Wednesday.<br/><br/>Specific times are (choose A or B):<br/>A = Tuesday from 11:15-12:15 and 3:00 - 5:00 and Wednesday from 9:30 - 11:30;<br/>B = Wednesday from 3:00 - 5:00, Thursday from 9:30 - 11:30 and 3:00 - 5:00.">
		</cfif>
		<cfif subtype is "C">
			<cfreturn "Signup for this cohort is very high so we are offering it twice.<br/><br/>You can choose either the Tuesday/Wednesday (A) or the Wednesday/Thursday (B).<br/>">
		</cfif>
		<cfif subtype is "D">
			<cfreturn "This is a two day workshop... Tuesday from 11:15-12:15 and 3:00 - 5:00 and Wednesday from 9:30 - 11:30">
		</cfif>
	<cfreturn "NA">
	</cffunction>

	<cffunction name="getCohortsDescription">
	<cfset var description = '<p>Cohorts are peer learning groups focused around various areas of ministries. Participants will have lots of time to talk about what is working, what is not, ask questions, discuss best practices and even work through issues together. Each cohort will be guided by trained facilitators.<br/> People who are registered for #getEventAsText()# should select two cohorts. </p>Each Cohort meets twice on either Tuesday or Wednesday. They meet on Tuesday or Wednesday from 11:00 am - 12:15 pm AND from 2:00 pm - 3:30 pm. Cohorts will not meet on Thursday.  
      </p>
      <p>
			We are also offering a few workshops this year during the same times as cohorts.  Workshops are designed for larger groups, are more didactic with a teacher rather than a facilitator.  Workshops are marked.
      </p>'>
		<cfreturn description>
	</cffunction>


<!------------------>
<!---Redirections--->
<!------------------>

	<!---Courses/workshops--->
	<cffunction name="workshops">
		<cfset redirectTo(controller="conference.courses", action="list", params="type=workshop")>
	</cffunction>

	<!--- Courses/workshopstable .get(name="conferenceworkshopstable", pattern="/workshops/table/", controller="courses", action="workshopstable") --->
	<cffunction name="workshopstable">
		<cfset redirectTo(controller="conference.courses", action="table", params="type=workshop")>
	</cffunction>

	<!---Courses/riskursions--->
	<cffunction name="riskursions">
		<cfset redirectTo(controller="conference.courses", action="list", params="type=excursion")>
	</cffunction>

	<cffunction name="listCohorts">
		<cfif isDefined("params.print")>
			<cfset renderPage(action="list", key="cohort", layout="/conference/layout_naked", template="listprint")>
		<cfelse>
			<cfset setreturn()>
			<cfset renderPage(action="list", key="cohort")>
		</cfif>
	</cffunction>

<!----------End of Redirections----------------->



	<!--- Courses/rss --->
	<cffunction name="rss">
		<cfset courses = model("Conferencecourse").findList()>

		<cfset title = "#getEventAsText()# Workshops">

		<cfset description= "#getEventAsText()# will include a number of workshops.">

		<cfif application.wheels.environment is not "production">
			<cfset set(environment="production")>
		</cfif>

		<cfset renderPage(template="rss.cfm", layout="rsslayout")>
	</cffunction>

	<cffunction name="getInstructors">
	<cfargument name="courseid" required="true" type="numeric">
	<cfset var loc=structNew()>
	<cfset loc = arguments>
    	<cfset loc.instructors = model("Conferencecourseinstructor").findAll(where="courseId = #loc.courseid#", include="Instructor")>
	<cfreturn loc.instructors>
	</cffunction>

	<cffunction name="getInstructorNamesAsString">
	<cfargument name="courseid" required="true" type="numeric">
	<cfset var loc=structNew()>
	<cfset loc = arguments>
		<cfset loc.instructors = getInstructors(loc.courseid)>
		<cfset loc.names = "">
		<cfloop query="loc.instructors">
			<cfset loc.names = loc.names & ", " & "#linkto(text=selectName, controller='conference.instructors', action='show', key=id)#">
		</cfloop>
		<cfset loc.names = replace(loc.names,", ","","one")>
	<cfreturn loc.names>
	</cffunction>

	<cffunction name="getPersonFromId">
	<cfargument name="id" required="true" type="numeric">
		<cfset personName = model("Conferenceperson").findAll(where="id=#arguments.id#", include="family").fullname>
	<cfreturn personName>
	</cffunction>

	<cffunction name="saveSelectedCohorts">
	<cfargument name="type"  default="cohort">
	<cfset var i = 0>
		<cfif isDefined("params.type")>
			<cfset arguments.type = params.type>
		</cfif>

		<cfif listlen(params.cohorts) LTE 2>
			<cfset deletedSelectedWorshopsForPersonid(params.personid,params.type)>
			<cfloop list="#params.cohorts#" index="i">
				<cfset registration = model("Conferenceregistration").new()>
				<cfset registration.equip_peopleid = params.personid>
				<cfset registration.equip_coursesid = i>
				<cfset registration.equip_optionsid = getOptionIdFromName(translatetype(arguments.type))>
				<cfset registration.equip_invoicesid = 1115>
				<cfset registration.quantity = 1>
				<cfset check = registration.save()>
			</cfloop>
			<cfset redirectTo(action="showSelectedWorkshops", params="type=#params.type#&personid=#personid#")>
		<cfelse>
			<cfset flashInsert(toomany="Too many cohorts were selected. Please pick 2.")>
			<cfset redirectTo(action="selectCohorts", personid=params.personid, params="type=#params.type#&personid=#personid#")>
		</cfif>
	</cffunction>

	<cffunction name="translateType" hint="allows variable in type that is called for">
	<cfargument name="type" required="true" type="string">
	<cfset var loc=structNew()>
		<cfset loc.workshops = "workshop">
		<cfset loc.workshop = "workshop">
		<cfset loc.excursion = "excursion">
		<cfset loc.riskursion = "excursion">
		<cfset loc.riskursions = "excursion">
		<cfset loc.riscursion = "excursion">
		<cfset loc.riscursions = "excursion">
		<cfset loc.cohorts = "cohort">
		<cfset loc.cohort = "cohort">
	<cfreturn loc['#arguments.type#']>
	</cffunction>

	<cffunction name="isInWorkshop">
	<cfargument name="personid" required="true" type="numeric">
	<cfargument name="workshopid" required="true" type="numeric">
		<cfset thisPersonsWorkshops = model("Conferenceregistration").findOne(where="equip_peopleid=#arguments.personid# AND equip_coursesid=#arguments.workshopid#", include="Workshop")>
		<cfif isObject(thisPersonsWorkshops)>
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>
	</cffunction>

	<cffunction name="saveSelectedWorkshops">
	<cfargument name="type"  default="#params.type#">
		<cfset deletedSelectedWorshopsForPersonid(params.personid,params.type)>
		<cfset dates = model("Conferencecourse").getCourseDates(translateType(arguments.type))>
		<cfloop list="#dates#" index="i">
				<cfloop list="#params.radioButtonGroups#" index="ii">
				<cfif ii is "0">
					<cfset iii = i>
				<cfelse>
					<cfset iii = i&ii>
				</cfif>
					<cfset registration = model("Conferenceregistration").new()>
					<cfset registration.equip_peopleid = params.personid>
					<cfset registration.equip_coursesid = params[#iii#]>
					<cfset registration.equip_optionsid = getOptionIdFromName(translatetype(arguments.type))>
					<cfset registration.equip_invoicesid = 1115>
					<cfset registration.quantity = 1>
					<cfset registration.save()>
			</cfloop>
		</cfloop>
		<cfset redirectTo(action="showSelectedWorkshops", params="personid=#params.personid#&type=#arguments.type#")>
	</cffunction>

	<cffunction name="showSelectedWorkshops">
	<cfargument name="type"  default="cohorts">
		<cfif isDefined("params.type")>
			<cfset arguments.type = params.type>
		<cfelse>
			<cfset params.type = arguments.type>	
		</cfif>
	<cfset var loc = arguments>
	<cfset loc.sendString = "from='tomavey@fgbc.org', layout='/conference/layout_for_email', template='showSelectedWorkshops', subject='Your #params.type# selections...'">
	<cfset arguments.type = translateType(arguments.type)>
		<cfif isDefined("params.personid")>

			<cfset workshops = model("Conferenceregistration").findAll(where="equip_peopleid=#params.personid# AND type='#arguments.type#'", include="Workshop(Agenda)", order="eventDate")>

			<cfset person = model("Conferenceperson").findOne(where="id=#params.personid#", include="family")>
		<cfelse>
			<cfset redirectTo(action="selectPersonToShowCohorts", params="type=#arguments.type#&encodePersonId=false")>
			Need to get personid<cfabort>	
		</cfif>
		<cftry>
			<cfif isValid("email",person.email) && workshops.recordcount>
				<cfset loc.sendString = loc.sendString & ", to=person.email">
				<cfif workshopNotificationsOpen()>

					<cfset sendEmail(from='tomavey@fgbc.org', layout='/conference/layout_for_email', template='showSelectedWorkshops', subject='Your cohort selections...', to=person.email, bcc=workshopnotifications())>

				<cfelse>
					<cfset sendEmail(from='tomavey@fgbc.org', layout='/conference/layout_for_email', template='showSelectedWorkshops', subject='Your cohort selections...', to=person.email)>
				</cfif>
		 		<cfset flashInsert(success="#capitalize(arguments.type)# selections were sent to #person.email#")>
			</cfif>
		<cfcatch></cfcatch></cftry>

		<cftry>
			<cfif isValid("email",person.family.email) and person.family.email NEQ person.email>
				<cfif application.wheels.workshopNotificationsOpen>
					<cfset sendEmail(from='tomavey@fgbc.org', layout='/conference/layout_for_email', template='showSelectedWorkshops', subject='Your cohort selections...', to=person.family.email, bcc=application.wheels.workshopnotifications)>
				<cfelse>
					<cfset sendEmail(from='tomavey@fgbc.org', layout='/conference/layout_for_email', template='showSelectedWorkshops', subject='Your cohort selections...', to=person.family.email)>
				</cfif>
		 		<cfset flashInsert(success="#capitalize(arguments.type)# selections were sent to #person.family.email#")>
			</cfif>
		<cfcatch></cfcatch></cftry>

		<cfif isMobile()>
			<cfset renderPage(layout="/conference/layout_mobile")>
		</cfif>

		<cfset setreturn()>

		<cfset headerSubTitle = "Selected Cohorts">

	</cffunction>

	<cffunction name="sendSelectedWorkshops">
	<cfargument name="type" default="#params.type#">
	<cfargument name="personid" default="#params.personid#">
	<cfargument name="sendToEmail" default="tomavey@fgbc.org">
	<cfset arguments.type = translateType(arguments.type)>
	<cfif isDefined("params.email") && isValid("email",params.email)>
		<cfset arguments.sendToEmail = params.email>
	<cfelse>
		<cfset flashInsert(success="Please provide a valid email address to send this list to.")>
		<cfset redirectTo(action="showSelectedWorkshops", params="personid=#params.personid#&type=#params.type#")>
	</cfif>
		<cfset workshops = model("Conferenceregistration").findAll(where="equip_peopleid=#arguments.personid# AND type='#arguments.type#'", include="Workshop(Agenda)", order="eventDate")>
		<cfset person = model("Conferenceperson").findOne(where="id=#params.personid#", include="family")>
			<cfif !isLocalMachine()>
				<cfset sendEMail(to=arguments.sendToEmail, from="tomavey@fgbc.org", layout="/conference/layout_for_email", template="showSelectedWorkshops", subject="Access2017 #params.type# selections")>
				<cfset flashInsert(success="The email was sent to #arguments.sendToEmail#")>
			<cfelse>
				<cfset flashInsert(success="The email was NOT sent to #arguments.sendToEmail# from this local server")>
			</cfif>	
		<cfset redirectTo(action="showSelectedWorkshops", params="personid=#params.personid#&type=#params.type#")>
	</cffunction>

	<cffunction name="downloadAllSelectedCohorts">
		<cfset var orderby = "title">
		<cfif isDefined("params.orderby")>
			<cfset orderBy = params.orderby>
		</cfif>
		<cfset whereString = "event='#getEvent()#' AND type='cohort'">
		<cfif isDefined("params.key")>
			<cfset whereString = whereString & " AND equip_coursesid = #params.key#">
		</cfif>
		<cfset workshops = model("Conferenceregistration").findAll(where=whereString, include="Workshop(Agenda),person(family)", order=orderby)>
		<cfset countpeopleregistered = countPeopleRegistered()>
		<cfset renderPage(action="downloadallselectedworkshops", layout="/layout_download")>
	</cffunction>

	<cffunction name="countPeopleRegistered">
		<cfset var return = model("Conferenceregistration").countRegsByType(ccstatus="All",includeFree="true") + model("Conferenceregistration").countRegsByType(type="Couple", ccstatus="All",includeFree="true")>
		<cfreturn return>
	</cffunction>

	<cffunction name="countEligibleToSignup">
	<cfset var regs = structNew()>
		<cfset regs.vTORcouples = model("Conferenceregistration").countRegs(348,params) + model("Conferenceregistration").countRegs(354,params)>
		<cfset regs.vTORsingles = model("Conferenceregistration").countRegs(349,params) + model("Conferenceregistration").countRegs(351,params)>
		<cfset regs.vTORdaysingle = model("Conferenceregistration").countRegs(350,params)>
		<cfset regs.vTORprepaid = model("Conferenceregistration").countRegs(360,params)*2 + model("Conferenceregistration").countRegs(361,params)>
		<cfset regs.vTORFreeYoung = model("Conferenceregistration").countRegs(352,params) + (model("Conferenceregistration").countRegs(355,params) * 2)>
		<cfset regs.vTORFreeOld = model("Conferenceregistration").countRegs(356,params) + (model("Conferenceregistration").countRegs(359,params) * 2)>
		<cfset regs.vTORFree = regs.vTORFreeYoung + regs.vTORFreeOld>
		<cfset regs.vTORall = (regs.vTORcouples*2) + regs.vTORsingles + regs.vTORdaysingle + regs.vTORprepaid + regs.vTORFree>
		<cfreturn regs.vTORall>
	</cffunction>

	<cffunction name="getEventEquipmentForThisCourse">
	<cfargument name="eventid" default="716">
	<cfset var loc = structNew()>
		<cfset loc.eventinfo = model("Conferenceevent").findOne(where="id = #arguments.eventid#")>
		<cfreturn loc.eventinfo>
	</cffunction>

	<cffunction name="deletedSelectedWorshopsForPersonid">
	<cfargument name="personid" required="true" type="numeric">
	<cfargument name="type" required="true" type="string">
	<cfset var loc = structNew()>
	<cfset loc=arguments>
		<cfset loc.optionid = getOptionIdFromName(translatetype(loc.type))>
		<cfset loc.workshops = model("Conferenceregistration").deleteAll(where="equip_peopleid = #loc.personid# AND equip_optionsid = #loc.optionid#")>
		<cfreturn true>
	</cffunction>

	<cffunction name="deletedSelectedWorshopsForRegId">
		<cfset worshops = model("Conferenceregistration").deleteAll(where="id = #params.key#")>
		<cfset returnBack()>
	</cffunction>

	<cffunction name="isSignedUpForCourse">
	</cffunction>

	<cffunction name="alsoSignedUpFor">
	<cfargument name="courseId" required="true" type="numeric">
	<cfset var loc = arguments>
		<cfset loc.alsoSignedUpFor = model("Conferencecourse").alsoSignedUpFor(courseId)>
		<cfreturn loc.alsoSignedUpFor>
	</cffunction>

	<cffunction name="getCourseResources">
	<cfargument name="courseId" required="true" type="numeric">
		<cfset var resources = model("Conferencecourseresource").findall(where="id=#arguments.courseId#", order="createdAt DESC")>
	<cfreturn resources>
	</cffunction>

	<cffunction name="json">
		<cfset data = model("Conferencecourse").findAllAsJson(params)>
		<cfset renderPage(layout="/layout_json", template="/json", hideDebugInformation=true)>
	</cffunction>

<!--- MArked for Deletion--->


	<cffunction name="XgetRadioButtonGroups">
	<cfset radioButtonTypes = "">
	<cfloop collection="#params#" item="i">

	</cfloop>

	</cffunction>



</cfcomponent>
