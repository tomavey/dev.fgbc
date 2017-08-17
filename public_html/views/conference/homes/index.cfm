<div class="eachItemShown">
<h1>Listing hospitality requests:</h1>

<cftable query="homes" colHeaders="true" HTMLTable="true">
	
					<cfcol header="Name" text="#lname#, #fname# <em>#sname#</em>" />
				
					<cfcol header="Location" text="#city#, #state#" />
				
					<cfcol header="Home Phone" text="#hphone#" />
				
					<cfcol header="Cell Phone" text="#cphone#" />
				
					<cfcol header="Email" text="#email#" />
				
					<cfcol header="Dates" text="#dates#" />
				
					<cfcol header="Children" text="#children#" />
				
					<cfcol header="Submitted" text="#dateformat(createdAt,'medium')#" />
				
				
	<cfcol header="" text="#linkTo(text='Show', action='show', key=id)#" />
		<cfcol header="" text="#linkTo(text='Edit', action='edit', key=id)#" />
		<cfcol header="" text="#linkTo(text='Delete', action='delete', key=id, confirm='Are you sure?')#" />
</cftable>

<cfoutput>
	<p>#linkTo(text="New home", action="new")#</p>
</cfoutput>
</div>
