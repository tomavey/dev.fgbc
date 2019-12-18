<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset table("equip_events")>

		<cfset belongsTo(name="location", modelName="Conferencelocation", foreignKey="locationid", joinType="outer")>

		<cfset belongsTo(name="course", modelName="Conferencecourse", foreignKey="courseid", joinType="outer")>

		<cfset hasMany(name="Courses", modelName="Conferencecourse", foreignKey="courseId")>

		<cfset hasMany(name="Instructors", modelName="Conferenceeventinstructor", foreignKey="instructorID")>

		<cfset belongsTo(name="Option", modelName="Conferenceoption", foreignKey="eventId", joinType="outer")>

		<cfset property(
			name="eventRoom",
			sql="select roomnumber FROM equip_locations WHERE id = locationid"
			)>

		<cfset property(
			name="map",
			sql="select map FROM equip_locations WHERE id = locationid"
			)>

		<cfset property(
			name="selectName",
			sql="CONCAT(equip_events.description,': ',DATE_FORMAT(date,'%m-%d'),' @ ',DATE_FORMAT(timebegin,'%H:%i'),' in ',(select roomnumber FROM equip_locations WHERE id = locationid))"
			)>

		<cfset property(
			name="selectNameId",
			sql="CONCAT(equip_events.description,'(',equip_events.id,')',': ',DATE_FORMAT(date,'%m-%d'),' @ ',DATE_FORMAT(timebegin,'%H:%i'),' in ',(select roomnumber FROM equip_locations WHERE id = locationid))"
			)>

		<cfset property(
			name="eventDate",
			sql="DATE_FORMAT(date,'%m-%d-%y')"
			)>

		<cfset property(
			name="eventDay",
			sql="DAYNAME(date)"
			)>

		<cfset property(
			name="starttime",
			sql="DATE_FORMAT(equip_events.timebegin,'%h:%i %p')"
			)>

		<cfset property(
			name="endtime",
			sql="DATE_FORMAT(equip_events.timeend,'%h:%i %p')"
			)>

		<cfset property(
			name="dateOn",
			sql="DATE_FORMAT(equip_events.timebegin,'%a, %b %d, %Y')"
			)>

		<cfset property(
			name="dayOn",
			sql="DATE_FORMAT(equip_events.date,'%W')"
			)>

		<cfset property(
			name="dayOfYear",
			sql="DATE_FORMAT(equip_events.date,'%j')"
			)>

		<cfset property(
			name="dayOfWeek",
			sql="DATE_FORMAT(equip_events.date,'%w')"
			)>


		<cfset property(
			name="optiondescription",
			sql="select description from equip_options o where o.id = equip_events.eventid"
			)>

		<cfset property(
			name="buttondescription",
			sql="select buttondescription from equip_options o where o.id = equip_events.eventid"
			)>

		<cfset property(
			name="coursedescription",
			sql="select descriptionlong from equip_courses c where c.eventid = equip_events.id AND deletedAt IS NULL  LIMIT 1"
			)>

		<cfset property(
			name="coursetitle",
			sql="select title from equip_courses c where c.eventid = equip_events.id  AND deletedAt IS NULL LIMIT 1"
			)>

		<cfset property(
			name="commentpublic",
			sql="select commentpublic from equip_courses c where c.eventid = equip_events.id  AND deletedAt IS NULL LIMIT 1"
			)>

		<cfset afterUpdate("logUpdates")>
		<cfset afterCreate("logCreates")>
		<cfset afterDelete("logDeletes")>

	</cffunction>

	<!---CallBack Functions--->
	<cffunction name="logUpdates">
	<cfargument name="modelName" default="Conferenceevent">
	<cfargument name="createdBy" default="tomavey@fgbc.org">

		<cfset old = model("#arguments.modelName#").findByKey(key=this.id)>
		<cfset new = this>
		<cfset skipCreate = false>
		<cfset changes= new.changedProperties()>
		<cfoutput>
		<cfloop list="#changes#" index="i">
			<cfif not i is "updatedAt">
				<cfset newupdate.modelName = arguments.modelName>
				<cfset newupdate.recordId = this.id>
				<cfset newupdate.columnName = i>
				<cfset newupdate.datatype = "update">
				<cfset newupdate.olddata = old[i]>
				<cfset newupdate.newData = new[i]>
				<cfset newupdate.createdBy = "#arguments.createdBy#">

				<cftry>
					<cfif hour(newupdate.olddata) is hour(newupdate.newData) AND minute(newupdate.olddata) is minute(newupdate.newData)>
     					<cfset skipCreate = true>
					</cfif>
				<cfcatch></cfcatch></cftry>

				<cfif not skipCreate>
     				<cfset update = model("Conferenceeventlog").create(newupdate)>
				</cfif>

			</cfif>
		</cfloop>
		</cfoutput>
		<cfreturn true>
	</cffunction>

	<cffunction name="logCreates">
	<cfargument name="modelName" default="Event">
	<cfargument name="createdBy" default="tomavey@fgbc.org">

		<cfset newSave.modelName = arguments.modelName>
		<cfset newSave.recordId = this.id>
		<cfset newSave.datatype = "new">
		<cfset newSave.createdBy = "#arguments.createdBy#">
		<cfset update = model("Conferenceeventlog").create(newSave)>

		<cfreturn true>

	</cffunction>


	<cffunction name="logDeletes">
	<cfargument name="modelName" default="Event">
	<cfargument name="olddata" default="NA">
	<cfargument name="createdBy" default="tomavey@fgbc.org">

		<cfset person = model("#arguments.modelName#").findByKey(key=this.id)>

		<cfset newSave.modelName = arguments.modelName>
		<cfset newSave.recordId = this.id>
		<cfset newSave.datatype = "deleted">
		<cfset newSave.olddata = arguments.olddata>
		<cfset newSave.createdBy = arguments.createdBy>
		<cfset update = model("Conferenceeventlog").create(newSave)>

	</cffunction>

	<cffunction name="findScheduleAsJson">
	<cfargument name="params" required="true" type="struct">
	<cfargument name="useExcursions" default="false">
	<cfargument name="useOtherEvents" default="false">
	<cfset var loc = structNew()>
	<cfset loc = arguments.params>
		<cfset loc.whereString = "category in (#getSetting('eventCategoriesForJson')#) AND event = '#getEvent(params)#'">
		<cfset loc.orderString = "dayofyear,timebegin">
		<cfset loc.selectString = "id,starttime,timebegin,endtime,timeend,eventroom,description,descriptionschedule,dateOn,dayOn,dayofyear,dayOfWeek,category,cost,link,image">
		<cfset loc.selectString = loc.selectString & ",buttondescription,optiondescription,commentpublic,eventid">

		<cfif isDefined('params.useOtherEvents') && params.useOtherEvents>
			<cfset loc.whereString = "category = 'Other' AND event = '#getEvent()#'">
		</cfif>

		<cfif isDefined('params.useExcursions') && params.useExcursions>
			<cfset loc.whereString = "category = 'excursion' AND event = '#getEvent()#'">
		</cfif>

		<cfif isDefined("loc.id")>
			<cfset loc.whereString = loc.whereString & " AND id = #loc.id#">
		</cfif>

		<cfif isDefined("loc.type")>
			<cfset loc.whereString = loc.whereString & " AND category='#loc.type#'">
		</cfif>
		<cfset loc.schedule = findAll(select=loc.selectString, where=loc.whereString, order=loc.orderString)>
		<cfset loc.schedule = selectDescriptionForPublicSchedule(loc.schedule)>
		<cfset loc.schedule = queryToJson(loc.schedule)>
	<cfreturn loc.schedule>
	</cffunction>

<cfscript>

	function selectDescriptionForPublicSchedule(required query schedule){
		var useThisDescription = ""
		for ( event in schedule ) {
			if ( len(event.optiondescription) ) {
				useThisDescription = event.optiondescription
			} else {
				useThisDescription = event.descriptionschedule
			}
			querySetCell(arguments.schedule,"optiondescription", useThisDescription, schedule.currentrow)
		}
		return arguments.schedule
	}

</cfscript>
	
	
	<cffunction name="findInstructors">
	<cfargument name="eventid" required="true" type="numeric">
	<cfset var instructors = "">
	<cfquery datasource="#application.wheels.dataSourceName#" name="instructors">
		SELECT *
		FROM equip_events_instructors e
		LEFT JOIN equip_instructors i
		ON i.id = e.instructorid
		WHERE e.eventid = #eventid#
		AND e.deletedAt IS NULL
	</cfquery>
	<cfreturn instructors>
	</cffunction>

</cfcomponent>
