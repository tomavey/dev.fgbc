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
						<cfif dateCompare(retreat.deadline, retreat.discountdeadline)>
							This price increases on #dateformat(retreat.discountdeadline,"medium")#</br>
						</cfif>
						Registration deadline is #dateformat(retreat.deadline,"medium")#. <br/>No refunds for cancelations or changes after #dateformat(retreat.deadline,"medium")#. </br>
						Additional financial aid may be available.  Email #mailto(getSetting('focusForFinancialHelp'))# for more information.
					</p>
</cfoutput>