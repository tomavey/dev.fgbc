<cfoutput>
  <div style="border:2px solid black; margin-bottom:30px; padding: 20px">
    <h2>Home ## #home.homeid#</h2>
    <p class="homes-status">Status: #home.status#</p>
    <cfif home.status != "No Longer Available">
      #linkTo(text="I am interested in this host home", action="new", params="type=guest&requestedHomeId=#home.homeid#", class="btn btn-large")#
    </cfif>
    #includePartial("includes/availabilityinfo")#
    #includePartial("includes/detailsinfo")#
    #includePartial("includes/locationinfo")#
    <cfif gotRights("office")>
      #listTag(action="index")# #editTag(home.id)#
    </cfif>
  </div>
</cfoutput>
