<h1>Listing Event/instructor links:</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>
	<p>#linkTo(text="New event/instructor link", action="new")#</p>
</cfoutput>

<div class="table">
<cftable query="eventinstructors" colHeaders="true" HTMLTable="true">



					<cfcol header="Event" text="#getEventName(eventID)#" />

					<cfcol header="Instructor" text="#getInstructorLName(instructorID)#" />

					<cfcol header="Created" text="#dateformat(createdAt)#" />



	<cfcol header="" text="#linkTo(text='Show', action='show', key=ID)#" />
	<cfcol header="" text="#linkTo(text='Edit', action='edit', key=ID)#" />
	<cfcol header="" text="#linkTo(text='Delete', action='delete', key=ID, confirm='Are you sure?')#" />
</cftable>

</div>