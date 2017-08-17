<cfoutput>
	<h2>
		Payments by #payments.fname# #payments.lname# of #payments.city#, #payments.state#
	</h2>
</cfoutput>
<div class="table table-striped">
<table>
<thead>
<th>
	Payment
</th>
<th>
	Year
</th>
<th>
	Date
</th>
<th>
	Comments
</th>
<th>
	&nbsp;
</th>
</thead>
<tbody>
<cfoutput query="payments">
<tr>
<td>
	#dollarFormat(membershipfee)#
</td>
<td>
	#membershipfeeyear#
</td>
<td>
	#transactiondate#
</td>
<td>
	#comments#
</td>
<td>
	<cfif gotrights("superadmin,agbmadmin")>
		#editTag(controller="Handbook.AgbmInfo")# #deleteTag(controller="Handbook.AgbmInfo", method="delete")#
	</cfif>
</td>

</tr>
</cfoutput>
</table>
<cfoutput>
	<p>#addTag(controller='Handbook.AgbmInfo', action="add", id=params.key)#</p>

	<p>#linkTo(text="Return to list", controller="Handbook.agbmInfo", action="list")#</p>
</cfoutput></div>