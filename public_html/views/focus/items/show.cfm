<h1>Showing item</h1>

<cfoutput>

					<p><span>Name: </span>
						#item.name#</p>
				
					<p><span>Retreat: </span> 
						#item.retreat.regid#</p>
				
					<p><span>Description: </span> 
						#item.description#</p>
				
					<p><span>Popup: </span> 
						#item.popup#</p>

					<p><span>Price: </span> 
						#dollarformat(item.price)#</p>
				
					<p><span>Sort Order: </span> 
						#item.sortOrder#</p>

						<p><span>Reg Count (for summary report): </span> 
							#item.regCount#</p>

							<!--- <p><span>Reg Count (for summary report): </span> 
						#item.regCount#</p> --->

					<p><span>Alert When Selected?: </span> 
						#item.alertwhenselected#</p>

						<p><span>Dependencies: </span> 
							#item.dependencies#</p>

							<p><span>Max to sell: </span> 
						#item.maxtosell#</p>

					<p><span>Comments: </span> 
						#item.comments#</p>

					<p><span>Category: </span> 
						#item.category#</p>

					<p><span>Expires: </span> 
						#dateformat(item.expiresAt)#</p>

					<p><span>Created: </span> 
						#dateformat(item.createdAt)#</p>
				

#linkTo(text="Return to the listing", action="index", key=item.retreat.id)# | #linkTo(text="Edit this item", action="edit", key=item.id)#
</cfoutput>
