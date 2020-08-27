<table>
	<tr>
		<th>
			Table Name
		</th>
		<th>
			Record Count in Backup
		</th>
		<th>
			Date of Last Backup
		</th>
	</tr>
	<cfoutput query="alltables">
	<tr>
		<td>
			#linkto(controller="conference.backups", action="backup", key=tables_in_fgbc_main_3, text=Tables_in_fgbc_main_3)#
		</td>
		<td>
			#getLastBackup(tables_in_fgbc_main_3).records#
		</td>
		<td>
			<cfset request.datetime = getLastBackup(tables_in_fgbc_main_3).createdAt>
			<cfif len(request.datetime)>
				#dateformat(request.datetime)# at #timeformat(request.datetime)#
			</cfif>
		</td>
	</tr>
	</cfoutput>
	<tr>
		<td colspan="3">
		<cfoutput>#linkto(text="Backup All", controller="conference.backups", action="backupall")#</cfoutput>
		</td>
		</tr>
	</tr>
		
</table>