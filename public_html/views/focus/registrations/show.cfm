<h1>Showing registration</h1>

<cfoutput>

					<p><span>Registrant Id</span> <br />
						#registration.registrantId#</p>
				
					<p><span>Item Id</span> <br />
						#registration.itemId#</p>
				
					<p><span>Invoice Id</span> <br />
						#registration.invoiceId#</p>
				
					<p><span>Quantity</span> <br />
						#registration.quantity#</p>
				
					<p><span>Cost</span> <br />
						#registration.cost#</p>
				
					<p><span>Comment</span> <br />
						#registration.comment#</p>
				
					<p><span>Create At</span> <br />
						#registration.createdAt#</p>
				
					<p><span>Delete At</span> <br />
						#registration.deletedAt#</p>
				
					<p><span>Updated At</span> <br />
						#registration.updatedAt#</p>
				

#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this registration", action="edit", key=registration.id)#
</cfoutput>
