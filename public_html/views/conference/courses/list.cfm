<cfparam name="instructorname" default="Facilitator">
<cfparam name="showQuestionsPostLink" default=false>
<cfif isDefined("params.showquestions") || isDefined("params.showall")>
	<cfset questionsClass = "xquestions">
	<cfset showQuestionsLink = false>
<cfelse>
	<cfset questionsClass = "questions">
	<cfset showQuestionsLink = true>
</cfif>	

<div id="courseslist" class="container">
<div id="tabletabs">
	<cfoutput>
	<!---
		<cfif !isdefined("params.recorded")>
			#linkto(text="View as a table", action="table", key="workshop", class="btn")#<p>&nbsp;</p>
		</cfif>
	--->	
		<cfif (isDefined("params.type") and params.type is "excursion") or (isDefined("params.key") and params.key is "excursion")>
			<cfset instructorname = "Guide">
			#includePartial("riscursions")#
		<cfelseif (isDefined("params.type") and params.type is "workshop") or (isDefined("params.key") and params.key is "workshop")>
			#includePartial("workshops")#
		<cfelseif (isDefined("params.type") && params.type is "cohort")	or (isDefined("params.key") and params.key is "cohort")>
			#includePartial("cohorts")#
		</cfif>
	</cfoutput>
</div>	

<cfoutput query="courses" group="date">
	<cfif workshopsEventsAreSet()>
		<p>&nbsp;</p>
		<h2 class="well">#dayOfWeekasString(dayOfWeek(date))# (#dateFormat(date,"mmmm/dd")#)</h2>
	<cfelse>
	</cfif>

	<cfoutput group="title">
		<cfif title NEQ "empty">
			<div class="eachworkshop">
				<h3>#linkto(text=title, action="view", key=id)#</h3>
					<cfif isDefined("subtype") && showSubTypesOfCourses()>
						<cfif len(subtype)>
						<p class="subtype">#subtypes[subtype]#</p>
						</cfif>
					</cfif>
						<cfset description = descriptionlong>
					<cfelse>
						<cfset description = descriptionshort>
					</cfif>

				<p class="workshopdescription">
					#description#
				</p>
				<cftry>
				<p class="subtypedesc alert">
					#getSubtypeDesc(subtype)#
				</p>
				<cfcatch></cfcatch></cftry>

				<cfif isDefined("recordinglink") AND len(recordinglink)>

					<br/>
					#linkto(text="RECORDED", href=getrecordingurl(recordinglink), target="_blank", class="btn btn-warning")#
				</cfif>

				<cfif workshopsEventsAreSet()>
					<p class="workshoptime">
						#locationtime#
					</p>
				</cfif>

				<cfif showQuestionsLink>	
				<p class="questionlinks">
					<cfif showQuestionsPostLink>
						#linkTo(text="Post a question", controller="conference.coursequestions", action="new", params="courseid=#id#", class="btn")# 
					</cfif>	
					#linkTo(text="View all the questions", href="##", class="btn showQuestions")#
					#linkto(text="Sign Up", route="conferenceCoursesSelectpersonToSelectcohorts", params="type=cohort", class="btn")#
				</p>
				</cfif>

				<cfif gotRights("superadmin,office,pageEditor")>
					<br/>
					<p class="controls">
					#linkto(text="edit", controller="conference.courses", action="edit", key=id)# | #linkto(text="show", controller="conference.courses", action="show", key=id)#
					</p>
				</cfif>

		<cfif showFacilitatorsWithCourse()>	

			<cfset instructors = "">
			<cfset count = 0>
				<cfoutput>
					<cfset imageFile = "/images/conference/instructors/#picThumb#">
						<cfif len(bioweb) && len(picThumb) && fileExists(expandPath("/images/conference/instructors/#picThumb#"))>
							<cfset instructors = instructors & '<li>' & #imageTag(source="/conference/instructors/#picThumb#", class="instructorpic")# & #pedigree# & ' ' & #fullname# & ': ' & #bioweb# & #editInstructorLink(instructorid)# & '</li><li class="clearfix">&nbsp;</li>'>
						<cfelseif len(bioweb) && len(picThumb)>
							<cfset instructors = instructors & '<li>' & #imageTag(source="/conference/instructors/imagemissing.jpg", class="instructorpic")# & #pedigree# & ' ' & #fullname# & ': ' & #bioweb# & #editInstructorLink(instructorid)# & '</li><li class="clearfix">&nbsp;</li>'>
						<cfelseif len(bioweb)>
							<cfset instructors = instructors & '<li>' & #pedigree# & ' ' & #fullname# & ': ' & #bioweb# & #editInstructorLink(instructorid)# & '</li>'>
						<cfelse>
							<cfset instructors = instructors & '<li>' & #pedigree# & ' ' & #fullname# & #editInstructorLink(instructorid)# & '</li>'>
						</cfif>
						<cfif len(fullname)>
							<cfset count = count +1>
						</cfif>
					</cfoutput>

				<cfif count EQ 0>
					<div class="facilitators">&nbsp;
				<cfelseif count EQ 1>
					<div class="facilitators">#instructorname# ...
				<cfelse>
					<div class="facilitators">#pluralize(instructorname)#...
				</cfif>
				<cfif count><!---So that the <li> does not even show if no facilitators--->
					<ul>
						<li>#instructors#</li>
					</ul>
				</cfif>	
				</div>
		</cfif>

			<cfif len(commentpublic)>
				<div class="moreinstructions">
					#linkto(text="additional instructions", action="view", key=id, class="btn btn-block")#
				</div>
			</cfif>

			<div class="#questionsClass#">
				<p class="questionsheader well" id="questionsheader">These questions have been posted by folks who have signed up for this cohort.<br/>Cohort facilitators will use these questions and others for discussion starters by the group.</p>
				<cfset questionscounter = 1>
				<cfset maxCount = 10>
				<cfoutput>
					<cfif questionscounter LTE maxcount>
					<p>#question#</p>
					</cfif>
					<cfset questionscounter = questionscounter + 1>
				</cfoutput>
				<cfif questionscounter EQ 2>
					<p>No questions Yet</p>
				</cfif>
				<cfif questionscounter GT maxcount>
					#Linkto(text="View more questions", action="view", key=id, class="btn")#
				</cfif>
				<!---Not working
				<cfif 1 eq 2>
					<script>
						document.getElementById("questionsheader").innerHTML = "No Questions have been posted yet!";				
					</script>
				</cfif>
				--->
			</div>

		</div>
	<hr/>
	</cfif>
	</cfoutput>
</cfoutput>
</div>
