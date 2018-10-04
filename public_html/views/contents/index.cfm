<div class="container card card-charis card-charis-square" id=#params.controller#.#params.action#>

<h1>Listing contents</h1>

<table>
	<tr>
		<th>
			Name
		</th>
		<th>
			Date
		</th>
		<th>
			&nbsp;
		</th>
	</tr>
<cfoutput query="contents">
	<tr>
		<td>
			#name#
		</td>
		<td>
			#dateformat(updatedAt)#	
		</td>
		<td>
			#linkTo(
						text="<i class='fa fa-pencil-square'></i>",
						controller="focus.contents",
						action="edit",
						key=ID,
						title="show"
						)# 
			#linkTo(
						text="<i class='fa fa-search'></i>",
						controller="focus.contents",
						action="show",
						key=ID,
						title="show"
						)# 
		</td>
	</tr>
</cfoutput>
</table>

<cfoutput>
	<p>#linkTo(text="New content", action="new")#</p>
</cfoutput>


</div>