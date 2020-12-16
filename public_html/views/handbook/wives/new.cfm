
<div class="container span11">
  <h2>Enter New Thrive Data for:</h2>
  <cfoutput>
    <cfif isDefined("params.key")>
      #pastorsWife.lname#
    <cfelse>
      <!--- <cfloop query="pastorswives">
        #linkTo(text="#spouse# #lname#", route="handbookWivesAddNewInfo", key=id)#<br/>
      </cfloop>   --->
      #startFormTag(action='new', method='get')#
      #selectTag(options=pastorswives, name="key", valueField="id", textField="WIFESELECTNAME")#
      #submitTag()#
      #endFormTag()#
    </cfif>
  </cfoutput>
</div>
