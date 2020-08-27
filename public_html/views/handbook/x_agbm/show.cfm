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
	#editTag(controller="HandbookAgbmInfo")# #deleteTag(controller="HandbookAgbmInfo")#
</td>	

</tr>	
</cfoutput>
</table>
<cfoutput>#linkTo(text="Return to list", controller="Handbook-agbm", action="index")#
</cfoutput></div>