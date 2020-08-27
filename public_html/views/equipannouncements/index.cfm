<h1>Listing equipannouncements</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>
	<p>#linkTo(text="New equipannouncement", action="new")#</p>
</cfoutput>

<cftable query="equipannouncements" colHeaders="true" HTMLTable="true">
	
			
				
					<cfcol header="Id" text="#id#" />
				
					<cfcol header="Uuid" text="#uuid#" />
				
					<cfcol header="Event" text="#event#" />
				
					<cfcol header="Subject" text="#subject#" />
				
					<cfcol header="Content" text="#content#" />
				
					<cfcol header="Link" text="#link#" />
				
					<cfcol header="Author" text="#author#" />
				
					<cfcol header="Approved" text="#approved#" />
				
					<cfcol header="Post At" text="#postAt#" />
				
					<cfcol header="Send Type" text="#sendType#" />
				
					<cfcol header="Sent At" text="#sentAt#" />
				
					<cfcol header="Created At" text="#createdAt#" />
				
					<cfcol header="Updated At" text="#updatedAt#" />
				
					<cfcol header="Deleted At" text="#deletedAt#" />
				
			
		
	<cfcol header="" text="#linkTo(text='Show', action='show', key=id)#" />
	<cfcol header="" text="#linkTo(text='Edit', action='edit', key=id)#" />
	<cfcol header="" text="#linkTo(text='Delete', action='delete', key=id, confirm='Are you sure?')#" />
</cftable>

