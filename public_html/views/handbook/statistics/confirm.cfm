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
		Celebrations: #statistic.celebrate#
		
	</li>
	<li>
		Challenges: #statistic.assist#
		
	</li>
	<li>
		Pray for: #statistic.prayer#
		
	</li>
	<li>&nbsp;</li>
	<li>
		Donated funds to help Charis Churches having difficulty covering their fellowship fee this year: #statistic.donate#
	</li>
	<li>
		Donated funds for the Charis Fellowship COVID Emergency Relief Fund: #statistic.relief#
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
		<cfif isLocalMachine()>
			(test)
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