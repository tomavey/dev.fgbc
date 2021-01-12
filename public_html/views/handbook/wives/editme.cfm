<cfparam name="formRoute" default="handbookWivesUpdateMe">
<div class="container span11">
  <h2>Enter New Thrive Data for:</h2>
  <cfoutput>
      <h3>
        #person.spouse# #person.lname#
      </h3>
      #startFormTag(route=formRoute, key=params.key, method="patch")#
      #hiddenField(objectName='person', property='sendHandbook')#
      #textField(objectName='person', property='spouse_email', label="Email: ")#
      #textField(objectName='person', property='phone4', label="Cell Phone: ")#
      #submitTag()#
      #endFormTag()#
  </cfoutput>
</div>