<h1>Showing handbookpicture</h1>

<cfoutput>
	
						#imageTag("/handbookpictures/#handbookpicture.file#")#
				
					<p>#handbookpicture.description#</p>
				
					<p><span>Created By</span> <br />
						#handbookpicture.createdBy#</p>
				
					<p><span>Created At</span> <br />
						#dateformat(handbookpicture.createdAt)#</p>

#linkTo(text="Edit this handbookpicture", action="edit", key=handbookpicture.ID)#
</cfoutput>
