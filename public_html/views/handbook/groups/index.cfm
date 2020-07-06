<h1>Listing handbookgroups</h1>

<cftable query="handbookgroups" colHeaders="true" HTMLTable="true">
	
					<cfcol header="Id" text="#id#" />
				
					<cfcol header="Person Id" text="#personId#" />
				
					<cfcol header="Grouptype Id" text="#grouptypeId#" />
				
	<cfcol header="" text="#linkTo(text='Show', action='show', key=id)#" />
	<cfcol header="" text="#linkTo(text='Edit', action='edit', key=id)#" />
	<cfcol header="" text="#linkTo(text='Delete', action='delete', key=id, confirm='Are you sure?')#" />
</cftable>

<cfoutput>
	<p>#linkTo(text="New handbookgroup", action="new")#</p>
</cfoutput>
