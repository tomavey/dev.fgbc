<h1>Listing changelogs</h1>

<cftable query="changelogs" colHeaders="true" HTMLTable="true">
	
					<cfcol header="Id" text="#id#" />
				
					<cfcol header="Table" text="#table#" />
				
					<cfcol header="Column" text="#column#" />
				
					<cfcol header="Olddata" text="#olddata#" />
				
					<cfcol header="User" text="#user#" />
				
					<cfcol header="Created At" text="#createdAt#" />
				
					<cfcol header="Updated At" text="#updatedAt#" />
				
					<cfcol header="Deleted At" text="#deletedAt#" />
				
	<cfcol header="" text="#linkTo(text='Show', action='show', key=id)#" />
	<cfcol header="" text="#linkTo(text='Edit', action='edit', key=id)#" />
	<cfcol header="" text="#linkTo(text='Delete', action='delete', key=id, confirm='Are you sure?')#" />
</cftable>

<cfoutput>
	<p>#linkTo(text="New changelog", action="new")#</p>
</cfoutput>
