<div class="row-fluid well contentStart contentBg">

<div class="span12">

<h1>Showing right</h1>

<cfoutput>

					<p><label>Name: </label>
						#right.name#</p>
				
					<p><label>Description: </label>
						#right.description#</p>

					<p>Groups:
						<cfloop query="groups">
							#linkTo(text=name, controller="groups", action="show", key=id)#-
							#linkTo(text="x", controller="groups", action="remove-right", params="groupid=#id#&rightid=#params.key#")#, 
						</cfloop>
					
					</p>				

#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this right", action="edit", key=right.Id)#
</cfoutput>
</div>
</div>