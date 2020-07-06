<h1>Showing equipannouncement</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>

			
				
					<p><span>Id</span> <br />
						#equipannouncement.id#</p>
				
					<p><span>Uuid</span> <br />
						#equipannouncement.uuid#</p>
				
					<p><span>Event</span> <br />
						#equipannouncement.event#</p>
				
					<p><span>Subject</span> <br />
						#equipannouncement.subject#</p>
				
					<p><span>Content</span> <br />
						#equipannouncement.content#</p>
				
					<p><span>Link</span> <br />
						#equipannouncement.link#</p>
				
					<p><span>Author</span> <br />
						#equipannouncement.author#</p>
				
					<p><span>Approved</span> <br />
						#equipannouncement.approved#</p>
				
					<p><span>Post At</span> <br />
						#equipannouncement.postAt#</p>
				
					<p><span>Send Type</span> <br />
						#equipannouncement.sendType#</p>
				
					<p><span>Sent At</span> <br />
						#equipannouncement.sentAt#</p>
				
					<p><span>Created At</span> <br />
						#equipannouncement.createdAt#</p>
				
					<p><span>Updated At</span> <br />
						#equipannouncement.updatedAt#</p>
				
					<p><span>Deleted At</span> <br />
						#equipannouncement.deletedAt#</p>
				
			
		

#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this equipannouncement", action="edit", key=equipannouncement.id)#
</cfoutput>
