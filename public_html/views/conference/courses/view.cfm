<cfparam name="instructorname" default="Facilitator">

<cfif course.agenda.selectname contains "Risk">
	<cfset instructorname = "Guide">
</cfif>

<div id="courseslist" class="container">
	<cfoutput>#includePartial(partial="showFlash")#</cfoutput>

	<cfoutput>

		<h1>#course.title#</h1>
		<cfif isDefined("subtype") && showSubTypesOfCourses()>
			<p>#subtype#</p>
		</cfif>

		<p class="well">
			#course.descriptionlong#
		</p>

			<cfif isDefined("course.recordinglink") AND len(course.recordinglink)>
			<br/>
				#linkto(text="RECORDED", href=getrecordingurl(course.recordinglink), target="_blank", class="btn btn-warning")#
			</cfif>

		<cfif workshopsEventsAreSet()>
			<p>
				#course.agenda.selectName#
			</p>
		</cfif>

		<cfif len(course.commentPublic)>

			<p class="alert alert-info">
				Instructions: #course.commentPublic#
			</p>

		</cfif>

	<div>

		<cfif showFacilitatorsWithCourse()>

			<cfsavecontent variable="instructorlist">
				<cfoutput query="instructors">
					<li>
						#fname# #lname# <cfif fileExists(expandPath("/images/conference/instructors/#picThumb#"))>#imageTag(source="/conference/instructors/#picThumb#", class="instructorpic")#</cfif><cfif len(bioweb)>- #bioweb#</cfif>
					</li>
					<li class="clearfix">&nbsp;</li>
				</cfoutput>
			</cfsavecontent>
			<div class="facilitators">
				<cfif instructors.recordcount gt 1>
					#pluralize(instructorname)# ...
				<cfelse>
					#instructorname# ...
				</cfif>
				<ul>
					#instructorlist#
				</ul>
			</div>

		</cfif>

		<div>
			<cfoutput query="questions">
				<div class="well">
					<p>#question#</p>
					<p class="text-right postedby">Submitted by #fullname# on #dateformat(createdAt)#</p>
				</div>
			</cfoutput>
		</div>

		<div id="signupstats">
			<cfif course.max GTE 1>
				<p>Maximum for this workshop: #course.max#</p>
			</cfif>
			<cfif course.countsold GTE 5>
				<p>Signed up so far : #course.countsold#</p>
			</cfif>
		</div>

	</div>

	</cfoutput>
</div>