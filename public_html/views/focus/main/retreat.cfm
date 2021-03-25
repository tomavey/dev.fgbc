<cfoutput>
	<!--- <cfset ddd(retreat.properties())> --->
	<cfset ddd(options)>
<div id="retreatPage" class="row" style="text-align:center;">

	<div id="title" class="center">
		<h1>#retreat.Title#</h1>
	</div>
	<div id="date" class="center">
		#datetext(retreat.startat,retreat.endat)#
	</div>

	<cfif isDefined("retreat.facebooklink") AND len(retreat.facebooklink)>
	<div id="facebook" class="center">
		#linkTo(text=imageTag("facebook-findus.png"), href=retreat.facebooklink, target="_blank")#
	</div>
	</cfif>
	<div>&nbsp;</div>


</div>

<div class="row">

<div class="span6">

<cfif isOffice() >
	Office: #editTag(id=retreat.id, controller="focus.retreats")#
</cfif>
<!--- Deadline is past: #showDeadlineIsPastMessage(retreat.deadline)#<br/> --->
<!--- Show Reg Options: #showRegistration(options.recordcount, retreat)# --->

		<div id="registration" class="well">
			<h1>Registration</h1>

			<cfif regIsClosed(retreat.regisopen)>
				#retreat.notopenmessage#

			<cfelseif showDeadlineIsPastMessage(retreat.deadline)>

				<cfif len(retreat.pastdeadlinemessage)>
					#retreat.pastdeadlinemessage#
				<cfelse>
					#retreat.notopenmessage#
				</cfif>

			<cfelseif showRegistration(options.recordcount, retreat)>

				#includePartial(partial="retreatRegOptions")#

			<cfelse>
				Registration is not open. (this should not show - make sure there are somme not-expired options for this retreat)

			</cfif>
		</div>

		<div id="schedule" class="well">
			<h1>Schedule</h1>
			#retreat.schedule#
		</div>
</div>


<div class="span5">
		<div id="location" class="well">
			<h1>Location</h1>
			<cfif len(retreat.image)>
				#imageTag(source=retreat.image, width="100px")#
			</cfif>
			#retreat.location#
		</div>

<cfif isBefore(retreat.whoiscomingdeadline) || gotRights("office")>
	<div id="whoiscoming" class="well">
		<cfif !len(retreat.regFoxFormName)>
			<cfset retreat.regFoxFormName = retreat.regid>
		</cfif>
		<h1>#linkto(text="Who is coming?", href="/focus/regFox?regfoxformname=#retreat.regFoxFormName#")#</h1>
	</div>
</cfif>

</div>
</cfoutput>