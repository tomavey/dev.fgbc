<!--- <cfdump var="#members#"> --->
<cfparam name="showAge" default=false>
<h3>Men who have been paid up members for 9 of the past 10 years:</h3>
<cfoutput>
  #linkto(text="<i class='icon-download-alt'></i>", action="agbm10yearmembers", params="download=true", class="tooltipleft btn download", title="Download this list as an excel spreadsheet")#
</cfoutput>     

<table>
	<thead>
		<tr>
			<th>
				<cfif showAge>
					Name/Birthyear
				<cfelse>
					Name
				</cfif>
			</th>
			<th>
				Organization
			</th>
			<th>
				District
			</th>
			<th>
				Last Payment
			</th>
			<cfif gotRights("superadmin,agbmadmin")>
			<th>
				&nbsp;
			</th>
			</cfif>			
		</tr>
	</thead>	

<cfoutput query="people">
  <cfset REQUEST.lastpayment = getLastPayment(personid)>
  <cfset REQUEST.payments = getPayments(personid)>
  #includePartial("table")#<!---Table Row--->
</cfoutput>
</table>
<cfoutput>
  <p>#people.recordCount#</p>
</cfoutput>