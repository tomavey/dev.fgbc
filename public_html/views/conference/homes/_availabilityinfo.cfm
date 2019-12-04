<cfoutput>

  <div class="homes homes-availabilityinfo">
    <p><span>Is your home available July 22-26, 2019?</span>#home.available#</p>
    <p><span>How many people?</span>#home.howmany#</p>
    <p><span>My home is best for: </span>
      <cfif home.forFamilies == "yes">Families</cfif> 
      <cfif home.forCouples == "yes">| Couples</cfif> 
      <cfif home.forSingles == "yes">| Singles</cfif>
    </p>
  </div>

</cfoutput>
