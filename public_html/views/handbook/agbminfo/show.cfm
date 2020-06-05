<cfoutput>
	<h2>
		Payments by #payments.fname# #payments.lname# of #payments.city#, #payments.state#
	</h2>

	<cftry>
		<cfif isAgbmLifeMember(payments.personid)>
			<h3 style="font-style:italic">Lifetime Member</h3>
		</cfif>
		<cfcatch></cfcatch>
	</cftry>

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
		</tbody>	
	</table>

	<cfoutput>
		<p>#addTag(controller='Handbook.AgbmInfo', action="add", id=params.key)#</p>

		<p>#linkTo(text="Return to list", controller="Handbook.agbmInfo", action="list")#</p>
		<p>#linkTo(text="Add Lifetime Membership to Handbook Record", controller="Handbook.people", action="edit", key=payments.personid, target="_new")#</p>
	</cfoutput>
</div>