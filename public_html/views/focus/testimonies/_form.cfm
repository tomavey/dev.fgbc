<cfoutput>

#textField(objectName="Testimony", property="name", label="Name: ")#

#textField(objectName="Testimony", property="email", label="Email: ")#

#select(objectName="Testimony", property="retreatId", options=retreats, label="Retreat", includeBlank="---Select the retreat---")#

<cfif gotRights("office")>
    #select(objectName="Testimony", property="approved", options="No,Yes", label="Approved")#
</cfif>

#textArea(objectName="Testimony", property="testimony", label="", class="ckeditor")#

</cfoutput>