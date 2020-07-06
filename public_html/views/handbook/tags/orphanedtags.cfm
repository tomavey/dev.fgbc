<ul>
  <cfoutput query="orphanedTags">
    <li>#id# - #tag# - #linkTo(text=itemid, controller="handbook.person", action="show", key=#itemid#)# - #username# - #type#</li>
  </cfoutput>
</ul>
<cfoutput>
  #linkTo(text="Delete Orphaned Tags", controller="handbook.tags", action="deleteOrphanedTags")#
</cfoutput>
