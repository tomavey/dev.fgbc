<div class="postbox" id=#params.controller##params.action#>

<h1>Listing Groups</h1>

<cftable query="handbookgrouptypes" colHeaders="true" HTMLTable="true">
	
					<cfcol header="Title" text="#linkTo(text=title, action="show", key=id)#" />
				
					<cfcol header="Description" text="#comments#" />
				
<cfif gotrights("superadmin")>				
	<cfcol header="" text="#showTag()#" />
	<cfcol header="" text="#editTag()#" />
	<cfcol header="" text="#deleteTag()#" />
</cfif>	

</cftable>


<cfif gotrights("superadmin")>				
	<cfoutput>
		<p>#addTag()#</p>
	</cfoutput>
</cfif>	
</div>
