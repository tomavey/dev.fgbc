<h1>Listing forumvotetypes</h1>

<cftable query="forumvotetypes" colHeaders="true" HTMLTable="true">
	
					<cfcol header="Id" text="#id#" />
				
					<cfcol header="Vote" text="#vote#" />
				
					<cfcol header="Description" text="#description#" />
				
					<cfcol header="Created At" text="#createdAt#" />
				
					<cfcol header="Updated At" text="#updatedAt#" />
				
					<cfcol header="Deleted At" text="#deletedAt#" />
				
	<cfcol header="" text="#linkTo(text='Show', action='show', key=id)#" />
	<cfcol header="" text="#linkTo(text='Edit', action='edit', key=id)#" />
	<cfcol header="" text="#linkTo(text='Delete', action='delete', key=id, confirm='Are you sure?')#" />
</cftable>

<cfoutput>
	<p>#linkTo(text="New forumvotetype", action="new")#</p>
</cfoutput>
