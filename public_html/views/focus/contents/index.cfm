<h1>Use this page to change the information on the welcome page...</h1>
<div class="table table-striped">

	<cftable query="contents" colHeaders="true" HTMLTable="true">
		
		<cfcol header="Id" text="#id#" />

		<cfcol header="Name" text="#name#" />

		<cfcol header="Content" text="#left(content,25)#" />

		<cfcol header="Author" text="#author#" />

		<cfcol header="Comment" text="#left(comment,10)#" />
					
		<cfcol header="" text="#linkto(text="<i class='fa fa-search'></i>", controller='focus.contents', action='show', key=id)#" />

		<cfcol header="" text="#linkto(text="<i class='fa fa-pencil-square'></i>", controller='focus.contents', action='edit', key=id)#" />

	</cftable>
<cfoutput>
	#linkto(text="Edit logo", controller="admin.Settings", action="index", params="category=focus")#
	<p>Note: Change the setting for "FocusLogo". Hint: Use the #linkto(text="PICS", controller="admin.Pics", action="index")# page to upload the logo to our server.</p>
</cfoutput>	

</div>

<cfoutput>
<!--- 	<p>#linkTo(text="New content", action="new")#</p> --->
</cfoutput>
