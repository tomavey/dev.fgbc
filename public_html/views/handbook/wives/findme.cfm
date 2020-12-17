<div class="container span11">
  <h2>Find your name...</h2>
  <cfoutput>
    #startFormTag(route="handbookWivesEditMe", method="get")#
    #selectTag(options=pastorswives, name="key", valueField="id", textField="WIFESELECTNAME", includeBlank="----Select One----")#
    #submitTag()#
    #endFormTag()#
  </cfoutput>
</div>