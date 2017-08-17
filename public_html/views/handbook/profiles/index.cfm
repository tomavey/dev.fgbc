<div class="span10">
<h1>Listing handbookprofiles</h1>
<p>* = not linked to a handbook record</p>
<table class="table table-striped">
	<thead>
		<tr>
			<th>
				Name
			</th>
			<th>
				Birthday, Anniversary, Spouse Birthday 
			</th>
			<th>
				When ministry started
			</th>
			<th>
				Submitted
			</th>
			<th>
				&nbsp;
			</th>
		</tr>
	</thead>
	<tbody>
		<cfoutput query="handbookprofiles" group="personid">
		<tr>
			<td>
				<cfif personid>
				    #linkto(text=fullname, controller="handbook-people", action="show", key=personid)#
				<cfelse>
					#fullname#&nbsp;*
				</cfif>
			</td>
			<th>
				#birthdayasstring#, #anniversaryasstring#, #wifesbirthdayasstring# 
			</th>
			<td>
				#ministrystartat#
			</td>
			<td>
				#dateformat(createdAt)#
			</td>
			<td>
				#linkTo(
						text="#imageTag('/view-icon.png')#", 
						controller="handbook-people", 
						action='show', 
						key=personid, 
						title="show"
						)#
				#linkTo(
						text="#imageTag('/edit-icon.png')#", 
						controller="handbook-people", 
						action='edit', 
						key=personid, 
						params="admin",
						title="edit"
						)#

			<cfif gotRights("superadmin")>
				#deleteTag(id)#
			</cfif>

			#linkTo(text='<i class="icon-picture"></i>', controller="handbook-pictures", action="index", key=personid, title="View Images")#
			</td>
	</tr>	
	</cfoutput>
	</tbody>
</table>

<cfoutput>
	<p>Count = #handbookProfiles.recordcount#</p>
	<p>#linkTo(text="New handbookprofile", action="new")#</p>
</cfoutput>
</div>