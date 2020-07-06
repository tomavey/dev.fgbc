<cfoutput>
  <cfif gotRights('office')>
    <div class="host-navbar">
      <div style="float:right">
        #startFormTag(route="ConferenceHomesIndex", onlyPath=false, method="get", class="host-search-form")#
        #textFieldTag(name='search', placeholder="Search")#
        #endFormTag()#
      </div>
      <p>
        #linkTo(text="List Guests", route="conferenceHomesIndex", params="type=guest", class="btn")#&nbsp;
        #linkTo(text="List Hosts", route="conferenceHomesIndex", params="type=host", class="btn")#&nbsp;
        #linkTo(text="New host", route="accessHomeHosts", class="btn")#&nbsp;
        #linkTo(text="New guest", route="accessHomeGuests", class="btn")#&nbsp;
        #linkTo(text="Show Public List", route="conferenceHomesList", class="btn")#&nbsp;
        #linkTo(text="Testing Mode? #getSetting('isConferenceHomesTesting')#", controller="admin.settings", action="toggleSetting", params="setting=isConferenceHomesTesting", class="btn")#
        <cfif getSetting('isConferenceHomesTesting')>
          Email notifications not sent to user!
        </cfif>
        #linkTo(text="Edit Instructions", controller="admin.contents", action="index", params="category=homes", class="btn")#
      </p>
    </div>
  </cfif>
</cfoutput>