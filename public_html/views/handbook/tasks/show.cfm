<div class="span10 offset1">
<cfoutput>

<h1>#handbooktask.title#</h1>

#includePartial(partial="showFlash")#


<!---				
					<p><span>Parenttask Id</span> <br />
						#handbooktask.parenttaskId#</p>
--->				

					<div class="well">#handbooktask.task#</div>
				
					<p><span>Assigned to: </span>					#handbooktask.assignedto#</p>
				
					<p><span>Assigned by: </span>
						#handbooktask.assignedby#</p>
				
					<p><span>Due: </span>
						#dateformat(handbooktask.dueAt)#</p>
				
					<p><span>Status: </span><br />
						#handbooktask.status#</p>
				
					<p><span>Notes: </span> <br />
						#handbooktask.notes#</p>
				
					<p><span>Completed: </span>
						#dateFormat(handbooktask.completedAt)#</p>
				
					<p><span>Created: </span>
						#dateformat(handbooktask.createdAt)#</p>
				
					<p><span>Updated: </span>
						#dateFormat(handbooktask.updatedAt)#</p>
				
			
		

#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this task", action="edit", key=handbooktask.id)#
</cfoutput>
</div>