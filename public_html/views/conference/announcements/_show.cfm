<cfoutput>

					<p><span>Subject</span>:
						#announcement.subject#</p>

					<p>#paragraphFormat(announcement.content)#</p>

				<cfif len(announcement.link)>
					<p>#announcement.link#</p>
				</cfif>

					<p><span>Author</span>:
						#announcement.author#</p>

					<p><span>Include invoice link: </span>#announcement.invoiceLink#</p>

					<p><span>Approved</span>:
						#announcement.approved#</p>

					<p><span>Post At</span>:
						#dateformat(announcement.postAt)#</p>

					<p><span>Sent At</span>: 						#dateformat(announcement.sentAt)#</p>

					<p><span>Created At</span>:
						#dateFormat(announcement.createdAt)#</p>

<cfif isOffice()>
#linkTo(text="Return to the listing", action="index", onlyPath="false", params="admin=true")# | #linkTo(text="Edit this announcement", action="edit", key=announcement.id, onlyPath="false", params="admin=true")# | #linkTo(text="Approve this announcement", action="approve", key=announcement.id, onlyPath="false", params="admin=true")# | #linkTo(text="Delete this announcement", action="delete", key=announcement.id, onlyPath="false", params="admin=true")#
</cfif>
</cfoutput>
