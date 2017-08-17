<h1>Showing item</h1>

<cfoutput>

					<p><span>Name: </span>
						#item.name#</p>
				
					<p><span>Retreat: </span> 
						#item.retreat.regid#</p>
				
					<p><span>Description: </span> 
						#item.description#</p>
				
					<p><span>Price: </span> 
						#dollarformat(item.price)#</p>
				
					<p><span>Expires: </span> 
						#dateformat(item.expiresAt)#</p>

					<p><span>Created: </span> 
						#dateformat(item.createdAt)#</p>
				

#linkTo(text="Return to the listing", action="index", key=item.retreat.id)# | #linkTo(text="Edit this item", action="edit", key=item.id)#
</cfoutput>
