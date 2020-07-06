<cfoutput>

<cfif isDefined("params.email")>

#hiddenFieldTag(name="district[updatedBy]", value=params.email)#

<cfelse>

#textField(objectName="district", property="updatedBy", label="Email address of person submitting this form:")#

</cfif>

<cfif gotRights("superadmin,office")>

#textField(objectName="district", property="district", label="District Name:")#

#select(objectName="district", property="Region", label="Fellowship Council Region:", options="A,B,C", includeBlank="--select one---")#

#select(objectName="district", property="agbmregionid", label="AGBM Region: ", options=agbmregions, textfield="name", includeBlank="--select one---")#
</cfif>

#textArea(objectName="district", property="report", class="ckeditor")#
<p>shift-enter = line break; enter = paragraph break</p>

#hiddenFieldTag(name="district[districtid]", value=district.districtid)#

</cfoutput>