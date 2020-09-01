<div id="membershipapplicationindex">
<h1>Membership Application Questions</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>
	<p>#linkTo(text="New question", action="new", class="btn")#</p>
</cfoutput>


<table class="table">
	<cfoutput query="membershipappquestions" group="field">
		<tr>
			<td colspan="2">
				<a name='#field#'></a>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<h3>#field#<a name='#field#'></a></h3>
			</td>
		</tr>
		<cfoutput>
			<tr>
				<td>#language#</td>
				<td>#question#</td>
				<td>
					#linkTo(text='<i class="icon-eye-open"></i>', action='show', key=ID, class="tooltip2", title="View")#
					#linkTo(text='<i class="icon-edit"></i>', action='edit', key=ID, class="tooltip2 ajaxedit", title="Edit")#
					#linkTo(
						text='<i class="icon-trash"></i>', 
						action='delete', 
						key=ID, 
						class='tooltip2', 
						title='Delete', 
						onclick="return	confirm('Are you sure that you want to delete the question')"
						)#
						#linkTo(text='<i class="icon-plus"></i>', action='copy', key=ID, class="tooltip2 ajaxedit", title="Edit")#
				</td>
			</tr>
		</cfoutput>
	</cfoutput>
</table>
<!---
<cftable query="membershipappquestions" colHeaders="true" HTMLTable="true">
	
					<cfcol header="Field" text="#field#" />
				
					<cfcol header="Language" text="#language#" />
				
					<cfcol header="Question" text="#question#" />
				
	<cfcol header="" text="#linkTo(text='<i class="icon-eye-open"></i>', action='show', key=ID, class="tooltip2", title="View")#" />
	<cfcol header="" text="#linkTo(text='<i class="icon-edit"></i>', action='edit', key=ID, class="tooltip2", title="Edit")#" />
	<cfcol header="" 
		text="
			#linkTo(
				text='<i class="icon-trash"></i>', 
				action='delete', 
				key=ID, 
				class='tooltip2', 
				title='Delete', 
				onclick="return	confirm('Are you sure that you want to delete the question')"
				)#" />
	<cfcol header="" text="#linkTo(text='<i class="icon-plus"></i>', action='copy', key=ID, class="tooltip2", title="Copy")#" />
</cftable>
--->
</div>