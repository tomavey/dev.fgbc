<cfoutput>
<h1>Listing Statistics for #statYear# and Memfee for #statyear+1#</h1>

<p>#linkTo(text="<i class='icon-plus'></i>", action="new", title="Add new Stat")#</p>
</cfoutput>

<div class="table table-striped">
<cftable query="handbookstatistics" colHeaders="true" HTMLTable="true">

					<cfcol header="Name: " text="#selectname#" />

					<cfcol header="Att: " text="#att#" />

					<cfcol header="Ss: " text="#ss#" />

					<cfcol header="Conv: " text="#conversions#" />

					<cfcol header="Bapt: " text="#baptisms#" />

					<cfcol header="Mem: " text="#members#" />

					<cfcol header="Yr: " text="#year#" />

					<cfcol header="Fee: " text="#dollarformat(memfee)#" />

					<cfcol header="Ck##" text="#checkno#" />

					<cfcol header="Date: " text="#dateformat(date)#" />

					<cfcol header="Submitted By: " text="#submittedBy#" />

					<cfcol header="Entered By: " text="#enteredBy#" />

					<cfcol header="Created: " text="#dateFormat(createdAt)#" />

					<cfif gotRights("superadmin,office")>
						<cfcol header="" text="#showTag(organizationid)#" />
						<cfcol header="" text="#editTag()#" />
						<cfcol header="" text="#deleteTag(class="notajax")#" />
					</cfif>
</cftable>
</div>
<cfif gotRights("office")>
<cfoutput>
	<p>#linkTo(text="<i class='icon-plus'></i>", action="new")#</p>
</cfoutput>
</cfif>
