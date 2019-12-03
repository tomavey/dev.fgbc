<div class="container">

<h1>Listing equip_homes</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>
	<p>#linkTo(text="New equip_home", action="new")#</p>
</cfoutput>

<div class="table">

<cftable query="homes" colHeaders="true" HTMLTable="true">
	
			
				
					<cfcol header="Id" text="#id#" />
				
					<cfcol header="Name" text="#name#" />
				
					<cfcol header="Phone" text="#phone#" />
				
					<cfcol header="Email" text="#email#" />
				
					<cfcol header="Available" text="#available#" />
				
					<cfcol header="Count" text="#count#" />
				
					<cfcol header="For Families" text="#forFamilies#" />
				
					<cfcol header="For Couples" text="#forCouples#" />
				
					<cfcol header="For Singles" text="#forSingles#" />
				
					<cfcol header="Bedrooms" text="#bedrooms#" />
				
					<cfcol header="Beds" text="#beds#" />
				
					<cfcol header="Bathrooms" text="#bathrooms#" />
				
					<cfcol header="Arrangements" text="#arrangements#" />
				
					<cfcol header="Describe" text="#describe#" />
				
					<cfcol header="Other" text="#other#" />
				
					<cfcol header="Airconditioning" text="#airconditioning#" />
				
					<cfcol header="Towells" text="#towells#" />
				
					<cfcol header="Linens" text="#linens#" />
				
					<cfcol header="Tv" text="#tv#" />
				
					<cfcol header="Wifi" text="#wifi#" />
				
					<cfcol header="Kitchen" text="#kitchen#" />
				
					<cfcol header="Breakfast" text="#breakfast#" />
				
					<cfcol header="Refrigerator" text="#refrigerator#" />
				
					<cfcol header="Washerdryer" text="#washerdryer#" />
				
					<cfcol header="Address" text="#address#" />
				
					<cfcol header="Distance" text="#distance#" />
				
					<cfcol header="Cost" text="#cost#" />
				
					<cfcol header="Approved" text="#approved#" />
				
					<cfcol header="Created At" text="#createdAt#" />
				
					<cfcol header="Deleted At" text="#deletedAt#" />
				
					<cfcol header="Updated At" text="#updatedAt#" />
				
			
		
	<cfcol header="" text="#linkTo(text='Show', action='show', key=id)#" />
	<cfcol header="" text="#linkTo(text='Edit', action='edit', key=id)#" />
	<cfcol header="" text="#linkTo(text='Delete', action='delete', key=id, confirm='Are you sure?')#" />
</cftable>

</div>
</div>
