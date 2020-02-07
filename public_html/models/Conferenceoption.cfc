<cfcomponent extends="Model" output="false">

	<cffunction name="init">
		<cfset table("equip_options")>

		<cfset hasMany(name="registrations", modelName="Conferenceregistration")>

		<cfset hasOne(name="event", modelName="Conferenceevent", foreignKey="eventid", joinType="left")>

		<cfset property(name="countSold", SQL="maxtosell")>

<!---not sure I need this and it removes links from option descriptions
		<cfset beforeSave("htmlEdit")>
--->

	</cffunction>

	<cffunction name="findAllOptions">
	<cfargument name="type" default="meal">
	<cfargument name="listOfMealIds" required="false">
	<cfargument name="event" default="#getEvent()#">
	<cfset var loc = structNew()>
	<cfset loc = arguments>

	<cfset loc.whereString="type='#arguments.type#' AND event='#arguments.event#'">

	<cfif isDefined("loc.listOfMealIds")>
		<cfset loc.whereString = loc.whereString & " AND id IN (#loc.listOfMealIds#)">
	</cfif>

	<cfset loc.return = findall(where=loc.whereString, order="sortorder")>
	<cfloop query="loc.return">
		<cfset loc.regs = model("Conferenceregistration").findall(where="equip_optionsid = #id#")>
		<cfset loc.count = 0>
		<cfloop query="loc.regs">
			<cfset loc.count = loc.count + val(quantity)>
		</cfloop>
		<cfset querySetCell(loc.return,"countSold",loc.count,currentRow)>
	</cfloop>

	<cfreturn loc.return>
	</cffunction>

	<cffunction name="findMealsAsJson">
	<cfargument name="params" required="true" type="struct">
	<cfset var loc = structNew()>
	<cfset loc = arguments.params>
	<cfset loc.whereString = 'type="meal" AND o.event = "#getEvent()#"'>
	<cfset loc.orderString = 'sortorder'>
	<cfif isDefined("loc.id")>
		<cfset loc.whereString = loc.whereString & " AND o.id = #loc.id#">
	</cfif>
		<cfquery dataSource="#getDataSource()#" name="loc.options">
			SELECT o.id,o.buttondescription,o.description, o.cost, l.roomnumber, e.timebegin, DATE_FORMAT(e.timebegin,'%h:%i %p') AS starttime, '' AS TimeDateLocationString
			FROM equip_options o
			JOIN equip_events e
			ON e.eventid = o.id
			JOIN equip_locations l
			ON e.locationid = l.id
			WHERE #loc.wherestring#
			AND o.deletedAt IS NULL
			ORDER BY #loc.orderString#
		</cfquery>

		<cfset loc.options = queryMap(loc.options, function(obj){
			obj.TimeDateLocationString = mealsTimeDateLocationString(obj.STARTTIME, obj.TIMEBEGIN, obj.ROOMNUMBER )
			return obj
		})>

	<cfreturn loc.options>
	</cffunction>

<cfscript>

	private function mealsTimeDateLocationString (required string timeStr, string dateStr, required string location) {
		return timeFormat(timeStr,"short") & " - " & location
	}

</cfscript>


</cfcomponent>
<!---
				DATE_FORMAT(e.timebegin,'%h:%i %p') as starttime,
				DATE_FORMAT(e.date,'%W') as dayOn,
				DATE_FORMAT(e.timebegin,'%a, %b %d, %Y') as dateOn,
				DATE_FORMAT(e.date,'%j') as dayOfYear
			ORDER BY dayofyear, starttime
--->