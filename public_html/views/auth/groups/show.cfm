<div class="postbox">
<h1>Showing group</h1>

<cfoutput>

					<p><label>ID:</label> 
						#group.ID#</p>
				
					<p><label>Name: </label> 
						#group.name#</p>
				
					<p><label>Description: </label>
						#group.description#</p>

					<p>Rights: 
					<cfloop query="rights">
						#linkTo(text=name, route="handbookremoveRight", key=ID)#-#linkTo(text="x", controller="Groups", action="removeRight", params="groupId=#params.key#&rightid=#auth_rightsid#")#  
					</cfloop>
			#startFormTag(action="addARight", key=params.key)#
			
			#selectTag(label="Add a right: ", name="rightid", options=allrights)#
		
			#submitTag()#
				
			#endFormTag()#						

					</p>

#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this group", action="edit", key=group.ID)#
</cfoutput>
</div>
