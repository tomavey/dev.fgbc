<div class="span11">
  <h2>Orphaned Tags</h2>
  <p class="well">These are tags that are no longer valid. Either the person or the organization tagged no longer exist</p>
  <cfif orphanedTags.recordCount>
  <ul>
    <cfoutput query="orphanedTags">
      <li>#id# - #tag# - #linkTo(text=itemid, controller="handbook.people", action="show", key=#itemid#)# - #username# - #type#</li>
    </cfoutput>
  </ul>
  <cfoutput>
    #linkTo(text="Delete Orphaned Tags", controller="handbook.tags", action="deleteOrphanedTags", class="btn btn-block")#
  </cfoutput>
  <cfelse> 
    No Orphaned Tags 
  </cfif>
</div>