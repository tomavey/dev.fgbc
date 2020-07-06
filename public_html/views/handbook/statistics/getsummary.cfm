<table class="table table-striped">
	<thead>
	<tr>
		<th>
			&nbsp;
		</th>
		<th colspan="2" style="text-align:center">
			Attendance
		</th>
		<th colspan="2" style="text-align:center">
			Membership
		</th>
		<th colspan="2" style="text-align:center">
			Baptisms
		</th>
		<th colspan="2" style="text-align:center">
			Conversions
		</th>
		<th colspan="2" style="text-align:center">
			Small Group
		</th>
	</tr>
	<tr>
		<th>
			&nbsp;
		</th>
		<th>
			Total
		</th>
		<th>
			Average
		</th>
		<th>
			Total
		</th>
		<th>
			Average
		</th>
		<th>
			Total
		</th>
		<th>
			Average
		</th>
		<th>
			Total
		</th>
		<th>
			Average
		</th>
		<th>
			Total
		</th>
		<th>
			Average
		</th>
	</tr>
	</thead>
	<tbody>
	<cfoutput query="summary1">
		<tr>
			<td>
				#params.key#
			</td>
			#includePartial("summary")#
		</tr>
	</cfoutput>
	<cfif isDefined("params.compyear")>
	<cfoutput query="summarycompyear">
		<tr>
			<td>
				#params.compyear#
			</td>
			#includePartial("summary")#
		</tr>
	</cfoutput>
	</cfif>

	<cfif isDefined("params.compyear2")>
	<cfoutput query="summarycompyear2">
		<tr>
			<td>
				#params.compyear2#
			</td>
			#includePartial("summary")#
		</tr>
	</cfoutput>
	</cfif>

	<cfif isDefined("params.compyear3")>
	<cfoutput query="summarycompyear3">
		<tr>
			<td>
				#params.compyear3#
			</td>
			#includePartial("summary")#
		</tr>
	</cfoutput>
	</cfif>

	<cfif isDefined("params.compyear4")>
	<cfoutput query="summarycompyear4">
		<tr>
			<td>
				#params.compyear4#
			</td>
			#includePartial("summary")#
		</tr>
	</cfoutput>
	</cfif>
	<tbody>
</table>
<!--- <cfdump var="#ewp#"> --->