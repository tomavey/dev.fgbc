<cfoutput>

  <h1>Showing Host</h1>

  #includePartial(partial="includes/showFlash")#
  
  <!--- <cfdump var="#home.properties()#"><cfabort> --->
  
  #includePartial(partial="includes/contactinfo")#
  
  #includePartial(partial="includes/availabilityinfo")#
  
  #includePartial(partial="includes/detailsinfo")#
  
  #includePartial(partial="includes/locationinfo")#
  
  #includePartial(partial="includes/office")#
  
  <cfif gotRights("office")>
    #listTag()# #editTag(home.id)#
  </cfif>
  
</cfoutput>
