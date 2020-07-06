<cfoutput>
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
						<cfif dateCompare(retreat.deadline, retreat.discountdeadline) && isBefore(retreat.discountdeadline)>
							This price increases 
							<cfif val(retreat.priceincrease)>
								(#dollarFormat(retreat.priceincrease)#)
							</cfif>
							on #dateformat(retreat.discountdeadline,"medium")#</br>
						</cfif>
						Registration deadline is #dateformat(retreat.deadline,"medium")#. <br/>No refunds for cancelations or changes after #dateformat(retreat.deadline,"medium")#. </br>
						Additional financial aid may be available.  Email #mailto(getSetting('focusForFinancialHelp'))# for more information.
					</p>
					<cfif retreat.regid is "central19" || retreat.regid is "east19">
						<p>The new President of the Charis Association of Central Africa will be conducting a fraternal visit to the USA. The new President is Bavon Jonas, a local church pastor in Bangui who also leads the @3500 churches of the CAR. He will be accompanied by Dr. Francois Ngoumape, Dean of the School of Theology (Seminary) in Bangui. These men will participate in the Central and East Focus retreats. Please consider making a donation to help cover their expenses.</p>
					</cfif>
</cfoutput>