<h1>FGBC Membership Applications</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>
	<p>#linkTo(text="Start a new app", action="checkin", class="btn")#</p>
	<cfif isDefined("params.showall")>
		<p>#linkTo(text="Show Current", params="")#</p>
	<cfelse>
		<p>#linkTo(text="Show All", params="showall=true")#</p>
	</cfif>
</cfoutput>

<div class="table">

<cftable query="membershipapplications" colHeaders="true" HTMLTable="true">

					<cfcol header="Church" text="#name_of_church#" />

					<cfcol header="City" text="#city#" />

					<cfcol header="State" text="#getState(stateid)#" />

					<cfcol header="Email" text="#mailTo(useremail)#" />

					<cfcol header="Leader" text="#principle_leader#" />

					<cfcol header="Assigned To" text="#assignedTo#" />

					<cfcol header="Commission Approved" text="#dateformat(approved_by_commission,'medium')#" />

					<cfcol header="FC Approved" text="#dateformat(approved_by_fc,'medium')#" />

					<cfcol header="Created At" text="#dateformat(createdAt,'medium')# - #timeformat(createdAt,'short')#" />

	<cfcol header="" text="#linkTo(text='<i class="icon-eye-open"></i>', action='show', key=ID, class="tooltip2", title="View")#" />
	<cfif gotRights("superadmin,office,handbookedit")>
		<cfcol header="" text="#linkTo(text='<i class="icon-edit"></i>', action='edit', key=ID, class="tooltip2", title="Edit")#" />
		<cfcol header=""
			text="
				#linkTo
					(
					text='<i class="icon-trash"></i>',
					action='delete',
					method="delete",
					key=ID,
					class="tooltip2",
					title="Delete",
					onclick="return	confirm('Are you sure that you want to delete the application for #name_of_church#?');"
					)
					#"
		/>
		<cftry>
		<cfcol header="" text="#linkTo(text='<i class="icon-share"></i>', controller="membership.applications", action="checkin", key=uuid, onlyPath=false, title="check in")#" />
		<cfcatch></cfcatch></cftry>
		<cfcol header="" text="#handbookLink(handbookid)#"/>

	</cfif>
</cftable>
</div>

