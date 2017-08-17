 <cfoutput><h1>AGBM Region: #handbookagbmregion.name#</h1>

#includePartial("showFlash")#


			
					<p><span>AGBM Rep: </span>
						#agbmrep.selectName#</p>
				
					<p><span>Description: </span> 
						#handbookagbmregion.description#</p>
				
					<p><span>Created:</span> 
						#dateformat(handbookagbmregion.createdAt)#</p>
				
#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this handbookagbmregion", action="edit", key=handbookagbmregion.id)#
</cfoutput>
