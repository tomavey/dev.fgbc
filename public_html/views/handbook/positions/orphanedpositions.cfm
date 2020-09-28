<div class="span11">
  <h2>Orphaned Positions</h2>
  <p class="well">These are person to organization relationships that are no longer valid. Either the person or the organization no longer exist</p>
<cfif orphanedPositions.recordCount>
  <ul>
    <cfoutput query="orphanedPositions">
      <li>#id# - #position# - #linkTo(text="Person", controller="handbook.people", action="show", key=#personid#)# - #linkTo(text="Org", controller="handbook.organizations", action="show", key=#organizationid#)# - #dateFormat(createdAt)#</li>
    </cfoutput>
  </ul>
  <cfoutput>
    #linkTo(text="Delete Orphaned Positions", controller="handbook.positions", action="deleteOrphanedPositions", class="btn btn-block")#
  </cfoutput>
<cfelse> 
  No Orphaned Tags 
</cfif>
</div>
