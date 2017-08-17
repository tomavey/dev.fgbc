<h1>Showing event</h1>
<cfoutput>
<div class="eachItemShown #params.action#">

					<p><span>Description: </span>
						#event.description#</p>

				<cfset workshoptitle = 	getWorshipTitleForEvent(params.key,event.description)>
				<cfif workshoptitle NEQ event.description>
					<p><span>Workshop: </span>
						#getWorshipTitleForEvent(params.key,event.description)#</p>
				</cfif>

					<p><span>Description for schedule: </span>
						#event.descriptionschedule#</p>

					<p><span>Program Description: </span>
						#event.descriptionprogram#</p>

				<cfif len(event.course.title)>			
					<p><span>Course Title and Description: </span>
						<p style="margin-left:10px">#linkto(text="<b>#event.course.title#</b>: #event.course.descriptionlong#</p>", controller="conference.courses", action="show", key=event.course.id, target="_new")#
					</p>
				</cfif>		

					<p><span>Category: </span>
						#event.category#</p>

					<p><span>Manager: </span>
						#event.manager#</p>

					<p><span>Location: </span>
						#event.locationid#</p>

					<p><span>Registration Option:</span>
						<cfif val(event.eventid)>
							#linkto(text=event.eventId, controller="conference.options", action="show", key=event.eventid)#</p>
						<cfelse>
							n/a
						</cfif>
					<p><span>Date: </span>
						#weekday(event.date)# - #dateformat(event.date)#</p>

					<p><span>Begins: </span>
						#timeformat(event.timebegin)#</p>

					<p><span>Ends: </span>
						#timeformat(event.timeend)#</p>

					<p><span>Expected Attendance: </span>
						#event.attending#</p>

					<p><span>Equipment: </span> <br />
						#event.equipment#</p>

					<p><span>Setup: </span> <br />
						#event.setup#</p>

					<p><span>Comment: </span> <br />
						#event.comment#</p>

					<p><span>Created: </span>
						#dateformat(event.createdAt)#</p>

					<p><span>Updated: </span>
						#dateformat(event.updatedAt)#</p>


#linkToList(text="Return to the listing", action="index")#<br/>
#linkTo(text="Link to instructor", controller="conference.eventinstructors", action="new", params="eventid=#params.key#")#
<cfif isDefined("session.vision2020admin") and session.vision2020Admin>
	| #linkTo(text="Edit this event", action="edit", key=event.id)#
</cfif>
<cfif instructors.recordcount>
	<p>
		Instructors connected to this event:
		<cfloop query="instructors">
			#fname# #lname# - #linkto(text="x", controller="conference.eventinstructors", action="delete", key=id)#;&nbsp;
		</cfloop>
	</p>
</cfif>
</div>
</cfoutput>
