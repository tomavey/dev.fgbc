<cfparam name="srpastors" type="query">
<cfset count = 1>
<cfif NOT isDefined("params.download")>
	<cfoutput>
		<cfif isDefined("params.key")>
			#linkto(text="<i class='icon-download-alt'></i>", action="pastorsnotagbm", key=params.key, params="download=true", class="tooltipleft btn download", title="Download this list as an excel spreadsheet")#
		<cfelse>
			#linkto(text="<i class='icon-download-alt'></i>", action="pastorsnotagbm", params="download=true", class="tooltipleft btn download", title="Download this list as an excel spreadsheet")#
		</cfif>
	</cfoutput>
</cfif>

<cfif isDefined("params.key") and params.key is "seniorpastors">
	<h3>Seniors Pastors that are not members of the AGBM</h3>
	<p class="well">
		These are Senior pastors (listed first in the handbook under the church listing) that are not current members of the AGBM. If they have been members in the past, their past payment information is shown under their name. Click the name for the handbook listing or the payment info for a payment history.
	</p>
	<cfelseif isDefined("params.key") and params.key is "staffpastors">
		<h3>Staff Pastors that are not members of the AGBM</h3>
		<p class="well">
			These are Staff pastors (have the word "Pastor" in their title and are not senior pastors) that are not current members of the AGBM. If they have been members in the past, their past payment information is shown under their name. Click the name for the handbook listing or the payment info for a payment history.
		</p>
<cfelse>
	<h3>FGBC Church Staff that are not members of the AGBM</h3>
	<p class="well">
		These are church staff that are not current members of the AGBM. If they have been members in the past, their past payment information is shown under their name. Click the name for the handbook listing or the payment info for a payment history.
	</p>
</cfif>

<cfif isDefined("params.download")>
	<table>	  
		<tr>
		<th>Last Name</th>
		<th>First Name</th>
		<th>Address1</th>
		<th>Address2</th>
		<th>City</th>
		<th>State</th>
		<th>Zip</th>
		<th>Email</th>
		<th>Phone</th>
		<th>Church</th>
		<th>Church Address1</th>
		<th>Address2</th>
		<th>Church City</th>
		<th>Church Email</th>
		<th>Church Zip</th>	
		<th>Last Payment</th>
		</tr>
<cfelse>
	<ul>
</cfif>

<cfoutput query="srpastors" group="id">
  <cfif !isAgbmmember(id,params)>
    <cfset lastpaymentinfo = getLastPayment(personid=id,formatted="false")>
    
	<cfif lastpaymentinfo contains "na">
    	<cfset showpaylink = false>
	<cfelse>	  
		<cfset showpaylink = true>
    </cfif>
    <cfif isDefined("params.download")>
		<tr>
			<td>#lname#</td>
			<td>#fname#</td>
			<td>#address1#</td>
			<td>#address2#</td>
			<td>#city#</td>
			<td>#state_mail_abbrev#</td>
			<td>#zip#</td>
			<td>#email#</td>
			<td>#phone#</td>
			<td>#name#</td>
			<td>#Handbookorganizationaddress1#</td>
			<td>#Handbookorganizationaddress2#</td>
			<td>#org_city#</td>
			<td>#Handbookorganizationstate_mail_abbrev#</td>
			<td>#Handbookorganizationzip#</td>	
			<td>
				<cfif showpaylink>#lastpaymentinfo#</cfif>
			</td>
		</tr>
	<cfelse>
		<li>#linkto(controller="handbook-people", action="show", key=id, text=fullname)#: #position# #city#, #state_mail_abbrev# 
		<cfif showpaylink>
			#linkto(
					text="(<span style='font-size:.7em'>Last memfee: #lastpaymentinfo#</span>)", 
					controller="handbook-agbm",
					action="show", 
					key=id, 
					class="tooltipside", 
					title="View payment information")#</li>
	    </cfif>			  
    <cfset count = count +1>

	</cfif>
  </cfif>
</cfoutput>

<cfif isDefined("params.download")>
	</table>
	<cfelse>
	</ul>
</cfif>

<cfoutput>
	<p>Count: #count#</p>
	<cfif NOT isDefined("params.download")>
		#linkto(text="<i class='icon-download-alt'></i>", params="download=true", class="tooltipside", title="Download this list as an excel spreadsheet")#
	</cfif>
</cfoutput>
