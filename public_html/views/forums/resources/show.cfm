<h1>Showing forumresource</h1>

<cfoutput>

					<p><span>Id</span> <br />
						#forumresource.id#</p>
				
					<p><span>Forumid</span> <br />
						#forumresource.forumid#</p>
				
					<p><span>File</span> <br />
						#forumresource.file#</p>
				
					<p><span>Description</span> <br />
						#forumresource.description#</p>
				
					<p><span>Createdby</span> <br />
						#forumresource.createdby#</p>
				
					<p><span>Createdat</span> <br />
						#forumresource.createdat#</p>
				
					<p><span>Updatedat</span> <br />
						#forumresource.updatedat#</p>
				
					<p><span>Deletedat</span> <br />
						#forumresource.deletedat#</p>
				

#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this forumresource", action="edit", key=forumresource.id)#
</cfoutput>
