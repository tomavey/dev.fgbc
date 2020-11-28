<h1>Showing membershipappquestion</h1>

<cfoutput>#includePartial(partial="showFlash")#</cfoutput>

<cfoutput>

			
				
					<p><span>ID</span> <br />
						#membershipappquestion.ID#</p>
				
					<p><span>Field</span> <br />
						#membershipappquestion.field#</p>
				
					<p><span>Language</span> <br />
						#membershipappquestion.language#</p>
				
					<p><span>Question</span> <br />
						#membershipappquestion.question#</p>
				
					<p><span>Created At</span> <br />
						#membershipappquestion.createdAt#</p>
				

#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this membershipappquestion", action="edit", key=membershipappquestion.ID)#
</cfoutput>
