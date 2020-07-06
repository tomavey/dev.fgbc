<h1>Listing resources</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>
	<p>#linkTo(text="New resource", action="new")#</p>
</cfoutput>
<div class="table table-striped">
<cftable query="Resources" colHeaders="true" HTMLTable="true">
	
				
					<cfcol header="Link" text="#link#" />
				
					<cfcol header="Comment" text="#comment#" />
				
					<cfcol header="Author" text="#author#" />
				
					<cfcol header="Created" text="#dateformat(createdAt)#" />
				
					<cfcol header="Approved" text="#dateformat(approvedAt)#" />
				
					<cfcol header="Deleted At" text="#deletedAt#" />
				
			
		
	<cfcol header="" text="#linkTo(text='Show', action='show', key=id)#" />
	<cfcol header="" text="#linkTo(text='Edit', action='edit', key=id)#" />
	<cfcol header="" text="#linkTo(text='Delete', action='delete', key=id, confirm='Are you sure?')#" />
</cftable>
</div>
