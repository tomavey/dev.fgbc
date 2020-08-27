<h1>Showing resource</h1>
<cfoutput>
<div class="eachItemShown #params.action#">

					<p><span>Email: </span> 
						#resource.email#</p>
				
					<p><span>Name: </span> 
						#resource.name#</p>
				
					<p><span>Address: </span>
						#resource.address#</p>
				
					<p><span>Approved: </span> 
						#dateformat(resource.approvedAt)#</p>
				
					<p><span>Sent: </span>
						#dateformat(resource.sendAt)#</p>
				
					<p><span>Item: </span>
						#resource.item#</p>

					<p><span>Comment: </span> 
						#resource.comment#</p>
				
					<p><span>Created: </span> 
						#dateformat(resource.createdAt)#</p>
				

#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this resource", action="edit", key=resource.id)#
</div>
</cfoutput>
