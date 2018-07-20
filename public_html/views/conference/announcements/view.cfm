<div data-role="content">
  <cfoutput query="announcements">
    <div class="well">
      <p>#subject#</p>
      <p>#dateTimeFormat(postAt)#</p>
      <p>#content#</p>
    </div>
  </cfoutput>
</div>