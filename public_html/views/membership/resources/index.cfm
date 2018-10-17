<cfoutput>
<h1>Documents uploaded...</h1>

<cfdump var="#params#"><cfabort>


<cfif len(getChurchAppName(params.key)) EQ 5>
	<p>For #linkTo(text=getChurchAppName(params.key), controller="membership.applications", action="show", key=params.key)#</p>
</cfif>

#includePartial("showFlash")#

	<p>#linkTo(text="Upload A New Document", controller="membership.resources", action="new")#</p>

</cfoutput>


<div class="table">
<cftable query="membershipappresources" colHeaders="true" HTMLTable="true">
	
					<cfcol header="App" text="#linkTo(text=getChurchAppName(applicationid), controller="membership.applications", action="show", key=applicationuuid)#" />
				
					<cfcol header="Uploaded Item" text="#linkTo(text=description, href='/files/#file#')#" />
				
					<cfcol header="Created" text="#dateFormat(createdAt)#" />
				
		
	<cfcol header="" text="
		#linkTo(
			text='<i class="icon-trash"></i>', 
			action='delete', 
			key=ID, 
			method="delete",
			class="tooltip2",
			title="Delete this resource!",
			onclick="return confirm('Are you sure?')")#" />

</cftable>
</div>
