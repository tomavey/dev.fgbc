<div class="container">
<h1>Showing setting</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>

			
				
					<p><span>Setting name: </span>
						#setting.name#</p>
				
					<p><span>Setting Value: </span>
						#setting.value#</p>
				
					<p><span>Description</span> <br />
						#setting.description#</p>
				
					<p><span>Created: </span> 
						#dateFormat(setting.createdAt)#</p>
				
					<p><span>Updated: </span>
						#dateFormate(setting.updatedAt)#</p>
				
		

#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this fgbc_metas", action="edit", key=fgbc_metas.id)#
</cfoutput>
