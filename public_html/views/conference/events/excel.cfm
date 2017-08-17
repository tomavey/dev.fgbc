<table>
<cfoutput query="events" group="date">
<tr>
	<td colspan="8">
		<h2>#weekday(date)#, #dateformat(date,"mmm-dd")#</h2>
	</td>
</tr>
<tr>
	<th>
		Begins
	</th>
	<th>
		Ends
	</th>
	<th>
		Event
	</th>
	<th>
		Room
	</th>
	<th>
		Equipment
	</th>
	<th>
		Setup
	</th>
	<th>
		Expected
	</th>
</tr>
<cfoutput>
<tr style="vertical-align:middle">
	<td>#timeformat(timebegin)#</td>
	<td>#timeformat(timeend)#</td>
	<td>#getWorshipTitleForEvent(id,description)#</td>
	<td style="text-align:center">#roomnumber#</td>
	<td>#equipment#</td>
	<td>
		<cfif len(setup)>
			#setup#
		<cfelse>
			#defaultsetup#
		</cfif>
	</td>
	<td>#attending#</td>
</tr>
</cfoutput>
</cfoutput>
</table>