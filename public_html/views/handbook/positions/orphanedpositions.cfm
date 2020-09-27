<cfif orphanedPositions.recordCount>
  <ul>
    <cfoutput query="orphanedPositions">
      <li>#id# - #tag# - #linkTo(text=itemid, controller="handbook.person", action="show", key=#personsid#)# - #username# - #type#</li>
    </cfoutput>
  </ul>
  <cfoutput>
    #linkTo(text="Delete Orphaned Tags", controller="handbook.tags", action="deleteOrphanedTags")#
  </cfoutput>
<cfelse> 
  No Orphaned Tags 
</cfif>
