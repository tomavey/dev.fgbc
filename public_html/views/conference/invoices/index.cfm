<cfset totalInvoices = 0>
<div class="eachItemShown">

<h1>Invoices: </h1>
<cfoutput>
	#addTag()#	
</cfoutput>
<table class="dataTable">
	<thead>
		<tr>
			<th>
				Order Id
			</th>
			<th>
				Amount	
			</th>
			<th>
				Status
			</th>
			<th>
				Name on Card
			</th>
			<th>
				Email on Card
			</th>
			<th>
				Agent
			</th>
			<th>
				Created
			</th>
			<th>
				&nbsp;
			</th>
		</tr>
	</thead>	
	<tbody>
		<cfoutput query="invoices" group="ccOrderId">
		<tr>
			<td>
				#linkTo(text='#ccOrderId#', action='show', key=ID, title="show")#
			</td>
			<td>
				#dollarFormat(ccAmount)#
				<cfset totalInvoices = totalInvoices + ccamount>
			</td>
			<td>
				#payStatus(ccstatus)#
			</td>
			<td>
				#ccName#
			</td>
			<td>
				#mailto(ccemail)#
			</td>
			<td>
				#mailto(agent)#
			</td>
			<td>
				#dateformat(createdat, "medium")#
			</td>
			<td>
				#showTag()# 
				#editTag()#
				#deleteTag(class="notajax")#
			</td>
		</tr>
		</cfoutput>
	</tbody>	
</table>

<cfoutput>
	#addTag()#	
</cfoutput>
<div>
	Total = <cfoutput>#dollarformat(totalInvoices)#</cfoutput>
</div>
</div>