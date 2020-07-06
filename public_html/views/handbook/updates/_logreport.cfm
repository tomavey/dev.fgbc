<cfoutput>
		<cfif datatype is "new">
			&nbsp;&nbsp;New Record on #dateformat(createdAt)#<br/>
		<cfelseif columnName is "statusid">
			&nbsp;&nbsp;On #dateformat(createdAt)#, "#nameColumn(columnName)#"<br/>
			&nbsp;&nbsp;was "#getOrgStatus(oldData)#" and was changed to "#getOrgStatus(newData)#",<br/>
			&nbsp;&nbsp;by #mailto(createdBy)#</br>
		<cfelseif columnName is "stateid">
			&nbsp;&nbsp;On #dateformat(createdAt)#, "#nameColumn(columnName)#"<br/>
			&nbsp;&nbsp;was #getState(oldData)# and was changed to #getState(newData)#,<br/>
			&nbsp;&nbsp;by #mailto(createdBy)#</br>
		<cfelseif columnName is "organizationid">
			&nbsp;&nbsp;On #dateformat(createdAt)#, "#nameColumn(columnName)#"<br/>
			&nbsp;&nbsp;was #getOrg(oldData)# and was changed to #getOrg(newData)#,<br/>
			&nbsp;&nbsp;by #mailto(createdBy)#</br>
		<cfelseif columnName is "positionTypeId">
			<!---Leave these out--->
		<cfelse>
			&nbsp;&nbsp;On #dateformat(createdAt)#, "#nameColumn(columnName)#"<br/>
			&nbsp;&nbsp;was "#dateDisplay(oldData)#" and was changed to "#dateDisplay(newData)#",<br/>
			&nbsp;&nbsp;by #mailto(createdBy)#</br>
		</cfif>
		<cfif gotrights("superadmin")>
			#deleteTag(controller="handbook.updates")#
		</cfif>
</cfoutput>