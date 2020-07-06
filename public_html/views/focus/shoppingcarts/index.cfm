<h1>Listing shoppingcarts</h1>
<p>These are the tenmporary shopping carts that are used during registration.  They are not the same as a final registration.</p>
<!--- <cfdump var="#shoppingcarts#"><cfabort> --->

<cftable query="shoppingcarts" colHeaders="true" HTMLTable="true">
	
					<cfcol header="Id" text="#linkto(text=#id#, controller="focus.shoppingcarts", action="show", key=#id#)#" />
				
					<cfcol header="Fname" text="#fname#" />
				
					<cfcol header="Lname" text="#lname#" />
				
					<cfcol header="Email" text="#mailto(email)#" />
				
					<cfcol header="Items (by id)" text="#items#" />
				
					<cfcol header="Created:" text="#dateformat(createdAt, 'short')#" />
				
				
	<cfcol header="" text="#linkTo(text="<i class='fa fa-search'></i>", action='show', key=id)#" />
	<cfcol header="" text="#linkTo(text="<i class='fa fa-pencil'></i>", action='edit', key=id)#" />
	<cfcol header="" text="#linkTo(text="<i class='fa fa-trash'></i>", action='delete', key=id, confirm='Are you sure?')#" />
</cftable>

<cfoutput>
	<p>#linkTo(text="New shoppingcart", action="new")#</p>
</cfoutput>
