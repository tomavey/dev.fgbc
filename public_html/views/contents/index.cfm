<div class="container card card-charis card-charis-square" id=#params.controller#.#params.action#>

<h1>Listing contents</h1>

<table>
	<tr>
		<th>
			Name
		</th>
		<th>
			Shortlink
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
			#linkTo(text=shortlink, route=shortlink)#
		</td>
		<td>
			#dateformat(updatedAt)#	
		</td>
		<td>
			#editTag()# 
			#linkTo(
						text="<i class='fa fa-search'></i>",
						route="showpage",
						key=ID,
						title="show"
						)# 
			#deleteTag()#
		</td>
	</tr>
</cfoutput>
</table>

<cfoutput>
	<p>#linkTo(text="New content", action="new")#</p>
</cfoutput>


</div>