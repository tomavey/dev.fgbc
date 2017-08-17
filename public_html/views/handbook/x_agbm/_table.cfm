<cfoutput>
			<tr>	
				<td>
					#linkTo(text="#fname# #lname#", controller="handbook.people", action="show", key=id)#
					<cfif NOT age>
					** 
					</cfif>
					<cfif p_sortorder GT 500>
					*
					</cfif>
				</td>	
				<td>
					#linkTo(text="#name#;#org_city#,#getState(handbookorganizationstateid)#", controller="handbook.organizations", action="show", key=organizationid)# 
				</td>
				<td>
					<cfif isDefined("district")>#linkTo(text=district, action="list", params="district=#districtid#&groupby=district&showall=")#</cfif>
				</td>	
				<td class="paymentsPopup">
					<span>#getLastPayment(id)#</span><span>#getPayments(id)#</span>
				</td>
				<cfif gotRights("superadmin,agbmadmin")>
				<td>
					#showTag()#
					#addTag(controller='HandbookAgbmInfo', id=id)#
				</td>
				</cfif>
			</tr>
			
</cfoutput>			
