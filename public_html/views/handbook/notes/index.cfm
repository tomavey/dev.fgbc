<h1>Listing handbooknotes</h1>

<cftable query="handbooknotes" colHeaders="true" HTMLTable="true">
	
					<cfcol header="ID" text="#ID#" />
				
					<cfcol header="Created By" text="#createdBy#" />
				
					<cfcol header="Person Id" text="#personId#" />
				
					<cfcol header="Organization Id" text="#organizationId#" />
				
					<cfcol header="Note" text="#note#" />
				
					<cfcol header="Created At" text="#createdAt#" />
				
					<cfcol header="Updated At" text="#updatedAt#" />
				
					<cfcol header="Deleted At" text="#deletedAt#" />
				
	<cfcol header="" text="#linkTo(text='Show', action='show', key=ID)#" />
	<cfcol header="" text="#linkTo(text='Edit', action='edit', key=ID)#" />
	<cfcol header="" text="#linkTo(text='Delete', action='delete', key=ID, confirm='Are you sure?')#" />
</cftable>

<cfoutput>
	<p>#linkTo(text="New handbooknote", action="new")#</p>
</cfoutput>
