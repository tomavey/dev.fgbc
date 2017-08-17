<cfoutput>
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

		<div id="registration" class="well">
			<h1>Registration</h1>

			<cfif showRegistration()>

				<cfif options.recordcount>
					#linkTo(text="Register Here", controller="focus.shoppingcarts", action="new", params="retreatid=#retreat.id#", class="btn")#
					#retreat.registrationComments#

					<p>Registration Options: </p>
					<ul>
					<cfloop query="options">
						<cfif showItem(id)>
						<li>
							#description# - #dollarformat(price)#
							<cfif len(popup)>
								<a href="" title="#popup#" class="tooltipside"><i class="icon-info-sign"></i></a>
							</cfif>

						</li>
						</cfif>
					</cfloop>
					</ul>
					<p>
						<cfif dateCompare(retreat.deadline, retreat.discountdeadline)>
							This price increases on #dateformat(retreat.discountdeadline,"medium")#</br>
						</cfif>
						Registration deadline is #dateformat(retreat.deadline,"medium")#</br>
						Additional financial aid may be available.  Email #mailto("tomavey@fgbc.org")# for more information.
					</p>
				<cfelse>
						Registration is not ready yet. Stay tuned!
				</cfif>

			<cfelse>
					#retreat.notopenmessage#
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

	<div id="whoiscoming" class="well">
		<h1>#linkto(text="Who is coming?", controller="focus.registrations", action="whoiscoming", key=params.key)#</h1>
	</div>

</div>
</cfoutput>