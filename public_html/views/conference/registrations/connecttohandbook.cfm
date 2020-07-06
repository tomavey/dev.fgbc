<cfoutput>
	<p>Use past conferences: #linkto(text="Vision2020West", key="celebrate2012")# #linkto(text="Vision2020(Wooster)", key="celebrate2011")#

	<p>
		#paginationLinks(key=params.key)#
	</p>
	
	#startFormTag(action="connect")#

	#hiddenFieldTag(name="page", value=params.page)#
	#hiddenFieldTag(name="key", value=params.key)#

	<table class="table">
		<tr>
			<th>Reg Person</th>
			<th>&nbsp;</th>
			<th>Handbook Person linked</th>
		</tr>	
		<cfoutput query="registrations" group="equip_peopleid">
			<tr>
				<td>
					#fullname# #linkto(text=equip_peopleid, controller="people", action="show", key=equip_peopleid)# 
				</td>
				<td>
					<select name="#equip_peopleid#">
						<option value="" selected>---Select---</option>
					<cfloop query="handbookpeople">
						<cfif registrations.handbookpersonid is id>
							<option value="#id#" selected="selected">#fullname#</option>
						<cfelse>
							<option value="#id#">#fullname# #id#</option>
						</cfif>
					</cfloop>
					</select>
				</td>
				<td>
					<cfif len(handbookpersonid)>
						#linkTo(text=handbookpersonid, href="/index.cfm?controller=handbook-people&action=show&key=#handbookpersonid#")#
					<cfelse>
						&nbsp;
					</cfif>
				</</td>
			</tr>
	</cfoutput>
	</table>
	#submitTag()#
	#endFormTag()#

</cfoutput>
