<h1>Showing resource</h1>

<cfoutput>#includePartial(partial="showFlash")#</cfoutput>

<cfoutput>

			
				
					<p><span>Id</span> <br />
						#resource.id#</p>
				
					<p><span>Url</span> <br />
						#resource.url#</p>
				
					<p><span>Comment</span> <br />
						#resource.comment#</p>
				
					<p><span>Author</span> <br />
						#resource.author#</p>
				
					<p><span>Created At</span> <br />
						#resource.createdAt#</p>
				
					<p><span>Update At</span> <br />
						#resource.updateAt#</p>
				
					<p><span>Approved At</span> <br />
						#resource.approvedAt#</p>
				
					<p><span>Deleted At</span> <br />
						#resource.deletedAt#</p>
				
			
		

#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this resource", action="edit", key=resource.id)#
</cfoutput>
