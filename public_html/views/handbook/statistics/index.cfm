<cfoutput>
<h1>Listing Statistics for #statYear# and Memfee for #statyear+1#</h1>

<div>

<p>#linkTo(text="<i class='icon-plus'></i>", action="new", title="Add new Stat")#</p>

<p>
	<cfif !isDefined("params.temp")>
		#linkTo(text="Show Temp Only", controller="handbook.statistics", action="index", params="temp=1", class="btn")#
	<cfelse>
		#linkTo(text="Show All", controller="handbook.statistics", action="index", class="btn")#
	</cfif>
</p>
#linkto(text='Show All Detail for #statyear#', controller="handbook.statistics", action="show", class="btn")#
</cfoutput>

</div>

<div class="table table-striped">
<cftable query="handbookstatistics" colHeaders="true" HTMLTable="true">

					<cfcol header="Name: " text="#selectname#" />

					<cfcol header="Att: " text="#att#" />

					<cfcol header="Ss: " text="#ss#" />

					<cfcol header="Conv: " text="#conversions#" />

					<cfcol header="Bapt: " text="#baptisms#" />

					<cfcol header="Mem: " text="#members#" />

					<cfcol header="Yr: " text="#year#" />

					<cfcol header="Total: " text="#dollarformat(memfee)#" />

					<cfcol header="Donation: " text="#dollarformat(donate)#" />

					<cfcol header="Relief: " text="#dollarformat(relief)#" />

					<cfcol header="Ck##" text="#checkno#" />

					<cfcol header="Date: " text="#dateformat(date,'mm-dd-yy')#" />

					<cfcol header="Submitted By: " text="#submittedBy#" />

					<cfcol header="Status: " text="#enteredBy#" />

					<cfif gotRights("superadmin,office")>
						<cfcol header="&nbsp;" text="#showTag(handbookstatistics.id)#&nbsp;#editTag()#&nbsp;#deleteTag(class="notajax")##iif(comment=='test',DE('TEST'),'')#" />
						<cfcol header="&nbsp;" text="#linkto(text='<i class="icon-th-list" />', controller="handbook.statistics", action="list", key=handbookstatistics.organizationid)#" />
					</cfif>
</cftable>
</div>
<cfif gotRights("office")>
<cfoutput>
	<p>#linkTo(text="<i class='icon-plus'></i>", action="new")#</p>
</cfoutput>
</cfif>
