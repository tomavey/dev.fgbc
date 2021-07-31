<h1>Listing invoices</h1>

<table>
	<tr>
		<th>
			Order ID
		</th>
		<th>
			Amount
		</th>
		<th>
			Name
		</th>
		<th>
			Status
		</th>
		<th>
			Date
		</th>
		<th>
			&nbsp;
		</th>
		
	</tr>
	<cfoutput query="invoices">
		<tr>
			<td>
				#linkTo(controller="focus.invoices", action="show", key=val(orderid), text=orderid)#
			</td>
			<td>
				#dollarformat(ccamount)#
			</td>
			<td>
				#ccname#
			</td>
			<td>
				#getStatus(ccstatus)#
			</td>
			<td>
				#dateformat(createdAt)#
			</td>
			<td>
				#editTag()#
				#deleteTag()#
				#showTag()#
			</td>
		</tr>
	</cfoutput>
</table>


<cfoutput>
	<p>#linkTo(text="New invoice", action="new")#</p>
</cfoutput>
