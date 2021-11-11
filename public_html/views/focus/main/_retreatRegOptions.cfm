<cfoutput>

				<cfif !len(retreat.registrationlink)>
					#linkTo(text="Register Here", controller="focus.shoppingcarts", action="new", params="retreatid=#retreat.id#", class="btn")#
				<cfelse>	
					#linkTo(text="Register Here", href=retreat.registrationlink, class="btn", target="_new")#
				</cfif>
				

				<cfif showOptions>

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
						Registration deadline is #dateformat(retreat.deadline,"medium")#. <br/>
						No refunds for cancelations or changes after #dateformat(retreat.deadline,"medium")#. </br>
						#retreat.registrationComments#
					</p>
				</cfif>	
</cfoutput>