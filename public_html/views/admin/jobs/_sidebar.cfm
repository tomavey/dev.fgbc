<cfoutput>
<div style="margin-top:70px;">
	<ul class="nav nav-list well">
		<li class="nav-header">Opportunities</li>
		<li <cfif arguments.selected eq "home">class="active"</cfif>>#linkTo(text="Go back to main page", route="root")#</a></li>
		<li <cfif arguments.selected eq "contact">class="active"</cfif>>#linkTo(text="Contact Us", controller="About", action="contactUs")#</li>
	</ul>
</div>
</cfoutput>