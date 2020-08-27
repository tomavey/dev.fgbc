<h1>Showing age_range</h1>

<cfoutput>

					<p><span>Id</span> <br />
						#age_range.id#</p>
				
					<p><span>Name</span> <br />
						#age_range.name#</p>
				
					<p><span>Description</span> <br />
						#age_range.description#</p>
				
					<p><span>Type</span> <br />
						#age_range.type#</p>

					<p><span>Createdat</span> <br />
						#age_range.createdat#</p>
				
					<p><span>Updatedat</span> <br />
						#age_range.updatedat#</p>
				
					<p><span>Deletedat</span> <br />
						#age_range.deletedat#</p>
				

#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this age_range", action="edit", key=age_range.id)#
</cfoutput>
