<h1>Listing AGBM Regions</h1>

<cfoutput>#includePartial(partial="showFlash")#</cfoutput>

<cfoutput>
	<p>#linkTo(text="New AGBM region", action="new")#</p>
</cfoutput>

<div class="table">

<cftable query="handbookagbmregions" colHeaders="true" HTMLTable="true">
	
			
				
					<cfcol header="Name" text="#name#" />
				
					<cfcol header="Rep" text="#selectName#" />
				
					<cfcol header="Description" text="#description#" />
				
					<cfcol header="Created" text="#dateFormat(createdAt)#" />
				
		
	<cfcol header="" text="#linkTo(text='Show', action='show', key=id)#" />
	<cfcol header="" text="#linkTo(text='Edit', action='edit', key=id)#" />
	<cfcol header="" text="#linkTo(text='Delete', action='delete', key=id, confirm='Are you sure?')#" />
</cftable>

</div>