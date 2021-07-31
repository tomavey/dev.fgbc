<div class="container">
<cfoutput>
<h2>Group name: #group.name#</h2>


					<p><span>Description: </span>
						#group.description#</p>

					<p>Rights: 
					<cfloop query="rights">
						#linkTo(text=name, controller="auth.rights", action="show", key=ID)#-#linkTo(text="x", controller="auth.Groups", action="removeRight", params="groupId=#params.key#&rightid=#auth_rightsid#")#  
					</cfloop>
			#startFormTag(action="addARight", key=params.key)#
			
			#selectTag(label="Add a right: ", name="rightid", options=allrights)#
		
			#submitTag()#
				
			#endFormTag()#						

					</p>

#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this group", action="edit", key=group.ID)#
</cfoutput>
</div>
