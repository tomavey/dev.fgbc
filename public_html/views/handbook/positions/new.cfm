<div class="postbox" id="maininfo">
<cfoutput>

<h1>Create new position for #thisperson.fname# #thisperson.lname#
<cfif isDefined("thisOrganization.name")>
	at #thisOrganization.name#
</cfif>
</h1>

<cfif gotRights("agbmadmin,superadmin,office")>
	<div class="well">
		If this new position is an AGBM-Only position, you need to change the organization to the church this person is a member of.
	</div>
</cfif>

			#errorMessagesFor("handbookposition")#
	
			#startFormTag(coute="createnewposition")#
		
						#hiddenField(objectName='handbookposition', property='personid')#			

						<cfif isDefined("handbookposition.organizationid")>
							#hiddenField(objectName='handbookposition', property='organizationId')#			
						<cfelse>		
							#select(objectName='handbookposition', property='organizationId', label='Organization: ', options=organizations, textField="selectNameCity", includeBlank="---Select a member church---")#
						</cfif>
						#textField(objectName='handbookposition', property='position', label='Position: ')#
					
						<cfif isDefined("handbookposition.p_sortorder")>
							#hiddenField(objectName='handbookposition', property='p_sortorder')#			
						<cfelse>		
							#textField(objectName='handbookposition', property='p_sortorder', label='Sortorder: ')#
						</cfif>

						#select(objectName='handbookposition', property='positiontypeid', label='Position type: ', options=positionTypes, textField="position")#
					

				#submitTag()#
				
			#endFormTag()#
			

#linkTo(text="Return to the listing", action="index")#
</cfoutput>


</div>