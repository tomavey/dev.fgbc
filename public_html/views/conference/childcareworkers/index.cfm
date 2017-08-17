<div class="content">
<h1>Listing Child Care Workers</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>
	<p>#linkTo(text="New Child Care Worker Application", action="new")#</p>
</cfoutput>

<div class="table">
<cftable query="childcareworkers" colHeaders="true" HTMLTable="true">
	
			
					<cfcol header="Name" text="#fname# #lname#" />
				
					<cfcol header="City" text="#city#" />
				
					<cfcol header="Phone" text="#phone#" />
				
					<cfcol header="Email" text="#email#" />
				
					<cfcol header="Parents name" text="#parentsname#" />
				
					<cfcol header="Parents phone" text="#parentsphone#" />
				
					<cfcol header="Parents email" text="#parentsemail#" />
				
					<cfcol header="Church" text="#church#" />
				
					<cfcol header="Age" text="#age#" />
				
					<cfcol header="Created" text="#dateFormat(createdAt)#" />
				
		
	<cfcol header="" text="#showTag()#" />
	<cfcol header="" text="#editTag()#" />
	<cfcol header="" text="#deleteTag()#" />
</cftable>
</div>
</div>