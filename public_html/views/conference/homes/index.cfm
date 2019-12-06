<cfparam name="sortby"  default="createdAt">
<cfparam name="direction" default="DESC">
<cfparam name="type" default="Host">

<style>
	form {display:inline}
</style>
<cfif isDefined("params.direction") && params.direction == "ASC">
	<cfset direction = "DESC">
</cfif>
<cfif isDefined("params.direction") && params.direction == "DESC">
	<cfset direction = "ASC">
</cfif>

<div class="container">
<cfoutput>
	<h1>List of #type# homes</h1>
	<cfif type=="host">
		#linkTo(text="Show Guest Requests", params="type=guest")#
	<cfelse>	
		#linkTo(text="Show Host Homes", params="type=host")#
	</cfif>
	<p>Sorted by #direction# on #sortby#</p>
	#includePartial("includes/showFlash")#
	<div style="float:right">
		#startFormTag(route="ConferenceHomesIndex", onlyPath=false, method="get")#
		#textFieldTag(name='search', placeholder="Search")#
		#endFormTag()#
	</div>
	<p>#linkTo(text="Add a new host home", route="accessHostHomes", class="btn")#&nbsp;
		#linkTo(text="Add a new guest request", route="accessHostHomes", params="type=guest", class="btn")#&nbsp;
		#linkTo(text="Show Public List of Approved Host Homes", action="list", class="btn")#&nbsp;
		#linkTo(text="View the Thank You Message", action="thankyou", class="btn")#
	</p>

</cfoutput>

<div class="table table-striped">

<cftable query="homes" colHeaders="true" HTMLTable="true">
				
	<cfif type=="host">
		<cfcol header="#linkto(text="ID", action="index", params='sortby=homeid&direction=#direction#')#" text="#homeid#" />
	</cfif>		

		<cfcol header="#linkto(text="Name", action="index", params='sortby=name&direction=#direction#')#" text="#name#" />
		
		<cfcol header="Phone" text="#phone#" />
	
		<cfcol header="Email" text="#mailto(email)#" />
		
		<cfcol header="#linkto(text="Status", action="index", params='sortby=status&direction=#direction#')#" text="#status#" />

	<cfif type=="host">

		<cfcol header="Approved" text=
		"#linkTo(
			text=approvedText(approved,approvedAt), 
			action="approve", 
			key=#id#)#
		" />
	
		<cfcol header="Guest Assigned" text="#AssignedToName#" />

		<cfcol header="Guest Email" text="#AssignedToEmail#" />

	</cfif>	

	<cfif type=="guest">

		<cfcol header="Requested Home" text="#getHostSelectNameFromRequestedHomeId(requestedHomeId)#" />

	</cfif>


		<cfcol header="#linkto(text="Date", action="index", params='sortby=createdAt&direction=#direction#')#" text="#dateFormat(createdAt)#" />
		
	<cfcol header="" text="#showTag()#" />
	<cfcol header="" text="#editTag()#" />
	<cfcol header="" text="#deleteTag()#" />

</cftable>
<!--- <cfdump var="#params#"> --->
</div>
</div>
