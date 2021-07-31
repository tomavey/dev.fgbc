<cfparam name="pastors" type="query">
<cfparam name="headerHtml" default="???">

<cfset count = 1>

<cfif NOT isDefined("params.download")>
	<cfoutput>
		<cfif isDefined("params.key")>
			#linkto(text="<i class='icon-download-alt'></i>", action="pastorsnotagbm", params="type=#params.key#", params=makeDownloadParamsList(), class="tooltipleft btn download", title="Download this list as an excel spreadsheet")#
		<cfelse>
			#linkto(text="<i class='icon-download-alt'></i>", action="pastorsnotagbm", params=makeDownloadParamsList(), class="tooltipleft btn download", title="Download this list as an excel spreadsheet")#
		</cfif>
	</cfoutput>
</cfif>

<cfif !isDefined("params.download")>
	<cfoutput>
		#headerHtml#
	</cfoutput>
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
		<th>District</th>
		<th>Last Payment</th>
		</tr>
<cfelse>
	<ul>
</cfif>

<cfoutput query="pastors" group="id">
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
			<td>#getDistrictName(districtid)#</td>
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
