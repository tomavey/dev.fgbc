<cfoutput>
<div style="margin-top:70px;">
	<ul class="nav nav-list well">
		<li class="nav-header">Blogs</li>
		<li <cfif arguments.selected eq "home">class="active"</cfif>>#linkTo(text="Back to main page", route="root")#</li>
	</ul>
</div>
</cfoutput>
