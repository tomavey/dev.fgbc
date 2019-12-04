<div class="container">
<cfoutput>

	<h1>Showing home</h1>

	#includePartial("showFlash")#

	<!--- <cfdump var="#home.properties()#"><cfabort> --->

	<div class="homes homes-contactinfo">
		<p>
			<span>Name: </span> #home.name#
		</p>
		<p>
			<span>Phone: </span> #home.phone#
		</p>
		<p>
			<span>Email: </span> #home.email#
		</p>
		<p>
			<span>Email: </span> #home.email#
		</p>
	</div>

	<div class="homes homes-availabilityinfo">
		<p><span>Is your home available July 22-26, 2019?</span>#home.available#</p>
		<p><span>How many people?</span>#home.howmany#</p>
		<p><span>My home is best for: </span>
			<cfif home.forFamilies>Families |</cfif> 
			<cfif home.forCouples>Couples |</cfif> 
			<cfif home.forSingles>Singles</cfif>
		</p>
	</div>

	<div class="homes homes-detailsinfo">
		<p><span>How many bedrooms are available?</span>#home.bedrooms#</p>
		<p><span>How many beds are available?</span>#home.beds#</p>
		<p><span>How many bathrooms are available?</span>#home.bathrooms#</p>
		<p><span>What are the sleeping arrangements?</span>#home.arrangements#</p>
		<p><span>Other details to note:</span>#home.other#</p>
		<p><span>Amenities available:</span>
			<cfif home.airconditioning>A/C |</cfif>
			<cfif home.towels>Towels |</cfif>
			<cfif home.linens>Linens</cfif>
			<cfif home.tv>TV</cfif>
			<cfif home.wifi>WiFi</cfif>
			<cfif home.kitchen>Kitchen</cfif>
			<cfif home.breakfast>Breakfast</cfif>
			<cfif home.refrigerator>Refrigerator</cfif>
			<cfif home.washerdryer>Washerdryer</cfif>
		</p>
		<p><span>What are the sleeping arrangements?</span>#home.arrangements#</p>
		<p><span>Distance from Grace College campus?</span>#home.distance#</p>
		<p><span>Cost (per night)?</span>#home.cost#</p>
		<p><span>Date this home was added?</span>#dateformat(home.createdAt)#</p>
	</div>	

	<div class="homes homes-office">
		<p><span>Approved?</span>#home.approved#</p>
	</div>

	#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this home", action="edit", key=home.id)#

</cfoutput>
</div>
