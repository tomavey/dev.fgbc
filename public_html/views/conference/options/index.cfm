<cfparam name="event" default='#getEvent()#'>
<cfparam name="previousEvent" default="#getSetting('previousEvent')#">

<cfoutput>

<cfif isDefined("params.event")>
	<h2>Options for #params.event#</h2>
<cfelse>
	<h2>Options for #getEvent()#</h2>
</cfif>

	<cfloop list="#application.wheels.typeOfOptions#" index="i">
		<cfif isDefined("params.event")>
			#linkTo(text=i, controller="conference.options", action="index", params="type=#i#&event=#params.event#")# |
		<cfelse>
			#linkTo(text=i, controller="conference.options", action="index", params="type=#i#")# |
		</cfif>
	</cfloop>

</cfoutput>

<div class="eachItemShown">

<cfoutput>
	<p class="addnew">#linkTo(text="#imageTag('add-icon.png')#", action="new", title="Add New")#</p>


</cfoutput>

<cftable query="options" colHeaders="true" HTMLTable="true">

					<cfcol header="Id" text="#Id#" />

					<cfcol header="Name" text="#name# <cfif len(description)><span>#description#</span></cfif>" />

					<cfcol header="Event" text="#event#" />

					<cfcol header="Button Description" text="#buttondescription# <cfif len(ad)><span>#description#</span></cfif>" />

					<cfcol header="Cost" text="#cost#" />

					<cfcol header="Type" text="#type#" />

					<cfcol header="Max" text="#maxtosell#" />

					<cfcol header="Sortorder" text="#sortorder#" />

<!---					<cfcol header="Row" text="#getPreviousItem(id)#" />--->

					<cfcol header="Updated" text="#dateformat(updatedat, 'medium')#" />

	<cfcol header="" text="#showTag()#" />
	<cfcol header="" text="#editTag()#" />
	<cfcol header="" text="#deleteTag(class="notajax")#" />
	<cfcol header="" text="#copyTag()#" />
</cftable>

<cfoutput>
	<p class="addnew">#linkTo(text="#imageTag('add-icon.png')#", action="new", title="Add New")#</p>
	<p>Show options for: #linkTo(text='#event#', params="event=#event#")#&nbsp;#linkTo(text=previousEvent, params="event=#previousEvent#")#</p>
	<cfif isDefined("params.key")>
	<p>#linkTo(text="List name and description", controller="conference.options", action="list", params="type=meal")#</p>
	</cfif>
	<cfif isDefined("params.type") && params.type is "meal">
		#linkto(text="show meals as a list", controller="conference.options", action="list", params="type=meal")#
	</cfif>
</cfoutput>
</div>
