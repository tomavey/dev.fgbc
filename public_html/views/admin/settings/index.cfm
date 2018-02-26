<div class="container">
	<h1>Listing settings</h1>

	<cfoutput>#includePartial("showFlash")#</cfoutput>

	<cfoutput>
		<p>#linkTo(text="New setting", action="new")#</p>
	</cfoutput>

	<div class="table table-striped">
		<cftable query="settings" colHeaders="true" HTMLTable="true">
			
						
							<cfcol header="Variable" text="#name#" />
						
							<cfcol header="Value" text="#value#" />
						
							<cfcol header="Description" text="#description#" />
						
							<cfcol header="Created" text="#dateFormat(createdAt)#" />
						
							<cfcol header="Updated" text="#dateFormat(updatedAt)#" />
						
				
			<cfcol header="&nbsp;" text="#linkTo(text='Show', action='show', key=id)#" />
			<cfcol header="&nbsp;" text="#linkTo(text='Edit', action='edit', key=id)#" />
			<cfcol header="&nbsp;" text="#linkTo(text='Delete', action='delete', key=id, confirm='Are you sure?')#" />
		</cftable>
	</div>
</div>
