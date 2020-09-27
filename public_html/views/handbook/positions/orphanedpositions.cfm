<cfif orphanedPositions.recordCount>
  <ul>
    <cfoutput query="orphanedPositions">
      <li>#id# - #position# - #linkTo(text="Person", controller="handbook.people", action="show", key=#personid#)# - #linkTo(text="Org", controller="handbook.organizations", action="show", key=#organizationid#)# - #dateFormat(createdAt)#</li>
    </cfoutput>
  </ul>
  <cfoutput>
    #linkTo(text="Delete Orphaned Positions", controller="handbook.positions", action="deleteOrphanedPositions")#
  </cfoutput>
<cfelse> 
  No Orphaned Tags 
</cfif>
