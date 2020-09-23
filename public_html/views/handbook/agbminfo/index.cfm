<h1>Listing ALL AGBM Payments</h1>

<cftable query="payments" colHeaders="true" HTMLTable="true">

					<cfcol header="Person" text="#lname# #fname# - #city#" />

					<cfcol header="Membership Fee" text="#membershipFee#" />

					<cfcol header="Membership Fee Year" text="#membershipFeeYear#" />

					<cfcol header="Category" text="#category#" />

					<cfcol header="Transaction Date" text="#dateformat(transactionDate)#" />

					<cfcol header="Created At" text="#dateformat(createdAt)#" />

	<cfcol header="" text="#showTag(personid)#" />
	<cfcol header="" text="#addTag(controller='Handbook.AgbmInfo', action="add", id=personid)#" />
	<cfcol header="" text="#deleteTag()#" />
</cftable>

<cfoutput>
	<p>#linkTo(text="New handbookagbminfo", action="new")#</p>
</cfoutput>
