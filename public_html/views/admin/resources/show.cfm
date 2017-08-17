<div id="#params.controller##params.action#">
<h1>Showing resource</h1>

<cfoutput>
	<div class="postbox">
					<p><span>Id</span> <br />
						#resource.id#</p>
				
					<p><span>File Author</span> <br />
						#resource.author#</p>
				
					<p><span>File Description</span> <br />
						#resource.description#</p>
				
					<p><span>File</span> <br />
						#resource.file#</p>
				
				
					<p><span>Created At</span> <br />
						#resource.createdAt#</p>
				
	</div>
#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this resource", action="edit", key=resource.id)#
</cfoutput>
