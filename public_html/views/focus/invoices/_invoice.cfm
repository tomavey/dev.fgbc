<cfoutput>
	
	<div id="invoice">
		<ul>
			<li>
				Order ID: #invoice.orderid#
			</li>
			<li>
				Amount: #dollarformat(invoice.ccamount)#
			</li>
			<li>
				Name on card: #invoice.ccname#
			</li>
			<cfif getStatus(invoice.ccstatus) is "Not Paid">
				<cfset statusclass="notpaid">
			<cfelse>
				<cfset statusclass="paid">
			</cfif>	
			<li class="#statusclass#">
				Status: #getStatus(invoice.ccstatus)#
			</li>
			<li>
				Date: #dateFormat(invoice.createdAt)#
			</li>
		</ul>
	</div>
	<div id="invoiceItems">
		<table class="table table-bordered">
			<tr>
				<th>
					&nbsp;
				</th>
				<th>
					Description
				</th>
				<th class="price">
					Cost
				</th>
				<th class="quantity">
					Quantity
				</th>
			</tr>

		<cfoutput query="items" group="registrantid">
			<tbody>
			<tr>
				<td colspan="4" class="focusinvoicename">
				For: #fname# #lname#	
				</td>
			</tr>
			<cfoutput>
				<tr>
					<td>&nbsp;</td>
					<td class="description">#description#</td> 
					<td class="price">#dollarformat(price)#</td> 
					<td class="quantity">#quantity#</td>
				</tr>	
			</cfoutput>
				<tr>
					<td>&nbsp;</td>
				</tr>
		</cfoutput>
		</tbody>
		</table>	
	</div>		
	
</cfoutput>	
