<cffunction name="weekday">
<cfargument name="date" required="true">
<cfset var weekdayname = "">
<cftry>
	<cfset weekdayname = dayofweekasstring(dayOfWeek(arguments.date))>
<cfcatch><cfset weekdayname="NA"></cfcatch></cftry>	
<cfreturn weekdayname>	
</cffunction>