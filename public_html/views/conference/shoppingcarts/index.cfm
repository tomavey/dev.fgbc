<h1>Listing equip_shoppingcarts</h1>

<cftable query="equip_shoppingcarts" colHeaders="true" HTMLTable="true">
	
					<cfcol header="Id" text="#id#" />
				
					<cfcol header="Cart ID" text="#cartID#" />
				
					<cfcol header="Owner" text="#owner#" />
				
					<cfcol header="Person" text="#person#" />
				
					<cfcol header="Item" text="#item#" />
				
					<cfcol header="Quantity" text="#quantity#" />
				
					<cfcol header="Type1" text="#type1#" />
				
					<cfcol header="Type2" text="#type2#" />
				
					<cfcol header="Createdat" text="#createdat#" />
				
					<cfcol header="Updatedat" text="#updatedat#" />
				
					<cfcol header="Deletedat" text="#deletedat#" />
				
	<cfcol header="" text="#linkTo(text='Show', action='show', key=id)#" />
	<cfcol header="" text="#linkTo(text='Edit', action='edit', key=id)#" />
	<cfcol header="" text="#linkTo(text='Delete', action='delete', key=id, confirm='Are you sure?')#" />
</cftable>

<cfoutput>
	<p>#linkTo(text="New equip_shoppingcart", action="new")#</p>
</cfoutput>
