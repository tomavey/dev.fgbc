<cfoutput>
<div style="margin-top:70px;">
	<ul class="nav nav-list well">
		<li class="nav-header">About Us</li>
		<li <cfif arguments.selected eq "statement">class="active"</cfif>>#linkTo(text="Our Statement of Faith", controller="NewLayout", action="statementoffaith")#</a></li>
		<li <cfif arguments.selected eq "common">class="active"</cfif>><a href="/commoncommitment" target="_new">Our Common Commitment</a></li>
		<li <cfif arguments.selected eq "story">class="active"</cfif>>#linkTo(text="Our Story", controller="newLayout", action="story")#</li>
		<li <cfif arguments.selected eq "constitution">class="active"</cfif>>#linkTo(text="Our Constitution", controller="newLayout", action="constitution")#</li>
		<li <cfif arguments.selected eq "manual">class="active"</cfif>>#linkTo(text="Our Manual of Procedure", controller="newLayout", action="manualofprocedure")#</li>
		<li <cfif arguments.selected eq "contact">class="active"</cfif>>#linkTo(text="Contact Us", controller="newLayout", action="contact")#</li>
	</ul>
</div>
</cfoutput>