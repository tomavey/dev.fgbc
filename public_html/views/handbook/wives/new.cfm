
<div class="container span11">
  <h2>Enter New Thrive Data for:</h2>
  <cfoutput>
    <cfif isDefined("params.key")>
      <h3>
        #pastorsWife.spouse# #pastorsWife.lname#
      </h3>
      #startFormTag(action="update")#
      #textField(objectName='pastorsWife', property='spouse_email', label="Email: ")#
      #textField(objectName='pastorsWife', property='phone4', label="Cell Phone: ")#
      #submitTag()#
      #endFormTag()#
    <cfelse>
      #startFormTag(action='new', method='get')#
      #selectTag(options=pastorswives, name="key", valueField="id", textField="WIFESELECTNAME", includeBlank="----Select One----")#
      #submitTag()#
      #endFormTag()#
    </cfif>
  </cfoutput>
</div>
