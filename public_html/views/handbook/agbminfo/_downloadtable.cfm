<cfoutput>
	<cfset REQUEST.lastpayment = getLastPayment(personid)>

		<tr>
			<td>
				#fname#
			</td>
			<td>
				#lname#	
			</td>
			<td>
				#address1#	
			</td>
			<td>
				#address2#	
			</td>
			<td>
				#city#	
			</td>
			<td>
				#state#	
			</td>
			<td>
				#zip#	
			</td>
			<td>
				#email#	
			</td>
			<td>
				#phone#	
			</td>
			<td>
				#district#	
			</td>
			<td>
				#name#	
			</td>
			<td>
				#handbookorganizationaddress1#	
			</td>
			<td>
				#handbookorganizationaddress2#	
			</td>
			<td>
				#org_city#	
			</td>
			<td>
				#handbookorganizationstate#	
			</td>
			<td>
				#handbookorganizationzip#	
			</td>
			<td>
				#ministrystartat#	
			</td>
			<td>
				<cfif REQUEST.lastpayment contains "ordained">
					an ordained
				<cfelseif REQUEST.lastpayment contains "licensed">
					a licensed
				</cfif>
			</td>		
		</tr>
</cfoutput>