<h1>Showing membershipappresource</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>

			
				
					<p><span>ID</span> <br />
						#membershipappresource.ID#</p>
				
					<p><span>Application ID</span> <br />
						#membershipappresource.applicationID#</p>
				
					<p><span>Application UUID</span> <br />
						#membershipappresource.applicationUUID#</p>
				
					<p><span>Desciption</span> <br />
						#membershipappresource.desciption#</p>
				
					<p><span>File</span> <br />
						#membershipappresource.file#</p>
				
					<p><span>Created At</span> <br />
						#membershipappresource.createdAt#</p>
				
					<p><span>Updated At</span> <br />
						#membershipappresource.updatedAt#</p>
				
					<p><span>Deleted At</span> <br />
						#membershipappresource.deletedAt#</p>
				
			
		

#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this membershipappresource", action="edit", key=membershipappresource.ID)#
</cfoutput>
