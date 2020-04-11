<cfoutput>
<cfif params.action is "New" || (handbookperson.handbookPositions[arguments.current].positionTypeId NEQ 32 && handbookperson.handbookPositions[arguments.current].positionTypeId NEQ 13) || gotRights("office,agbmadmin,handbookadmin")>

<fieldset class="well">
<legend>Position:</legend>


	#textField(
		objectName='handbookperson',
		association="handbookPositions",
		position=arguments.current,
		property='position',
		label='Title: ',
		class="input-xxlarge"
		)#


	#select(
		objectName='handbookperson',
		association="handbookPositions",
		property='positionTypeId',
		position=arguments.current,
		options=positiontypes,
		includeBlank="---select one---",
		textfield="position",
		label='Type of position: '
		)#

<cfif gotRights("superadmin,office,handbookedit,agbmadmin")>

	#textField(
		objectName='handbookperson',
		association="handbookPositions",
		property='p_sortorder',
		position=arguments.current,
		label='Sortorder (must be a number): '
		)#

<cfelse>

	#hiddenField(
		objectName='handbookperson',
		association="handbookPositions",
		property='p_sortorder',
		position=arguments.current
		)#


</cfif>

<cfif isDefined("handbookperson.handbookPositions[arguments.current].organizationid") && !gotRights("office,handbookedit")>

	#hiddenField(
		objectName='handbookperson',
		association="handbookPositions",
		property='organizationid',
		position=arguments.current,
		class="input-xxlarge"
		)#

<cfelse>		

	#select(
		objectName='handbookperson',
		association="handbookPositions",
		property='organizationid',
		position=arguments.current,
		options=churches,
		textfield="selectNameCity",
		label='Church or Ministry: ',
		includeBlank= '---Select Your Church---',
		class="input-xxlarge"		)#

</cfif>

<cfif params.action is "edit" and gotRights("superadmin,office,handbookedit")>

#linkTo(text="Delete this position", controller="handbook.positions", action="delete", key=handbookperson.handbookpositions[arguments.current].id)#

</cfif>

</fieldset>
</cfif>
</cfoutput>
