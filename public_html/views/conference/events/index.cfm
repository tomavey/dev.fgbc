<cfparam name="params.key" default=0>
<!---Use this parameter to choose which title this report uses for a workshop - the title is equip_courses or equip_events--->
<cfparam name="titlePreference" default="event">
<cfset alertcolor = "##FFFFFF">
<cfset daySpreadOptions = "1,2,3,5,10,20,30,60,90">

<cfif isDefined("params.key") and val(params.key)>
	  <cfset dateSpread = params.key>
</cfif>


<h1 style="text-align:center">Conference Events</h1>
<cfoutput>
	<cfif gotRights("superadmin,office")>
	<p>#linkTo(text="Add a new event", action="new", title="Add New")#
	</cfif>

	<p>#linkto(href="/images/conference/Fremont_Building_Map_1st_floor.jpg", text="Grace Community Church Fremont Map - 1st Floor", target="_new", class="btn")#</p>

	<p>#linkto(href="/images/conference/Fremont_Building_Map_2nd_floor.jpg", text="Grace Community Church Fremont Map - 2nd Floor", target="_new", class="btn")#</p>

<!---

	<p>#buttonTo(text="View a log of changes", controller="conference.eventlogs", action="index")#
	</p>
--->
	<p>#linkto(text="Download as Excel Spreadsheet", action="excel", controller="conference.events")#
	</p>
</cfoutput>

<p id="filters">
See only:
	<cfoutput>
		<cfloop list="#eventCategories()#" index="i">
			#linkTo(text=i, action="index", params="category=#i#")# &nbsp;
		</cfloop>
		#linkTo(text="All", action="index", params="category=all")# &nbsp;
	</cfoutput>
	<p>&nbsp;</p>
</p>

<div class="eachItemShown">

	<cfset tableclass="table table-hover">

	<table class="<cfoutput>#tableclass#</cfoutput>">
		<thead>
			<tr>
				<th>Event</th>
				<th>Category</th>
				<th>Setup/Equipment</th>
				<th>Updated</th>
				<th>Location</th>
				<th>Begins</th>
				<th>Ends</th>
				<th>Att</th>
				<th>&nbsp;</th>
			</tr>
		</thead>

		<tbody>
			<cfoutput query="events" group="eventDate">

					<tr>
						<td colspan="9"><hr/></td>
					</tr>
					<tr>
						<cfset text = "#dateformat(date,"mmm-dd")# (#left(weekday(date),3)#)">"
						<cfif isDefined("params.category")>
						<td colspan="9">
							<h1>
								#linkto(text=text, params="category=#params.category#&date=#dateformat(date,"yyyy-mm-dd")#")#
							</h1>
						</td>
						<cfelse>
						<td colspan="9">
							<h1>
								#dateformat(date,"mmm-dd")# (#left(weekday(date),3)#)
							</h1>
						</td>
						</cfif>
					</tr>
				<cfoutput>

        			<cfif dateDiff("d",createdAt,now()) LT val(params.key) OR dateDiff("d",updatedAt,now()) LT val(params.key)>
        				  <cfset alertcolor = "##FFC1E0">
					<cfelse>
        				  <cfset alertcolor = "##FFFFFF">
        			</cfif>

					<tr style="background-color:#alertcolor#">
						<td>#linkTo(text='#left(getWorshipTitleForEvent(id,description,titlePreference),30)#', action='index', params="desc=#left(getWorshipTitleForEvent(id,description,titlePreference),30)#")# <cfif len(beo)>[#beo#]</cfif></td>
						<td>#left(category,15)#</td>
						<td>
							<cfif len(setup)>
								#left(setup,40)#
							<cfelse>
								#left(defaultsetup,40)#*
							</cfif>
							  #left(equipment,40)#
							</td>
						<td class="more">#dateformat(updatedAt)#</td>
						<td><cftry>
							#linkto(text=roomnumber, controller="conference.locations", action="show", key=locationid)#<cfcatch>-</cfcatch></cftry>
						</td>
						<td>#timeformat(timebegin)#</td>
						<td>#timeformat(timeend)#</td>
						<td>#attending#</td>
						<td>
								#showTag()# &nbsp;
							<cfif gotRights("superadmin,office")>
								#editTag()# &nbsp;
								#deleteTag(class="noajax")# &nbsp;
								#copyTag()#
							</cfif>
						</td>
					</tr>
				</cfoutput>
			</cfoutput>
		</tbody>
	</table>
	<p>* = using default setup for this room</p>

	</div>
	<cfoutput>
		<p>#addTag()#</p>
		<cfif isDefined("params.category") and isDefined("params.date")>
			#linkTo(text="Copy this category to the next day", controller="conference.events", action="copyCategoryToNextDay", params="category=#params.category#&date=#params.date#", class="btn")#<br/>
			#linkTo(text="Delete this category on this day", controller="conference.events", action="deleteCategoryOnDay", params="category=#params.category#&date=#params.date#", confirm="Are you sure!!?", class="btn")#
		</cfif>
		<p>Count: #events.recordcount#</p>
	</cfoutput>
