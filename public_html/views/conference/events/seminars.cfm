<div id="seminars">

<h1>Integrated Ministries - Monday</h1>
<cfoutput query="MondayIM">
	#includePartial("seminars")#
</cfoutput>

<h1>Integrated Ministries - Tuesday</h1>
<cfoutput query="TuesdayIM">
	#includePartial("seminars")#
</cfoutput>

<h1>Leadership Development - Monday</h1>
<cfoutput query="MondayLD">
	#includePartial("seminars")#
</cfoutput>

<h1>Leadership Development - Tuesday</h1>
<cfoutput query="TuesdayLD">
	#includePartial("seminars")#
</cfoutput>

<h1>Ministry Tracks - Monday</h1>
<cfoutput query="MondayMT">
	#includePartial("seminars")#
</cfoutput>

<h1>Ministry Tracks - Tuesday</h1>
<cfoutput query="TuesdayMT">
	#includePartial("seminars")#
</cfoutput>

<h1>Network Meetings - Monday</h1>
<cfoutput query="MondayNet">
	#includePartial("seminars")#
</cfoutput>

<h1>Network Meetings - Tuesday</h1>
<cfoutput query="TuesdayNet">
	#includePartial("seminars")#
</cfoutput>
</div>