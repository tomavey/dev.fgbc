<cfparam name="showbuttons" default="true">

<cfoutput>

<h1>#getQuestion("showheader")# #membershipapplication.name_of_church#</h1>

#includePartial("showFlash")#

<cfif not isDefined("params.doc") AND showButtons>
	33#linkTo(text=trim(striptags(getQuestion('uploadedlink'))), controller="membership.resources", action="index", key=params.key, class="btn")#

	#linkTo(text=trim(striptags(getQuestion('editlink'))), action="edit", key=getKey(), class="btn")#
</cfif>

</cfoutput>

<cfoutput>

	#linkto(text="<i class='icon-download-alt'></i>", key=params.key, params="doc=true", class="btn download tooltip2", title="Download this application")#


	<div class="well">
					<p>#membershipapplication.name_of_church#</p>

					<p>#membershipapplication.mailing_address#<br/>
						#membershipapplication.city#, #getState(membershipapplication.stateid)# #membershipapplication.zip#<br/
						#membershipapplication.country#
					</p>

					<p>#membershipapplication.phone#<br/>
						#mailto(membershipapplication.email)#
					</p>

					<p><span>#getQuestion("meeting_place","noTags")#: </span>
						#membershipapplication.meeting_place#</p>

					<p><span>#getQuestion("web_site","noTags")#: </span>
						<cfif NOT find("http://",membershipapplication.web_site)>
							<cfset membershipapplication.web_site = "http://" & membershipapplication.web_site>
						</cfif>
						#linkto(text=membershipapplication.web_site, href=membershipapplication.web_site)#</p>

					<p><span>#getQuestion("incorporated","noTags")#: </span>
						#membershipapplication.incorporated#</p>

					<p><span>#getQuestion("insurance","noTags")#</span>
						#membershipapplication.insurance#</p>
	</div>

	<div class="well">

					<p><span>#getQuestion("principle_leader","noTags")#: </span>
						#membershipapplication.principle_leader#</p>

					<p>#membershipapplication.leader_address#<br/>
						#membershipapplication.leader_city#, #getState(membershipapplication.leader_stateId)# #membershipapplication.leader_zip#
					</p>

					<p>#membershipapplication.leader_phone#<br/>
						#membershipapplication.leader_email#
					</p>

	</div>

					<p><span>#getQuestion("Officers")#</span>
					<div class="well">#membershipapplication.officers#</div>

	<div>
					<p><span>#getQuestion("definition_of_a_church")#</p>
					<div class="well">#membershipapplication.definition_of_a_church#</div>

					<p><span>#getQuestion("history")#</p>
					<div class="well">#membershipapplication.history#</div>

					<p><span>#getQuestion("Strategic_plans")#</p>
					<div class="well">#membershipapplication.strategic_plans#</div>

					<p><span>#getQuestion("Questions_history")#</p>
					<div class="well">#membershipapplication.questions_history#</div>

					<p><span>#getQuestion("Relationship")#</p>
					<div class="well">#membershipapplication.relationship#</div>

					<p><span>#getQuestion("Cooperation")#</p>
					<div class="well">#membershipapplication.cooperation#</div>

					<p><span>#getQuestion("Why_membership")#</p>
					<div class="well">#membershipapplication.why_membership#</div>

					<p><span>#getQuestion("Questions_constitution")#</p>
					<div class="well">#membershipapplication.questions_constitution#</div>

					<p><span>#getQuestion("Statement_of_faith")#</p>
					<div class="well">#membershipapplication.statement_of_faith#</div>

					<p><span>#getQuestion("Problems")#</p>
					<div class="well">#membershipapplication.problems#</div>

					<p><span>#getQuestion("Agree")#</p>
					<div class="well">#membershipapplication.agree#</div>

					<p><span>#getQuestion("Member_count")#</p>
					<div class="well">#membershipapplication.member_count#</div>

					<p><span>#getQuestion("Date_fee_sent")#</p>
					<div class="well">#membershipapplication.date_fee_sent#</div>

					<p><span>#getQuestion("completed")#</p>
					<div class="well">#membershipapplication.completed#</div>

	</div>

	<cfif isFellowshipCouncil() OR gotRights("handbookedit")>

		<div>
					<cfif val(membershipapplication.handbookid)>
					<p>
						#linkto(Text="Handbook Page", controller="handbook.organizations", action="show", key=membershipapplication.handbookid)#
					</p>
					</cfif>

					<p><span>#getQuestion("assignedTo","noTags")#: </span>
						#membershipapplication.assignedTo#</p>

					<p><span>#getQuestion("interviewedAt","noTags")#: </span>
						<cftry>
						#dateformat(membershipapplication.interviewedAt, "medium")#
						<cfcatch></cfcatch>
						</cftry>
						</p>

					<p><span>#getQuestion("interview_comments")#</span> <br />
						#membershipapplication.interview_comments#</p>

					<p><span>#getQuestion("approved_by_commission","noTags")#: </span>
						<cfif isDefined("membershipapplication.approved_by_commission")>
						#dateformat(membershipapplication.approved_by_commission, "medium")#</p>
						<cfelse>
						Not approved by membership commission yet.
						</cfif>

					<p><span>#getQuestion("approved_by_fc","noTags")#: </span>
						#dateformat(membershipapplication.approved_by_fc, "medium")#</p>

					<p><span>#getQuestion("approved_by_delegates","noTags")#: </span>
						<cfif isDefined("membershipapplication.approved_by_delegates")>
						#dateformat(membershipapplication.approved_by_delegates, "medium")#
						<cfelse></cfif>
						</p>

					<p><span>#getQuestion("fee_recievedAt","noTags")#: </span>
						<cfif isDefined("membershipapplication.fee_recievedAt")>
						#dateformat(membershipapplication.fee_recievedAt, "medium")#</p>
						<cfelse>
						Not approved by delegates yet.
						</cfif>

					<p><span>#getQuestion("Comments")#</span>
						#membershipapplication.comments#</p>

					<p><span>#getQuestion("createdAt","noTags")#: </span>
						#dateformat(membershipapplication.createdAt, "medium")#</p>

					<p><span>#getQuestion("updatedAt","noTags")#: </span>
						#dateformat(membershipapplication.updatedAt, "medium")#</p>

		</div>

	</cfif>

<cfif not isDefined("params.doc") AND showbuttons>
	#linkTo(text="Show uploaded documents", controller="membership.resources", action="index", key=params.key, class="btn")#

	#linkTo(text="Edit this membershipapplication", action="edit", key=getKey(), class="btn")#
</cfif>

</cfoutput>
<p>&nbsp;</p>

<div class="well">
	<h3>UpLoaded docs, images, etc:</h3>
	<ul>
		<cfoutput query="membershipapplicationresources">
			<li>#linkto(text=file, href="/files/#file#")#
		</cfoutput>
	</ul>
</div>