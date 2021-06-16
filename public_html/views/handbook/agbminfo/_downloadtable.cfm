<cfoutput>
	<cfset REQUEST.lastpayment = getLastPayment(personid)>

		<tr>
			<td>
				#inspireId(people['personid'][currentrow])#
			</td>
			<td>
				#fname#
			</td>
			<td>
				#lname#	#suffix#
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
				#district# District
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
				#org_email#	
			</td>
			<td>
				#ministrystartat#	
			</td>
			<cfif showAge && birthdayyear NEQ 1900>
				<td>
					#BirthdayYear#
				</td>
			</cfif>
			<td>
				<cfif REQUEST.lastpayment contains "ordained">
					Ordained
				<cfelse>
					Commissioned
				</cfif>
			</td>
			<td>
				<cfif REQUEST.lastpayment contains "Cat. 1">
					Cat. 1
				<cfelseif REQUEST.lastpayment contains "Cat. 2">
					Cat. 2
				<cfelseif REQUEST.lastpayment contains "Cat. 3">
					Cat. 3
				<cfelse>
					NA	
				</cfif>
			</td>
			<cfif gotRights("superadmin,agbmadmin") && ! hideLastPayment>
				<td>
				#REQUEST.lastpayment#
			</td>		
		</cfif>
		</tr>
</cfoutput>