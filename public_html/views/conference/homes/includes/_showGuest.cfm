<cfoutput>

  <h1>Showing Guest</h1>

  #includePartial(partial="includes/showFlash")#
  
  <!--- <cfdump var="#home.properties()#"><cfabort> --->
  
  #includePartial(partial="includes/contactinfo")#
  
  #includePartial(partial="includes/office")#
  
  <cfif gotRights("office")>
    #listTag()# #editTag(home.id)#
  </cfif>
  
</cfoutput>
