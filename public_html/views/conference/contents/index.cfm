<h1>Page Contents List</h1>
<div class="eachItemShown">

<table>
	<tr>
		<th>ID</th><th>Name</th><th>Createed</th><th>Updated</th><th></th>
	</tr>
<cfoutput query="contents">
	<tr class="ajaxdeleterow">
		<td>#id#</td>
		<td>#linkTo(text='#name#', action='show', key=id, title='Show')#</td>
		<td>#dateformat(createdat)#</td>
		<td>#dateformat(updatedat)#</td>
		<td>#linkTo(text='#imageTag('view-icon.png')#', action='show', key=id, title='Show')#
			#linkTo(text='#imageTag('edit-icon.png')#', action='edit', key=id, title='Edit')#
			#linkTo(text='#imageTag('delete-icon.png')#', action='delete', key=id, title='Delete', class='ajaxdeleterow')#
		</td>	
	</tr>
</cfoutput>		
</table>

<cfoutput>
	<p>#linkTo(text="#imageTag('add-icon.png')#", action="new", title='Add New')#</p>
</cfoutput>
</div>
