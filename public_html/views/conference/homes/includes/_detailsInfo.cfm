<cfoutput>
  <div class="homes homes-detailsinfo">
		<p><span>How many bedrooms are available?</span>#home.bedrooms#</p>
		<p><span>How many beds are available?</span>#home.beds#</p>
		<p><span>How many bathrooms are available?</span>#home.bathrooms#</p>
		<p><span>What are the sleeping arrangements?</span>#home.arrangements#</p>
		<p><span>Other details to note:</span>#home.other#</p>
		<p><span>Amenities available:</span>
			<cfif home.airconditioning == "yes">A/C |</cfif>
			<cfif home.towels == "yes">Towels</cfif>
			<cfif home.linens == "yes">| Linens</cfif>
			<cfif home.tv == "yes">| TV</cfif>
			<cfif home.wifi == "yes">| WiFi</cfif>
			<cfif home.kitchen == "yes">| Kitchen</cfif>
			<cfif home.breakfast == "yes">| Breakfast</cfif>
			<cfif home.refrigerator == "yes">| Refrigerator</cfif>
			<cfif home.washerdryer == "yes">| Washerdryer</cfif>
		</p>
		<p><span>What are the sleeping arrangements?</span>#home.arrangements#</p>
		<p><span>Distance from Grace College campus?</span>#home.distance#</p>
		<p><span>Cost (per night)?</span>#home.cost#</p>
		<p><span>Date this home was added?</span>#dateformat(home.createdAt)#</p>
	</div>	
</cfoutput>
  
