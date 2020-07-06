<cfoutput>
					<p><span>Groups:</span>
						<cfloop query="groups">
							#linkTo(text=title, controller="handbookGroupTypes", action="show", key=grouptypeid)# 
							#linkTo(text="x", controller="handbookGroups", action="delete", key=id, title="Remove from group")#;
						</cfloop>
						
						#startFormTag(controller="handbookGroups", action="create", key=params.key)#
						#select(objectName='handbookgroup', property='groupTypeId', options=allgroups, label='')#
						#hiddenField(objectName='handbookGroup', property='personId')#
						#submitTag("Add to group")#
						#endFormTag()#
		
					</p>

</cfoutput>