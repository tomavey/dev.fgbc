<div class="container">
<h1>Showing setting</h1>

<cfoutput>#includePartial(partial="showFlash")#</cfoutput>

<cfoutput>

			
				
					<p><span>Setting name: </span>
						#setting.name#</p>
				
					<p><span>Setting Value: </span>
						#setting.value#</p>
				
					<p><span>Category:</span>
						#setting.category#</p>
				
					<p><span>Description</span> <br />
						#setting.description#</p>

					<p><span>Created: </span> 
						#dateFormat(setting.createdAt)#</p>
				
					<p><span>Updated: </span>
						#dateFormat(setting.updatedAt)#</p>
				
		

#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this settings", action="edit", key=setting.id)#
</cfoutput>
