<div class="span9 offset1">
<cfoutput>
<ul>
	<li>
		#church.name#
	</li>

	<li>
		#church.org_city#, #church.handbookstate.state#
	</li>
	<li>&nbsp;</li>

	<li>
		Attendance: #statistic.att#
		
	</li>
	<li>
		Small Group: #statistic.ss#
		
	</li>
	<li>
		Membership: #statistic.members# <cfif val(statistic.triune)>[#statistic.triune#]</cfif>
		
	</li>
	<li>
		Baptisms: #statistic.baptisms#
		
	</li>
	<li>&nbsp;</li>
	<li>
		Order id: #params.order_id#
	</li>
	<li>
		Amount: #dollarFormat(params.amount)#
	</li>
	<li>
		Status:
		<cfif isDefined("params.status") AND params.status is 1>
			Paid
		<cfelse>
			Not Paid	
		</cfif>	
	</li>

</ul>
<cfif delegatesSubmitIsOpen()>
	<div class="well">
	#linkTo(text="Submit your delegates now", route="sendmydelegates", key=church.id, class="btn btn-primary")#
	</div>
</cfif>
</cfoutput>
</div>