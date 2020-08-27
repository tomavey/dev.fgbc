<cfoutput>
<div style="margin-top:70px;">
	<ul class="nav nav-list well">
		<li class="nav-header">Announcements</li>
		<li <cfif arguments.selected eq "home">class="active"</cfif>>#linkTo(text="Announcements", action="index")#</a></li>
		<li <cfif arguments.selected eq "contact">class="active"</cfif>>#linkTo(text="Contact Us", controller="about", action="contactUs")#</li>
	</ul>
</div>
</cfoutput>