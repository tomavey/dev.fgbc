<cfoutput>

<h1>#retreat.title#</h1>

#editTag(retreat.id)#

					<p><span>Retreat ID: </span> 
						#retreat.regid#</p>
				
						<p><span>Reg Fox Form Name: </span> 
							#retreat.regFoxFormName#</p>

							<p><span>This retreat is active? </span> 
						#retreat.active#</p>
				
					<p><span>Show registration options? </span> 
						#retreat.showregs#</p>

						<p><span>External Registration Link? </span> 
							<a href="#retreat.registrationlink#" target="_new">#retreat.registrationlink#</a></p>

							<p>#linkTo(text="View Options for #retreat.title#", controller="focus.items", action="index", params="retreatid=#params.key#", class="btn")#	</p>
				
					<p><span>Retreat Begins: </span> 
						#dateformat(retreat.startAt)#</p>
				
					<p><span>Retreat Ends: </span> 
						#dateformat(retreat.endAt)#</p>
				
					<p><span>Discount deadline (after this date, the price may increase): </span> 
						#dateformat(retreat.discountdeadline)#</p>
				
					<p><span>Planned price increase after discount deadline (must increase reg prices manually): </span> 
						#dollarFormat(retreat.priceincrease)#</p>

					<p><span>Registration Deadline (after this date, reg will not show): </span> 
						#dateformat(retreat.deadline)#</p>
				
					<p><span>Who is coming deadline (after this date, the who is coming list will not show): </span> 
						#dateformat(retreat.whoiscomingdeadline)#</p>
				
					<p>Registration is closed message:</p>
						<div class="well">
							#retreat.notopenmessage#
						</div>

					<p><span>Past the deadline message: </span></p> 
						<div class="well">
							#retreat.pastdeadlinemessage#
						</div>

					<p><span>Registration Comments: </span> </p>
						<div class="well">
							#retreat.registrationcomments#
						</div>
				
					<p><span>Schedule: </span> </p>
						<div class="well">#retreat.schedule#</div>
				
					<p><span>Location: </span> </p>
						<div class="well">#retreat.location#</div>
				
					<p><span>Comments: </span> </p>
						<div class="well">#retreat.comments#</div>
				
					<p><span>Created: </span> 
						#dateformat(retreat.createdAt)#</p>
				
#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this retreat", action="edit", key=retreat.id)#
</cfoutput>
