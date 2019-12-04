<div class="container">

<h1>Listing equip_homes</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>
	<p>#linkTo(text="Add a new host home", action="new", class="btn")#</p>
</cfoutput>

<div class="table table-striped">

<cftable query="homes" colHeaders="true" HTMLTable="true">
	
			
				
					<cfcol header="Name" text="#name#" />
				
					<cfcol header="Phone" text="#phone#" />
				
					<cfcol header="Email" text="#email#" />
				
					<cfcol header="Bedrooms" text="#bedrooms#" />
				
					<cfcol header="Distance" text="#distance#" />
				
					<cfcol header="Approved" text="#approved#" />
				
					<cfcol header="Date" text="#dateFormat(createdAt)#" />
				
				
			
		
	<cfcol header="" text="#showTag()#" />
	<cfcol header="" text="#editTag()#" />
	<cfcol header="" text="#deleteTag()#" />
</cftable>

</div>
</div>
