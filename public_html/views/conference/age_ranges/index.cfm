<h1>Listing age_ranges</h1>

<cftable query="age_ranges" colHeaders="true" HTMLTable="true">
	
					<cfcol header="Id" text="#id#" />
				
					<cfcol header="Name" text="#name#" />
				
					<cfcol header="Description" text="#description#" />
				
					<cfcol header="Type" text="#type#" />
				
				
	<cfcol header="" text="#linkTo(text='Show', action='show', key=id)#" />
	<cfcol header="" text="#linkTo(text='Edit', action='edit', key=id)#" />
	<cfcol header="" text="#linkTo(text='Delete', action='delete', key=id, confirm='Are you sure?')#" />
</cftable>

<cfoutput>
	<p>#linkTo(text="New age_range", action="new")#</p>
</cfoutput>
