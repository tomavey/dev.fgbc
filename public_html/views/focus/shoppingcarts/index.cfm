<h1>Listing shoppingcarts</h1>

<cftable query="shoppingcarts" colHeaders="true" HTMLTable="true">
	
					<cfcol header="Id" text="#id#" />
				
					<cfcol header="Retreat" text="#retreat#" />
				
					<cfcol header="Fname" text="#fname#" />
				
					<cfcol header="Lname" text="#lname#" />
				
					<cfcol header="Email" text="#email#" />
				
					<cfcol header="Phone" text="#phone#" />
				
					<cfcol header="Roommate" text="#roommate#" />
				
					<cfcol header="Items" text="#items#" />
				
					<cfcol header="Quantities" text="#quantities#" />
				
					<cfcol header="Shoppingcartid" text="#shoppingcartid#" />
				
					<cfcol header="Created At" text="#createdAt#" />
				
					<cfcol header="Updated At" text="#updatedAt#" />
				
					<cfcol header="Deleted At" text="#deletedAt#" />
				
	<cfcol header="" text="#linkTo(text='Show', action='show', key=id)#" />
	<cfcol header="" text="#linkTo(text='Edit', action='edit', key=id)#" />
	<cfcol header="" text="#linkTo(text='Delete', action='delete', key=id, confirm='Are you sure?')#" />
</cftable>

<cfoutput>
	<p>#linkTo(text="New shoppingcart", action="new")#</p>
</cfoutput>
