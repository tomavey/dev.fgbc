<cfoutput>
#ckeditor()#

<h2>Create a new district:</h2>

#startFormTag(action=formaction)#

#textField(objectName="district", property="district", label="District Name:")#

#textField(objectName="district", property="Region", label="Region:")#

#hiddenField(objectName="district", property="CreatedBy")#

#submitTag()#

#endFormTag()#

</cfoutput>