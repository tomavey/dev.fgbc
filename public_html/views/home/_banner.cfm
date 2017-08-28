<cfoutput>
<ul class="rslides">
	<cfif isBefore("July 27, 2017")>
	<li>#linkto(text=imageTag("newLayout/access2017c.png"), href="http://www.access2017.com")#</li>
	<li>#linkto(text=imageTag("newLayout/momentum.png"), href="http://buildmomentum.org/")#</li>
	</cfif>
	<li>#linkto(text=imageTag("newLayout/banner-placeholder.png"), controller="about", action="cci")#</li>
	<li>#linkTo(text=imageTag("newLayout/commoncommitment.png"), controller="about", action="commoncommitment")#</li>
	<li>#linkTo(text=imageTag("newLayout/map.png"), controller="churches", action="index")#</li>
</ul>

</cfoutput>