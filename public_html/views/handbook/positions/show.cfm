<h1>Showing handbookposition</h1>

<cfoutput>

					<p><span>Personid</span> <br />
						#handbookposition.personid#</p>
				
					<p><span>Organizationid</span> <br />
						#handbookposition.organizationid#</p>
				
					<p><span>Position</span> <br />
						#handbookposition.position#</p>
				
					<p><span>Position2</span> <br />
						#handbookposition.position2#</p>
				
					<p><span>Positiontypeid</span> <br />
						#handbookposition.positiontypeid#</p>
				
					<p><span>Updated At</span> <br />
						#handbookposition.updatedAt#</p>
				
					<p><span>Created At</span> <br />
						#handbookposition.createdAt#</p>
				
					<p><span>Deleted At</span> <br />
						#handbookposition.deletedAt#</p>
				

#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this handbookposition", action="edit", key=handbookposition.personid,organizationid)#
</cfoutput>
