<cfoutput>
			<tr>	
				<td>
					#linkTo(text="#person.fname# #person.lname#", controller="handbook.people", action="show", key=person.personid)#<br/>
					#inspireId(person.personid,person.lname)#
					<cfif showAge && person.birthdayyear NEQ 1900>
						<br/>#person.birthdayyear#
					</cfif>
				</td>	
				<td>
					#linkTo(text="#person.name#;#person.org_city#,#person.org_state#", controller="handbook.organizations", action="show", key=person.organizationid)#<cfif person.statusid is 5><p style="color:red;font-weight:bold">WARNING-This church has closed</p></cfif> 
				</td>
				<td>
					#linkTo(text=person.district, action="list", params="type=members&district=#person.district#")#
				</td>	
				<td class="paymentsPopup">
					<span>#REQUEST.lastpayment#</span><span>#REQUEST.payments#</span>
				</td>
			<cfif gotRights("superadmin,agbmadmin")>
				<td>
					#showTag(person.personid)#
					#addTag(controller='Handbook.AgbmInfo', action="add", id=person.personid)#
				</td>
			</cfif>
			</tr>
</cfoutput>			
