<div class="container">


	<cfoutput>
		<h1>Showing the right named "#right.name#"</h1>

		<p>Description: #right.description#</p>

		<p>Groups:
			<cfloop query="groups">
				#linkTo(text=name, controller="auth.groups", action="show", key=auth_groupsid)#-
				#linkTo(text="x", controller="auth.groups", action="remove-right", params="groupid=#auth_groupsid#&rightid=#params.key#")#, 
			</cfloop>
		
		</p>				

		#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this right", action="edit", key=right.Id)#
	</cfoutput>

</div>