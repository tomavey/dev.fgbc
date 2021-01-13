//TODO - Convert to cfscript
<cfcomponent extends="Model" output="false">

	<cffunction name="config">
		<cfset table("equip_courses")>
		<cfset belongsTo(name="Agenda", modelName="Conferenceevent", foreignKey="eventId", joinType="outer")>
		<cfset belongsTo(name="Event", modelName="Conferenceevent", foreignKey="eventId", joinType="outer")>
		<cfset hasMany(name="Instructors", modelName="Conferencecourseinstructor", foreignKey="instructorID")>

		<cfset property(name="countSold", SQL="select sum(quantity) from equip_registrations r where r.equip_coursesid = equip_courses.id and r.deletedAt IS NULL")>

	</cffunction>

	<cffunction name="findList">
	<cfargument name="order" default="title">
	<cfargument name="type" default="all">
	<cfargument name="recorded" default="no">
	<cfargument name="courseid" default=0>
	<cfargument name="event" default="#getEvent()#">
	<cfset var loc = structNew()>
	<cfset loc = arguments>

		<cfquery datasource = "fgbc_main_3" name="loc.data">
			SELECT c.id, c.subtype, title, track, descriptionshort, descriptionlong, recordinglink, DATE_FORMAT(date,'%Y-%m-%d') as date, e.timebegin, i.id as instructorid, fname, lname, CONCAT(fname," ",lname) as fullname, pedigree, description as AgendaDescription, CONCAT(DATE_FORMAT(date,'%m-%d'),' @ ',DATE_FORMAT(timebegin,'%H:%i'),' in ',(select roomnumber FROM equip_locations WHERE id = locationid)) as locationTime, bioweb, bioprint, picThumb, picBig, (select roomnumber FROM equip_locations WHERE id = locationid) as room, commentpublic, e.event, c.comment, q.question
			FROM equip_courses c
			LEFT JOIN equip_instructors_courses ic
				ON c.id = ic.equip_coursesId
			LEFT JOIN equip_instructors i
				ON ic.equip_instructorsId = i.id
			LEFT JOIN equip_events e
				ON c.eventid = e.id
			LEFT JOIN equip_locations l
				ON e.locationid = l.id
			LEFT JOIN equip_coursequestions q
				on q.courseid = c.id	
			WHERE c.event = '#arguments.event#'
				AND c.deletedAt IS NULL
				AND i.deletedAt IS NULL
				AND e.deletedAt IS NULL
				AND l.deletedAt IS NULL
				AND display <> "No"
				<cfif arguments.type NEQ "all">
					AND type = "#arguments.type#"
				</cfif>
				<cfif arguments.recorded EQ "yes">
					and recordinglink IS NOT NULL
				</cfif>
				<cfif arguments.courseid && arguments.courseid NEQ 0>
					and c.id = #arguments.courseid#
				</cfif>
			ORDER BY #arguments.order#
		</cfquery>
		<!---cfset loc.data = insertEmptyCourses(loc.data,loc.order)--->
	<cfreturn loc.data>
	</cffunction>

	<cffunction name="insertEmptyCourses" hint="I insert empty events so that the table reports fill out correctly">
	<cfargument name="oldquery" required="true" type="query">
	<cfargument name="orderFields" required="true" type="string">
	<cfset var loc = structNew()>
	<cfset loc = arguments>
	<!---get groupings from orderFields--->
	<cfset loc.firstgroup = listFirst(loc.orderFields)>
	<cfset loc.secondgroup = listLast(loc.orderFields)>

	<!---get a list of distinct value for the first group--->
	<cfset loc.tempquery = reOrderQuery(loc.oldquery,loc.firstgroup)>
	<cfquery dbtype="query" name="loc.firstgroupvalues">
		SELECT distinct #loc.firstgroup#
		FROM loc.tempquery
	</cfquery>
	<cfset loc.firstgroupvalueslist = evaluate("ValueList(loc.firstgroupvalues.#loc.firstgroup#)")>

	<!---get a list of distinct value for the second group--->
	<cfset loc.tempquery = reOrderQuery(loc.oldquery,loc.secondgroup)>
	<cfquery dbtype="query" name="loc.secondgroupvalues">
		SELECT distinct #loc.secondgroup#
		FROM loc.tempquery
	</cfquery>
	<cfset loc.secondgroupvalueslist = evaluate("ValueList(loc.secondgroupvalues.#loc.secondgroup#)")>

	<!--- itirate over the original query and add empty events each grouping combination that does not exist--->
	<cfoutput query="loc.oldquery" group="#loc.firstgroup#">
		<cfoutput group="#loc.secondgroup#">
				<cfloop list="#loc.secondgroupvalueslist#" index="loc.ii">
					<cfquery dbtype="query" name="loc.check" result="loc.result">
						SELECT *
						FROM loc.oldquery
						WHERE #loc.firstgroup# = '#evaluate(loc.firstgroup)#'
						AND #loc.secondgroup# = '#loc.ii#'
					</cfquery>
					<cfif not loc.check.recordcount>

						<!---Add a row for each empty event/room--->
						<cfset loc.temp = queryAddRow(loc.oldquery)>
						<cfset loc.temp = querysetcell(loc.oldquery,'#loc.firstgroup#','#evaluate(loc.firstgroup)#')>
						<cfset loc.temp = querysetcell(loc.oldquery,'#loc.secondgroup#','#loc.ii#')>
						<cfset loc.temp = querysetcell(loc.oldquery,'title','empty')>

					</cfif>
				</cfloop>
		</cfoutput>
	</cfoutput>

	<!---ReSort the query after empter events are added then return--->
	<cfset loc.oldquery = reOrderQuery(loc.oldquery,loc.orderfields)>

	<cfreturn loc.oldquery>
	</cffunction>

	<cffunction name="reOrderQuery" access="private">
	<cfargument name="oldquery" required="true" type="query">
	<cfargument name="orderby" required="true" type="string">
	<cfset var loc = structNew()>
	<cfset loc = arguments>
		<cfquery dbtype="query" name="loc.oldQueryReOrdered">
			SELECT *
			FROM loc.oldquery
			ORDER BY #loc.orderby#
		</cfquery>
	<cfreturn loc.oldQueryReOrdered>
	</cffunction>

	<cffunction name="findAllCourses">
	<cfargument name="params" required="true" type="struct">
		<cfscript>
			var loc= structNew();
			loc = arguments.params;

			if ( !isDefined("params.event") ) { loc.event = getEvent() };

			loc.orderbyString = "title";
			if ( isDefined("loc.orderby") ) { loc.orderbyString = params.orderby };
			
			loc.whereString = "event='#loc.event#'";
			if ( isDefined("loc.type") ) { loc.whereString = loc.whereString & " AND type = '#loc.type#'" };
			if ( isDefined("loc.types") ) { 
				loc.types = commaListToQuoteList(loc.types)
				loc.whereString = loc.whereString & " AND type IN ('#loc.types#')" 
			};
			if ( isDefined("loc.where") ) { loc.whereString & " AND selectName = '#loc.where#'" };

			loc.courses = findAll(where=loc.whereString, include="Agenda", order=loc.orderbyString);
			loc.courses = htmlEditDescriptions(loc.courses);
			return loc.courses;
		</cfscript>
	</cffunction>

	<cffunction name="findAllAsJson">
	<cfargument name="params" required="true" type="struct">
	<cfset var loc= structNew()>
	<cfset loc = arguments.params>
		<cfset loc.courses = findAllCourses(loc)>
		<cfset loc.courses = queryToJson(loc.courses)>
		<cfreturn loc.courses>
	</cffunction>

	<cffunction name="findDecriptionsAsJson">
	<cfargument name="params" required="true" type="struct">
	<cfset var loc= structNew()>
	<cfset loc = arguments.params>
		<cfset loc.courses = findAllCourses(loc)>
		<cfquery dbtype="query" name="loc.data">
			SELECT descriptionlong
			FROM loc.courses
		</cfquery>
		<cfset loc.courses = queryToJson(loc.data)>
		<cfreturn loc.courses>
	</cffunction>

	<cffunction name="htmlEditDescriptions">
	<cfargument name="query" required="true" type="query">
	<cfset var loc= structNew()>
	<cfset loc = arguments>
		<cfloop query="loc.query">
			<cfset descriptionlong = htmlEditFormat(descriptionlong)>
			<cfset descriptionshort = htmlEditFormat(descriptionshort)>
		</cfloop>
	<cfreturn loc.query>
	</cffunction>

	<cffunction name="getCourseDates">
	<cfargument name="type" default="workshop">
	<cfargument name="event"  default="#getEvent()#">
	<cfset var loc = structNew()>
	<cfset loc = arguments>
	<cfset loc.courses = findall(where="event='#arguments.event#' AND type='#arguments.type#'", include="Agenda")>
	<cfset loc.dates = "">
	<cfloop query="loc.courses">
		<cfif not find(dateformat(date,"mm-dd-yy"),loc.dates)>
		<cfset loc.dates = loc.dates & "," & dateformat(date,"mm-dd-yy")>
		</cfif>
	</cfloop>
	<cfset loc.dates = listsort(replace(loc.dates,",","","one"),"text")>
	<cfreturn loc.dates>

	</cffunction>

	<cffunction name="alsoSignedUpFor">
	<cfargument name="courseId" required="true" type="numeric">
	<cfargument name="personId" required="false" type="numeric">
	<cfargument name="type" default="cohort">
	<cfset var loc = arguments>
	<cfset loc.defaultWhereString = "event = '#getEvent()#' AND type='#loc.type#'">
	<cfset loc.titles = "">
		<cfset loc.whereString = loc.defaultWhereString & " AND equip_coursesid=#loc.courseid#">
		<cfset loc.signupForThisCourse = model("Conferenceregistration").findall(where=loc.whereString, include="Course")>
		<cfloop query="loc.signupForThisCourse">
			<cfset loc.whereString = loc.defaultWhereString & " AND equip_peopleid = #equip_peopleid# AND equip_coursesId <> #loc.courseid#">
			<cfset loc.alsoSignedUpForOtherCourses = model("Conferenceregistration").findAll(where=loc.whereString, include="Course")>
			<cfset loc.titles = loc.titles & "," & valueList(loc.alsoSignedUpForOtherCourses.title)>
		</cfloop>
		<cfset loc.titles = removeDuplicatesFromList(loc.titles,",")>
		<cfset loc.titles = replace(loc.titles,",","","one")>
		<cfset loc.titles = replace(loc.titles,",","; ","all")>
		<cfreturn loc.titles>
	</cffunction>

<cfscript>

	private function removeDuplicatesFromList(list,delimiter){
		var i = 0;
		var listitem = "";
		var newlist = "";

		if(!isDefined("delimiter")){delimiter=","};
		for (i=1; i LTE listLen(list,delimiter); i=i+1){
			listItem = listGetAt(list,i,delimiter);
			if (!listFind(newlist,listitem,delimiter)){
				newlist = newlist & delimiter & listitem;
				}
		};
		return newlist;
	}

</cfscript>

</cfcomponent>
