<div data-role="content">
  <cfoutput query="announcements">
    <div class="well">
      <p>#subject#</p>
      <p>Will show on: #dateTimeFormat(postAt)#</p>
      <p>#content#</p>
      <cfif gotRights("office")>
        #editTag()#
      </cfif>
    </div>
  </cfoutput>
</div>