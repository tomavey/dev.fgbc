<cfscript>
  cfparam(name="type", default="host")
</cfscript>

<cfoutput>

<div class="homes-form">

  #includePartial("includes/contactInfo")#

  <div style="display:none">

    #hiddenFieldTag(name="home.type", value=type)#

    #includePartial("includes/contactfields")#
  
    #includePartial("includes/availabilityfields")#
  
    #includePartial("includes/detailsfields")#
  
    #includePartial("includes/locationfields")#
  
  </div>

  <cfif gotRights("office")>

    #includePartial("includes/officefields")#

  </cfif>

</div>

</cfoutput>

                    
