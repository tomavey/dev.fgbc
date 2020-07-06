<h1>Showing forumvotetype</h1>

<cfoutput>

					<p><span>Id</span> <br />
						#forumvotetype.id#</p>
				
					<p><span>Vote</span> <br />
						#forumvotetype.vote#</p>
				
					<p><span>Description</span> <br />
						#forumvotetype.description#</p>
				
					<p><span>Created At</span> <br />
						#forumvotetype.createdAt#</p>
				
					<p><span>Updated At</span> <br />
						#forumvotetype.updatedAt#</p>
				
					<p><span>Deleted At</span> <br />
						#forumvotetype.deletedAt#</p>
				

#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this forumvotetype", action="edit", key=forumvotetype.id)#
</cfoutput>
