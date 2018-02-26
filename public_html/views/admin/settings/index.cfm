<div class="container">
	<h1>Listing settings</h1>

	<cfoutput>#includePartial("showFlash")#</cfoutput>

	<cfoutput>
		<p>#linkTo(text="New setting", action="new")#</p>
	</cfoutput>

	<div class="table table-striped">
		<cftable query="settings" colHeaders="true" HTMLTable="true">
			
						
							<cfcol header="Variable" text="#name#" />
						
							<cfcol header="Value" text="#value#" />
						
							<cfcol header="Description" text="#description#" />
						
							<cfcol header="Category" text="#Category#" />

							<cfcol header="Created" text="#dateFormat(createdAt)#" />
						
							<cfcol header="Updated" text="#dateFormat(updatedAt)#" />
						
				
			<cfcol header="&nbsp;" text="#showTag()#" />
			<cfcol header="&nbsp;" text="#editTag()#" />
			<cfcol header="&nbsp;" text="#deleteTag(class="noajax")#" />
		</cftable>
	</div>
	<div>
	<cfoutput>
	<p>Actual Application settings:</p>
		<cfoutput query="settings">
		<ul>
			<cftry>
				<li>#name# - #application.wheels[name]#</li>
			<cfcatch>
			</cfcatch>
			</cftry>
		</ul>	
		</cfoutput>
	</cfoutput>	
	</div>
</div>
