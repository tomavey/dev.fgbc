<h1>Listing new churches</h1>
<cfif NOT isDefined("params.showall")>
<p>Only showing verified forms.  Use the "show all" link to see all forms.</p>
</cfif>
<cfoutput>#includePartial("showFlash")#


	<p>#linkTo(text="Add a new church", route="newchurch")#</p>
	<cfif isDefined("params.showall")>
		<p>#linkTo(text="Show only verified", action="index")#</p>
	<cfelse>
		<p>#linkTo(text="Show all", action="index", params="showall")#</p>
	</cfif>
	<p>#linkto(text="Show grant eligible in #year(now())#", action="index", params="grantEligibleAt=#year(now())#")#</p>
</cfoutput>
<div class="table">
<cftable query="newchurches" colHeaders="true" HTMLTable="true">

					<cfcol header="Name" text="#fname# #lname#" />

					<cfcol header="Email" text="#mailto(email)#" />

					<cfcol header="Phone" text="#phone#" />

					<cfcol header="Church name" text="#churchname#" />

					<cfcol header="When commit?" text="#dateFormat(committedAt)#" />

					<cfcol header="FGBC?" text="#becomefgbc#" />

					<cfcol header="Grant Eligible" text="#grantEligibleAt#" />

					<cfcol header="Created" text="#dateFormat(createdAt)#" />

	<cfcol header="" text="#showTag(uuid)#" />

<cfif isOffice() || gotRights("handbookedit")>
	<cfcol header="" text="#editTag(uuid)#" />
	<cfcol header="" text="#deleteTag(uuid)#" />
	<cfcol header="" text="#handbookLink(handbookId)#"/>
</cfif>

</cftable>
<cfoutput>Count = #newchurches.recordcount#</cfoutput>
</div>

