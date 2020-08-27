<div class="eachItemShown">



<cftable query="resources" colHeaders="true" HTMLTable="true">
	
					<cfcol header="Email" text="#mailto(email)#" />
				
					<cfcol header="Name" text="#name#" />
				
					<cfcol header="Address" text="#address#" />
				
					<cfcol header="Item" text="#item#" />
				
					<cfcol header="Quantity" text="#quantity#" />

					<cfcol header="Approved" text="#dateformat(approvedAt)#" />
				
					<cfcol header="Sent" text="#dateformat(sendAt)#" />
				
					<cfcol header="Created" text="#dateformat(createdAt)#" />
				
	<cfcol header="" text="#linkTo(text='Show', action='show', key=id)#" />
	<cfcol header="" text="#linkTo(text='Edit', action='edit', key=id)#" />
	<cfcol header="" text="#linkTo(text='Delete', action='delete', key=id, confirm='Are you sure?')#" />
</cftable>

<cfoutput>
	<p>#linkTo(text="New resource", action="new")#</p>
</cfoutput>
</div>