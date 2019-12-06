<cfoutput>

  <h1>Showing Host</h1>

  #includePartial("includes/showFlash")#
  
  <!--- <cfdump var="#home.properties()#"><cfabort> --->
  
  #includePartial("includes/contactinfo")#
  
  #includePartial("includes/availabilityinfo")#
  
  #includePartial("includes/detailsinfo")#
  
  #includePartial("includes/locationinfo")#
  
  #includePartial("includes/office")#
  
  <cfif gotRights("office")>
    #listTag()# #editTag(home.id)#
  </cfif>
  
</cfoutput>
