<h1>Showing registrant</h1>

<cfoutput>

					<p><span>First name:</span>
						#registrant.fname#</p>
				
					<p><span>Last name:</span> 
						#registrant.lname#</p>
				
					<p><span>Email: </span>
						#mailTo(registrant.email)#</p>
				
					<p><span>Phone: </span>
						#registrant.phone#</p>
				
					<p><span>Roommate: </span> 
						#registrant.roommate#</p>
				
					<p><span>First Time? </span> 
						#registrant.firstTime#</p>

					<p><span>Comment: </span> <br />
						#registrant.comment#</p>
				
					<p><span>Created: </span>
						#dateformat(registrant.createdAt)#</p>
				
					<p><span>Updated: </span> 
						#dateformat(registrant.updatedAt)#</p>
				

#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this registrant", action="edit", key=registrant.id)#
</cfoutput>
