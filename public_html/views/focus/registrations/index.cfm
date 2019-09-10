<cfparam name="reportTitle" default="#message#">
<cfset countUnPaid = 0>
<cfset countPaid = 0>
<cfset amountUnPaid = 0>
<cfset amountPaid = 0>
<cfset counts = {}>
<cfset amounts = {}>
<!--- <cfdump var='#registrations#'><cfabort> --->
<cfset isOffice = gotRights("office")>

<cfif !isDefined("params.retreatid") && !isDefined("params.key")>
	<cftry>
		<cfloop query="showRegsFor">
			<cfset reportTitle = reportTitle & " " & linkto(text=regid, action='index', params='retreatid=#id#')>
		</cfloop>
	<cfcatch>
	</cfcatch>
	</cftry>
</cfif>

<cfscript>

public function countRegItems(ccstatus,cost){
	var status = getStatus(ccstatus);
	if (status is "Paid"){
			countPaid = countPaid + 1;
			amountPaid = amountPaid + cost;
	}
	elseif (status is "Not Paid"){
			countUnPaid = countUnPaid + 1;
			amountUnPaid = amountUnPaid + cost;
	}
}

</cfscript>


<cfset emailall = "">
<cfoutput>
	<h1>#reportTitle#</h1>
	<cfif isdefined("params.retreatid") && isOffice>
		#linkto(text="Show Registrations by option", action="list", params="retreatid=#params.retreatid#", class="btn")#
		#linkto(text="Download these names", action="index", params="retreatid=#params.retreatid#&download=true", class="btn")#
		#linkto(text="Sort by last name", action="index", params="retreatid=#params.retreatid#&bylname", class="btn")#
	</cfif>
</cfoutput>

<table class="table well">
	<tr>
		<th>
			&nbsp;
		</th>
		<th>
			Option
		</th>
		<th>
			Invoice
		</th>
		<th>
			Status
		</th>
		<th>
			Cost
		</th>
		<th>
			&nbsp;
		</th>
	</tr>
	<cfoutput query="registrations" group="registrantid">
		<tr>
			<td colspan="5">
					<h2>#linkTo(controller="focus.registrants", action="show", key=registrantid, text="#fname# #lname#", title="View this person.", class="tooltip2", officeOnly=!isOffice)# </h2>
			</td>
			<td>
				 <cfif len(roommate)>
				 	Roommate: #roommate#
				 </cfif>
			</td>
		</tr>
		<cfset emailall = emailall & ";" & email>
		<cfoutput>
			<tr>
				<cfif getStatus(ccstatus) is "Paid">
					<cfif !isDefined('amounts[description]')>
						<cfset amounts[description] = 0>
					</cfif>	
					<cfset amounts[description] = amounts[description] + cost>
					<cfif !isDefined('counts[description]')>
						<cfset counts[description] = 0>
					</cfif>
					<cfset counts[description] = counts[description] + 1>
				</cfif>	

				<td>
					&nbsp;
				</td>
				<td>
						#linkto(text=description, controller="focus.items", action="show", key=itemid, title="View this item.", class="tooltip2", officeOnly=!isOffice)#
				</td>
				<td>
						#linkto(text=orderid, controller="focus.invoices", action="show", key=val(orderid), title="View this invoice.", class="tooltip2", officeOnly=!isOffice)#
				</td>
				<td>
						#linkto(text=getStatus(ccstatus), controller="focus.invoices", action="edit", key=val(orderid), title="Edit this invoice.", class="tooltip2", officeOnly=!isOffice)#
				</td>
				<td>
					#dollarformat(cost)#
				</td>
				<cfif isOffice>
					<td>
						#editTag()#
						#deleteTag()#
					</td>
				</cfif>
			</tr>
			<cfset countRegItems(ccstatus,cost)>
		</cfoutput>
			<cfif isOffice>
				<tr>
					<td>&nbsp;</td>
					<td>
						#linkTo(text="<i class='icon-plus'></i>", action="addTo", key=registrantid, title="Add a new registration item for #fname#", class="tooltip2")#
					</td>
					<td colspan="4">&nbsp;
					</td>
				</tr>
			</cfif>

	</cfoutput>
	</table>


<cfoutput>
	<cfif isDefined("params.retreatid")>
		<p>#linkTo(text="New registration", controller="focus.shoppingcarts", action="new", params="retreatid=#params.retreatid#")#</p>
	</cfif>
</cfoutput>
<cfif showsummary>
	<div id="focusRegSummary">
		<p>Quantities All:</p>
		<table>
		<cfoutput query="registrationCounts" group="itemid">
			<tr>
				<td>#description#</td><td class="text-right">#getCount(itemid)#</td>
			</tr>
		</cfoutput>
		</table>
		<cfoutput>
		<p>
		Paid = <!---#countPaid# for--->#dollarformat(amountPaid)#<br/>
		Pending = <!---#countUnPaid# for--->#dollarFormat(amountUnPaid)# <br/>
		</p>
		<p>For invoicing:</p>
		<table>
			<cfloop collection="#counts#" item="key">
				<cfif amounts[key] LT '0'>
				<tr>
					<td>#key#</td><td class="text-right">#counts[key]#</td><td class="text-right">#dollarFormat(-amounts[key])#</td>
				</tr>
				</cfif>
			</cfloop>
		</table>
		</cfoutput>
	</div>	
</cfif>
<cfset emailall = replace(emailall,";","","one")>
<cfoutput>
	<cfif isOffice>
		<p style="margin-top:20px">
			#mailto(emailaddress=emailall, name="Email Everyone", class="btn")#
		</p>
	</cfif>
</cfoutput>
<p>&nbsp;</p>
<p>&nbsp;</p>
<cfoutput query="registrations" group="registrantid">
#fname# #lname#</br>
</cfoutput>

<!---
<cfdump var="#counts#">
<cfdump var="#amounts#">
--->