<cfset showPayonline = false>
<h1><cfoutput>#handbookstatistic.selectname#</cfoutput></h1>

<div class="table table-striped">
	<table>
	<thead>	
		<tr>
			<th>
				Year
			</th>
			<th>
				Attendance
			</th>
			<th>
				Sunday School
			</th>
			<th>
				Conversions
			</th>
			<th>
				Baptisms
			</th>
			<th>
				Members
			</th>
			<cfif gotRights("superadmin,office")>
			<th>
				Triune Immersed Members
			</th>
			<th>
				MemFee
			</th>
			</cfif>
		</tr>
	</thead>
	<tbody>
<cfoutput query="handbookstatistic">
		<tr>
			<td>
				#year#
			</td>
			<td>
				#att#
			</td>
			<td>
				#ss#
			</td>
			<td>
				#conversions#
			</td>
			<td>
				#baptisms#
			</td>
			<td>
				#members#
			</td>
			<cfif gotRights("superadmin,office")>
			<td>
				#Triune#
			</td>
			<td>
				#dollarformat(memfee)#
			</td>
			</cfif>
		</tr>
<cfif year is year(now())-1>
	<cfset showPayonline = true>
</cfif>		

</cfoutput>
	</tbody>
	</table>
<cfif gotrights("superadmin,office")>	
	<cfoutput>
		#buttonTo(text="Add new stat.",controller="handbook.statistics",action="new",key=params.key)#
		<cfif showPayonline>
			#buttonTo(text="Make Payment Online Based On #year(now())-1# stats", controller="handbook.statistics", action="payonline", key=params.key)#
		</cfif>
	</cfoutput>
</cfif>
</div>