<div class="span11">
  <cfoutput>	
	<h3>Select the person for whom you want to upload a picture</h3>
    #startFormTag(action="new", method="get")#
    #selectTag(name="personid", options=people, textField="selectName", includeBlank="---select person---")#
    #submitTag("Upload for this person")#
    #endFormtag()#
    
  </cfoutput>
</div>
