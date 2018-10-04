<cfoutput>

<h1>#retreat.title#</h1>

#editTag(retreat.id)#

					<p><span>Retreat ID: </span> 
						#retreat.regid#</p>
				
					<p><span>This retreat is active? </span> 
						#retreat.active#</p>
				
					<p><span>Show registration options? </span> 
						#retreat.showregs#</p>
				
					<p><span>Begins: </span> 
						#dateformat(retreat.startAt)#</p>
				
					<p><span>Ends: </span> 
						#dateformat(retreat.endAt)#</p>
				
					<p><span>Discount deadline: </span> 
						#dateformat(retreat.discountdeadline)#</p>
				
					<p><span>Deadline: </span> 
						#dateformat(retreat.deadline)#</p>
				
					<p><span>Who is coming deadline: </span> 
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
