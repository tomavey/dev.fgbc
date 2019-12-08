<cfparam name="sortby"  default="createdAt">
<cfparam name="direction" default="DESC">
<cfparam name="type" default="Host">

<style>
	.host-search-form {display:inline}
</style>
<cfif isDefined("params.direction") && params.direction == "ASC">
	<cfset direction = "DESC">
</cfif>
<cfif isDefined("params.direction") && params.direction == "DESC">
	<cfset direction = "ASC">
</cfif>

<div class="container" style="background-color:white;padding:20px;border-radius:10px">
<cfoutput>
	#includePartial("includes/navbar")#
	<h1>List of #type# homes</h1>
	<p>Sorted by #direction# on #sortby#</p>

	#includePartial("includes/showFlash")#


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
		
		<cftry>
			<cfset headerText=getHostSelectNameFromRequestedHomeId(requestedHomeId)>
		<cfcatch>
			<cfset headerText="None">
		</cfcatch>	

		</cftry>
		<cfcol header="Requested Home" text="#headerText#" />

	</cfif>


		<cfcol header="#linkto(text="Date", action="index", params='sortby=createdAt&direction=#direction#')#" text="#dateFormat(createdAt)#" />
		
	<cfcol header="" text="#showTag()#" />
	<cfcol header="" text="#editTag()#" />
	<cfcol header="" text="#deleteTag()#" />

</cftable>
<!--- <cfdump var="#params#"> --->
</div>
</div>
