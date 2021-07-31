<div class="container">


	<h1>Listing rights</h1>
	<cfoutput>
		<p>#addTag()#</p>

		[#linkTo(text="Groups", controller="auth.groups", action="index")#]
		[#linkTo(text="Users", controller="auth.users", action="index")#]
	</cfoutput>

	<div class="table">
		<cftable query="rights" colHeaders="true" HTMLTable="true">	
			<cfcol header="Name" text="#name#" />				
			<cfcol header="Description" text="#description#" />
			<cfcol header="" text="#showTag()#" />
			<cfcol header="" text="#editTag()#" />
			<cfcol header="" text="#deleteTag(class="noajax")#" />
		</cftable>
	</div>

	<cfoutput>
		<p>#addTag()#</p>
	</cfoutput>


</div>