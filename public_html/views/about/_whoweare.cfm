<cfparam name="arguments.selected" default="">
<cfoutput>
<div style="margin-top:70px;">
	<ul class="nav nav-list well">
		<li class="nav-header">About Us!</li>
		<li <cfif arguments.selected eq "common">class="active"</cfif>>#linkTo(text="Our Common Identity", route="cci")#</li>
		<li <cfif arguments.selected eq "common">class="active"</cfif>>#linkTo(text="Our Common Commitment", controller="About", action="commoncommitment")#</li>
		<li <cfif arguments.selected eq "story">class="active"</cfif>>#linkTo(text="Our Story", controller="About", action="ourStory")#</li>
		<li <cfif arguments.selected eq "constitution">class="active"</cfif>>#linkTo(text="Our Constitution", controller="About", action="constitution")#</li>
		<li <cfif arguments.selected eq "manual">class="active"</cfif>>#linkTo(text="Our Manual of Procedure", controller="About", action="manualOfProcedure")#</li>
		<li <cfif arguments.selected eq "resolutions">class="active"</cfif>>#linkTo(text="Resolutions - 2017", controller="contents", action="show", key=106)#</li>
		<li <cfif arguments.selected eq "fellowshipcouncil">class="active"</cfif>>#linkTo(text="The Fellowship Council", controller="contents", action="show", key=22)#</li>
		<li <cfif arguments.selected eq "contact">class="active"</cfif>>#linkTo(text="Contact Us", controller="Messages", action="new")#</li>
	</ul>
</div>
</cfoutput>