<div id="seminars">

<h1>Integrated Ministries - Monday</h1>
<cfoutput query="MondayIM">
	#includePartial(partial="seminars")#
</cfoutput>

<h1>Integrated Ministries - Tuesday</h1>
<cfoutput query="TuesdayIM">
	#includePartial(partial="seminars")#
</cfoutput>

<h1>Leadership Development - Monday</h1>
<cfoutput query="MondayLD">
	#includePartial(partial="seminars")#
</cfoutput>

<h1>Leadership Development - Tuesday</h1>
<cfoutput query="TuesdayLD">
	#includePartial(partial="seminars")#
</cfoutput>

<h1>Ministry Tracks - Monday</h1>
<cfoutput query="MondayMT">
	#includePartial(partial="seminars")#
</cfoutput>

<h1>Ministry Tracks - Tuesday</h1>
<cfoutput query="TuesdayMT">
	#includePartial(partial="seminars")#
</cfoutput>

<h1>Network Meetings - Monday</h1>
<cfoutput query="MondayNet">
	#includePartial(partial="seminars")#
</cfoutput>

<h1>Network Meetings - Tuesday</h1>
<cfoutput query="TuesdayNet">
	#includePartial(partial="seminars")#
</cfoutput>
</div>