<cfoutput>

<cfif isDefined("params.type")>
	<h1>Listing #pluralize(params.type)#</h1>
<cfelse>
<h1>Listing #nameForCourses()#</h1>
</cfif>

<p>
	Filter this list: #linkto(text="Cohorts", params="type=cohort")# |
	#linkto(text="Workshops", params="type=workshop")# | #linkto(text="Excursions", params="type=excursion")# | #linkto(text="All", params="")#
</p>

<p>
	Public lists: 
	<cfif isDefined("params.type")>
		#linkto(text="json for #pluralize(params.type)#", controller="conference.courses", action="json", params="type=#params.type#")#
	<cfelse>
		#linkto(text="json", controller="conference.courses", action="json")#
	</cfif>

	| #linkto(text="Cohorts", route="conferenceCoursesList",params="type=cohort", target="_new")# | #linkto(text="Workshops", route="conferenceCoursesList", params="type=workshop", target="_new")# | #linkto(text="Excursions", route="conferenceCoursesList", params="type=excursion", target="_new")#
</p>

<p>
	Lists for print: #linkto(text="Cohorts", controller='conference.courses', action="list", params="type=cohort&print=")# | #linkto(text="Workshops", action="list", params="type=workshop&print=")# | #linkto(text="Excursions", action="list", params="type=excursion&print=")#
</p>

#includePartial(partial="showFlash")#

<cfif gotRights("superadmin,office")>
	<p>#linkTo(text="NEW", action="new", class="btn")#</p>
</cfif>

</cfoutput>
<div class="table courses">

<!--- <cfdump var="#courses#">	 --->


<cftable query="courses" colHeaders="true" HTMLTable="true">



					<cfcol header="#linkto(text='Title', controller='conference.courses', action='index', params='orderby=title')#" text="#linkto(text=title, controller='conference.courses', action="show", key=id)#" />

					<cfcol header="#linkto(text='Event', controller='conference.courses', action='index', params='orderby=selectName')#" text="#linkTo(text=selectName, controller='conference.courses', action='index', params="where=#selectname#")#" />

					<cfcol header="Comment/Audio file" text="#left(comment,50)# #getRecordingLink(recordinglink)#<span class='popup'>#comment#</span>" />

					<cfcol header="Description" text="#descriptionlong#" />

					<cfcol header="#linkto(text='Type', controller='conference.courses', action='index', params='orderby=subtype')#" text="#subtype#" />

					<cfcol header="Instructors" text="#getInstructorNamesAsString(id)# #linkto(text='+', controller='conference.courseinstructors', action='new', params='courseid=#id#')#" />

					<cfcol header="Count" text="#countsold#" />

					<cfcol header="Max" text="#max#" />

					<cfcol header="#linkto(text='Track', controller='conference.courses', action='index', params='orderby=track')#" text="#track#" />

					<cfcol header="Display?" text="#display#" />

<cfif gotRights("superadmin,office")>
	<cfcol header="" text="#showTag()#" />
	<cfcol header="" text="#editTag()#" />
	<cfcol header="" text="#deleteTag()#" />
	<cfcol header="" text="#copyTag()#" />
</cfif>

</cftable>
<cfoutput>
<p>Count = #courses.recordcount#</p>
<!--- <p>#linkto(text="Duplicate #getPreviousEvent()# courses into #getEvent()#.", action="conference.courses", action="copyAllToCurrentEvent", class="btn pull-right")#</p> --->
</cfoutput>
</div>
