<h1>Listing forum resources:</h1>

<cftable query="forumresources" colHeaders="true" HTMLTable="true">
	
					<cfcol header="Forum:" text="#forum#" />
				
					<cfcol header="File: " text="#linkTo(text=file, href='http://www.fgbc.org/files/#file#')#" />
				
					<cfcol header="Description: " text="#left(description,15)#" />
				
					<cfcol header="Createdby" text="#mailTo(createdby)#" />
				
					<cfcol header="Createdat" text="#dateformat(createdat)#" />
				
	<cfcol header="" text="#linkTo(text='Show', action='show', key=id)#" />
	<cfcol header="" text="#linkTo(text='Edit', action='edit', key=id)#" />
	<cfcol header="" text="#linkTo(text='Delete', action='delete', key=id, confirm='Are you sure?')#" />
</cftable>

<cfoutput>
	<p>#linkTo(text="New forumresource", action="new")#</p>
</cfoutput>
