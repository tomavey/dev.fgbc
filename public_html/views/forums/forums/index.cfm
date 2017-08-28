<h1>Listing Forums: </h1>

<cftable query="forumforums" colHeaders="true" HTMLTable="true">
	
					<cfcol header="Forum" text="#forum#" />
				
					<cfcol header="Groupcode" text="#groupcode#" />

					<cfcol header="Created By" text="#createdBy#" />
				
					<cfcol header="Created At" text="#dateformat(createdAt)#" />
				
					<cfcol header="Updated At" text="#dateformat(updatedAt)#" />
				
	<cfcol header="" text="#linkTo(text='Show', controller="forums.Posts", action='list', key=id)#" />
	<cfcol header="" text="#linkTo(text='Edit', action='edit', key=id)#" />
	<cfcol header="" text="#linkTo(text='Delete', action='delete', key=id, confirm='Are you sure?')#" />
</cftable>

<cfoutput>
	<p>#addTag()#</p>
</cfoutput>
