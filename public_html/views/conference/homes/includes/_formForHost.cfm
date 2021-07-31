<cfscript>
  cfparam(name="type", default="host")
</cfscript>

<cfoutput>

<div class="homes-form">

    #hiddenFieldTag(name="home.type", value=type)#

    #includePartial(partial="includes/contactfields")#

    #includePartial(partial="includes/availabilityfields")#

    #includePartial(partial="includes/detailsfields")#
  
    #includePartial(partial="includes/locationfields")#

  <cfif gotRights("office")>

    #includePartial(partial="includes/officefields")#

  </cfif>

</div>

</cfoutput>

                    
