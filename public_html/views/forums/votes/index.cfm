<h1>All Votes</h1>

<cftable query="forumvotes" colHeaders="true" HTMLTable="true">
	
					<cfcol header="ID" text="#ID#" />
				
					<cfcol header="Post Id" text="#postId#" />
				
					<cfcol header="Votetype Id" text="#votetypeId#" />
				
					<cfcol header="Created By" text="#createdBy#" />
				
					<cfcol header="Created At" text="#createdAt#" />
				
					<cfcol header="Updated At" text="#updatedAt#" />
				
					<cfcol header="Deleted At" text="#deletedAt#" />
				
	<cfcol header="" text="#linkTo(text='Show', action='show', key=ID)#" />
	<cfcol header="" text="#linkTo(text='Edit', action='edit', key=ID)#" />
	<cfcol header="" text="#linkTo(text='Delete', action='delete', key=ID, confirm='Are you sure?')#" />
</cftable>

<cfoutput>
	<p>#linkTo(text="New forumvote", action="new")#</p>
</cfoutput>
