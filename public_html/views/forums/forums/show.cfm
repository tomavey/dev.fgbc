<h1>Showing Forum: </h1>

<cfoutput>

					<p><span>Title: </span>#forumforum.forum#</p>
				
					<p><span>Description: </span>#forumforum.description#</p>

					<p><span>Instructions: </span>#forumforum.instructions#</p>

					<p><span>Created By: </span>#forumforum.createdBy#</p>
				
					<p><span>Created: </span>#dateformat(forumforum.createdAt)#</p>
				
					<p><span>Updated: </span>#dateformat(forumforum.updatedAt)#</p>
				

#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this forumforum", action="edit", key=forumforum.id)#
</cfoutput>
