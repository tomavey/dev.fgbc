<h1>Listing handbookpositions</h1>

<cftable query="handbookpositions" colHeaders="true" HTMLTable="true">
	
					<cfcol header="Personid" text="#personid#" />
				
					<cfcol header="Organizationid" text="#organizationid#" />
				
					<cfcol header="Position" text="#position#" />
				
					<cfcol header="Position2" text="#position2#" />
				
					<cfcol header="Positiontypeid" text="#positiontypeid#" />
				
					<cfcol header="Updated At" text="#updatedAt#" />
				
					<cfcol header="Created At" text="#createdAt#" />
				
					<cfcol header="Deleted At" text="#deletedAt#" />
				
	<cfcol header="" text="#linkTo(text='Show', action='show', key=personid,organizationid)#" />
	<cfcol header="" text="#linkTo(text='Edit', action='edit', key=personid,organizationid)#" />
	<cfcol header="" text="#linkTo(text='Delete', action='delete', key=personid,organizationid, confirm='Are you sure?')#" />
</cftable>

<cfoutput>
	<p>#linkTo(text="New handbookposition", action="new")#</p>
</cfoutput>
