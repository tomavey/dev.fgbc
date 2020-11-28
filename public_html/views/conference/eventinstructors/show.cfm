<h1>Showing Event/Instructor Link:</h1>

<cfoutput>#includePartial(partial="showFlash")#</cfoutput>

<cfoutput>



					<p><span>ID</span> <br />
						#eventinstructor.ID#</p>

					<p><span>Event ID</span> <br />
						#eventinstructor.eventID#</p>

					<p><span>Instructor ID</span> <br />
						#eventinstructor.instructorID#</p>

					<p><span>Created At</span> <br />
						#eventinstructor.createdAt#</p>


#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this", action="edit", key=eventinstructor.ID)#
</cfoutput>
