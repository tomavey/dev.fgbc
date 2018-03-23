<cfoutput>
	<cfset REQUEST.lastpayment = getLastPayment(personid)>
	<cfset REQUEST.payments = getPayments(personid)>
			<tr>	
				<td>
					#linkTo(text="#fname# #lname#", controller="handbook.people", action="show", key=personid)#
					<cfif showAge>
						<br/>#birthdayyear#
					</cfif>
				</td>	
				<td>
					#linkTo(text="#name#;#org_city#,#org_state#", controller="handbook.organizations", action="show", key=organizationid)#<cfif statusid is 5><p style="color:red;font-weight:bold">WARNING-This church has closed</p></cfif> 
				</td>
				<td>
					<cfif isDefined("district")>#linkTo(text=district, action="list", key="members", params="district=#districtid#&groupby=district&showall=")#</cfif>
				</td>	
				<td class="paymentsPopup">
					<span>#REQUEST.lastpayment#</span><span>#REQUEST.payments#</span>
				</td>
			<cfif gotRights("superadmin,agbmadmin")>
				<td>
					#showTag(personid)#
					#addTag(controller='Handbook.AgbmInfo', action="add", id=personid)#
				</td>
			</cfif>
			</tr>
</cfoutput>			
