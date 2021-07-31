<h1>Showing Course Question</h1>

<cfoutput>#includePartial(partial="showFlash")#</cfoutput>

<cfoutput>

					<p><span>Person Asking:</span>
						#person.fname# #person.family.lname#</p>
				
					<p><span>Course: </span>
						#Course.title#</p>
				
					<p><span>Question</span> <br />
						#Coursequestion.question#</p>
				
					<p><span>Created: </span>
						#dateFormat(Coursequestion.createdAt)#</p>
				
					<p><span>Approved: </span>
						#Coursequestion.approved#</p>

					<p><span>Sortorder: </span>#Coursequestion.sortorder#</p>
				
				
#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this Coursequestion", action="edit", key=Coursequestion.id)#
</cfoutput>
