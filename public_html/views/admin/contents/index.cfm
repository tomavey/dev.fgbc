<div class="container">

<h1>Listing Pages</h1>

<cfoutput>
	<p>#linkTo(text="New page", action="new")#</p>

		<p>
			filter by:
			<cfif !isDefined('params.category')>
				<cfloop list="#categoriesList#" index="i">
				#linkto(text=i, params="category=#i#")# | 
			</cfloop>
		</cfif>
			#linkto(text='all')#

		</p>
</cfoutput>

<table class="table">
	<tr>
		<th>
			Name
		</th>
		<th>
			Category
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
			#category#
		</td>
		<td>
			#shortlink#
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
			#deleteTag(class="noajax")#
		</td>
	</tr>
</cfoutput>
</table>

<cfoutput>
	<p>#linkTo(text="New page", action="new")#</p>
</cfoutput>


</div>