<cfoutput>
  <div style="border:2px solid black; margin-bottom:30px; padding: 20px">
    <p class="homes-status">#home.status#</p>
    <h2>Home ## #home.homeid#</h2>
    #includePartial("availabilityinfo")#
    #includePartial("detailsinfo")#
    <cfif gotRights("office")>
      #listTag(action="index")# #editTag(home.id)#
    </cfif>
  </div>
</cfoutput>
