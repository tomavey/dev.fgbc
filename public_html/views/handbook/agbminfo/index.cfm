<h1>Listing AGBM Payments</h1>

<cftable query="handbookagbminfos" colHeaders="true" HTMLTable="true">

					<cfcol header="Person" text="#lname# #fname# - #city#" />

					<cfcol header="Membership Fee" text="#membershipFee#" />

					<cfcol header="Membership Fee Year" text="#membershipFeeYear#" />

					<cfcol header="Category" text="#category#" />
					<cfif ordained>
						<cfset ol = "O">
					<cfelseif licensed>
						<cfset ol = "L">
					<cfelse>
						<cfset ol = "">
					</cfif>
					<cfcol header="O/L?" text="#ol#" />

					<cfcol header="Transaction Date" text="#dateformat(transactionDate)#" />

					<cfcol header="Created At" text="#dateformat(createdAt)#" />

	<cfcol header="" text="#showTag(personid)#" />
	<cfcol header="" text="#addTag(controller='Handbook.AgbmInfo', action="add", id=personid)#" />
	<cfcol header="" text="#deleteTag()#" />
</cftable>

<cfoutput>
	<p>#linkTo(text="New handbookagbminfo", action="new")#</p>
</cfoutput>
