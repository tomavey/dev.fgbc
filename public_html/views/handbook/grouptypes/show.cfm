<cfoutput>
<div class="#params.action#" id="showinfo">

	<h1>#handbookgrouptype.title#</h1>
	
	
						<p>#handbookgrouptype.comments#</p>
					
						<p><span>Created: </span>
							#handbookgrouptype.createdAt#</p>
					
						<p><span>Updated: </span>
							#handbookgrouptype.updatedAt#</p>
					
	
	#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this handbookgrouptype", action="edit", key=handbookgrouptype.id)#
	</cfoutput>
	
	<p>
	
		<cfoutput>
			<h1>Group Members: (#people.recordcount#)</h1>	
		</cfoutput>


			<cfoutput query="people">
					#linkTo(text="#selectname#", controller="handbookPeople", action="Show", key=personid, class="ajaxclickable tooltip")#
					#linkTo(text="x", controller="handbookGroups", action="delete", params="groupTypeId=#params.key#&personid=#personid#", title="Remove from group", class="remove")#
					</br>
			</cfoutput>


		
	<cfoutput>
	#startFormTag(controller="handbookGroups", action="create")#
	#select(objectName='handbookGroup', property='personid', textfield="selectname", options=allpeople, label="")#
	#hiddenField(objectName='handbookGroup', property='groupTypeId')#
	#submitTag("Add to this group")#
	#endFormTag()#
	</cfoutput>
		
	</p>
	
</div>

	<div id="thisAjaxInfo">
		<!---this is where the popup information shows up when mousing over the church name--->
	</div>


