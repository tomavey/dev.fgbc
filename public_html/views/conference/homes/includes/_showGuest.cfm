<cfoutput>

  <h1>Showing Guest</h1>

  #includePartial("includes/showFlash")#
  
  <!--- <cfdump var="#home.properties()#"><cfabort> --->
  
  #includePartial("includes/contactinfo")#
  
  #includePartial("includes/office")#
  
  <cfif gotRights("office")>
    #listTag()# #editTag(home.id)#
  </cfif>
  
</cfoutput>
