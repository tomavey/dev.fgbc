<h1>Showing retreat</h1>

<cfoutput>

					<p><span>Regid: </span> 
						#retreat.regid#</p>
				
					<p><span>Title: </span> 
						#retreat.title#</p>
				
					<p><span>Active: </span> 
						#retreat.active#</p>
				
					<p><span>Showregs: </span> 
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
				
					<p><span>Registration Comments: </span> <br />
						#retreat.registrationcomments#</p>
				
					<p><span>Schedule: </span> <br />
						#retreat.schedule#</p>
				
					<p><span>Location: </span> <br />
						#retreat.location#</p>
				
					<p><span>Comments: </span> 
						#retreat.comments#</p>
				
					<p><span>Created: </span> 
						#dateformat(retreat.createdAt)#</p>
				
#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this retreat", action="edit", key=retreat.id)#
</cfoutput>
