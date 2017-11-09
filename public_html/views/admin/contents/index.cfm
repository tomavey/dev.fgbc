<div class="container">

<h1>Listing Pages</h1>

<cfoutput>
	<p>#linkTo(text="New page", action="new")#</p>
</cfoutput>

<table class="table">
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
			#editTag()# 
			#linkTo(text="<i class='icon-search'></i>", key=id, route="showpage")# 
			#deleteTag(class="noajax")#
		</td>
	</tr>
</cfoutput>
</table>

<cfoutput>
	<p>#linkTo(text="New page", action="new")#</p>
</cfoutput>


</div>