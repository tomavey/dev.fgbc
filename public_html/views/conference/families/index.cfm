<div class="eachItemShown">
	<h1>Families</h1>
	<cfoutput>
		#addTag()#
	</cfoutput>	
	<table class="dataTable">
		<thead>
			<tr>
				<th>
					Last Name
				</th>
				<th>
					City
				</th>
				<th>
					State	
				</th>
				<th>
					Email	
				</th>
				<th>
					Phone
				</th>
				<th>
					Created
				</th>
				<th>
					&nbsp;	
				</th>
			</tr>
		</thead>
		<tbody>
			<cfoutput query="families" group="id">
			<tr>
				<td>
				#linkTo(action="show", controller="conference.families", key="#id#", text="#lname#")#
				</td>
				<td>
					#city#
				</td>
				<td>
					#state_mail_abbrev#	
				</td>
				<td>
					#mailTo(email)#
				</td>
				<td>
					#phone#
				</td>
				<td>
					#dateformat(createdat, "medium")#
				</td>
				<td>
					#showTag()# 
					#editTag()#
					#deleteTag(class="notajax")#
				</td>
			</tr>
			</cfoutput>
		</tbody>
	</table>
	
	
	<cfoutput>
		#addTag()#
	</cfoutput>	
</div>
