<h1>Listing Coursequestions</h1>

<cfoutput>#includePartial(partial="showFlash")#</cfoutput>

<cfoutput>
	<p>#linkTo(text="New Cohort Question", action="new")#</p>
</cfoutput>

<cftable query="Coursequestions" colHeaders="true" HTMLTable="true">
	
			
					<cfcol header="Person: " text="#fullNameLastFirst#" />
				
					<cfcol header="Course: " text="#Conferencecoursetitle#" />
				
					<cfcol header="Question" text="#left(question,20)#..." />
				
					<cfcol header="Created At" text="#dateFormat(createdAt)#" />
				
					<cfcol header="Sortorder" text="#sortorder#" />
				
					<cfcol header="Approved" text="#approved#" />
				
		
	<cfcol header="" text="#showTag()#" />
	<cfcol header="" text="#editTag()#" />
	<cfcol header="" text="#deleteTag()#" />
</cftable>

