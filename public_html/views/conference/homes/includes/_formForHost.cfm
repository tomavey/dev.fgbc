<cfscript>
  cfparam(name="type", default="host")
</cfscript>

<cfoutput>

<div class="homes-form">


    #includePartial("includes/contactfields")#

    #includePartial("includes/availabilityfields")#

    #includePartial("includes/detailsfields")#
  
    #includePartial("includes/locationfields")#

  <cfif gotRights("office")>

    #includePartial("includes/officefields")#

  </cfif>

</div>

</cfoutput>

                    
