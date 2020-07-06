<cffunction name="weekday">
<cfargument name="date" required="true">
<cfset var weekdayname = "">
	<cfset weekdayname = dayofweekasstring(dayOfWeek(arguments.date))>
<cfreturn weekdayname>	
</cffunction>