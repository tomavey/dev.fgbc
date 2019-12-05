<cfparam name="sortby"  default="createdAt">
<cfparam name="direction" default="DESC">
<cfif isDefined("params.direction") && params.direction == "ASC">
	<cfset direction = "DESC">
</cfif>
<cfif isDefined("params.direction") && params.direction == "DESC">
	<cfset direction = "ASC">
</cfif>

<div class="container">
<cfoutput>
	<h1>List of host homes</h1>
	<p>Sorted by #direction# on #sortby#</p>
	#includePartial("showFlash")#

	<p>#linkTo(text="Add a new host home", route="accessHostHomes", class="btn")#</p>
	<p>#linkTo(text="Show Public List of Approved Host Homes", action="list", class="btn")#</p>
	<p>#linkTo(text="Edit the Thank You Screen", action="thankyou", class="btn")#</p>
</cfoutput>

<div class="table table-striped">

<cftable query="homes" colHeaders="true" HTMLTable="true">
				
				<cfcol header="#linkto(text="ID", action="index", params='sortby=homeid&direction=#direction#')#" text="#homeid#" />

				<cfcol header="#linkto(text="Name", action="index", params='sortby=name&direction=#direction#')#" text="#name#" />
				
				<cfcol header="Phone" text="#phone#" />
			
				<cfcol header="Email" text="#mailto(email)#" />
				
				<cfcol header="#linkto(text="Status", action="index", params='sortby=status&direction=#direction#')#" text="#status#" />
				
				<cfcol header="Approved" text="#linkTo(text=approved, action="approve", key=#id#)#" />
				
				<cfcol header="Guest Assigned To" text="#AssignedToName#" />

				<cfcol header="Guest Email" text="#AssignedToEmail#" />

				<cfcol header="#linkto(text="Date", action="index", params='sortby=createdAt&direction=#direction#')#" text="#dateFormat(createdAt)#" />
		
	<cfcol header="" text="#showTag()#" />
	<cfcol header="" text="#editTag()#" />
	<cfcol header="" text="#deleteTag()#" />
</cftable>

</div>
</div>
