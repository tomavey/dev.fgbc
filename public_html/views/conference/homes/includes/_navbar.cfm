<cfoutput>
  <cfif gotRights('office')>
    <div class="host-navbar">
      <div style="float:right">
        #startFormTag(route="ConferenceHomesIndex", onlyPath=false, method="get", class="host-search-form")#
        #textFieldTag(name='search', placeholder="Search")#
        #endFormTag()#
      </div>
      <p>
        <cfif type=="host">
          #linkTo(text="List Guests", route="conferenceHomesIndex", params="type=guest", class="btn")#&nbsp;
        </cfif>
        <cfif type=="guest">
          #linkTo(text="List Hosts", route="conferenceHomesIndex", params="type=host", class="btn")#&nbsp;
        </cfif>
        #linkTo(text="New host", route="accessHomeHosts", class="btn")#&nbsp;
        #linkTo(text="New guest", route="accessHomeGuests", class="btn")#&nbsp;
        #linkTo(text="Show Public List", route="conferenceHomesList", class="btn")#&nbsp;
        <!--- #linkTo(text="Thank You Message", action="thankyou", class="btn")# --->
      </p>
    </div>
  </cfif>
</cfoutput>