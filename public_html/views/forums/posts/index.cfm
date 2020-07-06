<h1>Listing forumposts</h1>

<cftable query="forumposts" colHeaders="true" HTMLTable="true">
	
					<cfcol header="Subject" text="#subject#" />

					<cfcol header="Post" text="#left(post,20)#" />
				
					<cfcol header="Parent Id" text="#parentId#" />
				
					<cfcol header="Forum: " text="#forum#" />
				
					<cfcol header="Created By" text="#createdBy#" />
				
					<cfcol header="Created At" text="#dateformat(createdAt)#" />
				
					<cfcol header="Updated At" text="#dateformat(updatedAt)#" />
				
	<cfcol header="" text="#linkTo(text='Show', action='show', key=id)#" />
	<cfcol header="" text="#linkTo(text='Edit', action='edit', key=id)#" />
	<cfcol header="" text="#linkTo(text='Copy', action='copy', key=id)#" />
	<cfcol header="" text="#linkTo(text='Delete', action='delete', key=id, confirm='Are you sure?')#" />
</cftable>

<cfoutput>
	<p>#linkTo(text="New forumpost", action="new")#</p>
</cfoutput>
